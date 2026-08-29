#!/usr/bin/env bash
# Sweep every external URL in the repo and check its live HTTP status.
# Plain curl, no API keys, no credentials. Idempotent: re-run any time.
# Bash 3.2 compatible (macOS system bash has no associative arrays).
# Usage: scripts/check-links.sh [> scripts/link-check-report-YYYY-MM-DD.md]
set -uo pipefail
cd "$(dirname "$0")/.."

TIMEOUT=15
UA="Mozilla/5.0 (compatible; EU-AI-Act-link-check/1.0)"
TODAY="$(date +%F)"
PAIRS_FILE="$(mktemp)"
trap 'rm -f "$PAIRS_FILE"' EXIT

# --- 1. extract every http(s) URL from git-tracked files, as file:URL pairs ---
git ls-files -- '*.md' '*.html' '*.sh' '*.py' \
  | xargs grep -no -E 'https?://[^][ "'"'"'<>()`]+' \
  | sed -E 's/^([^:]+):[0-9]+:/\1:/; s/[.,;:]+$//' \
  | sort -u > "$PAIRS_FILE"

urls_file="$(mktemp)"
trap 'rm -f "$PAIRS_FILE" "$urls_file"' EXIT
sed -E 's/^[^:]+:(https?:.*)$/\1/' "$PAIRS_FILE" | sort -u > "$urls_file"

# --- 2. check one URL: HEAD, fall back to GET if blocked (many EU sites 403 HEAD) ---
# prints: "<status> <effective_url>" or "SKIP <reason>" or "ERR <reason>"
check_url() {
  local url="$1" out status

  # never probe a URL that carries a credential/API key in its query string
  if echo "$url" | grep -qiE '[?&](api[_-]?key|apikey|access[_-]?token|token|secret|password)='; then
    echo "SKIP requires-credential"
    return
  fi

  out=$(curl -sS -o /dev/null -m "$TIMEOUT" -A "$UA" -L \
        -w '%{http_code} %{url_effective}' -I "$url" 2>/dev/null)
  status="${out%% *}"

  if [ -z "$status" ] || [ "$status" = "000" ] || { [ "$status" -ge 400 ] 2>/dev/null; }; then
    out=$(curl -sS -o /dev/null -m "$TIMEOUT" -A "$UA" -L \
          -w '%{http_code} %{url_effective}' -X GET "$url" 2>/dev/null)
    status="${out%% *}"
  fi

  if [ -z "$status" ] || [ "$status" = "000" ]; then
    echo "ERR connection-failed-or-timeout"
  else
    echo "$out"
  fi
}

total=$(wc -l < "$urls_file" | tr -d ' ')
ok=0 redirected=0 dead=0 skipped=0 err=0

echo "# Link check report — $TODAY"
echo
echo "Checked $total unique external URLs. HEAD, falling back to GET on 4xx/5xx/blocked HEAD."
echo
echo "| URL | File(s) | Status | Notes |"
echo "|---|---|---|---|"

while IFS= read -r url; do
  [ -n "$url" ] || continue
  files=""
  while IFS=: read -r pfile purl; do
    [ "$purl" = "$url" ] || continue
    case ",$files," in *",$pfile,"*) ;; *) files="${files:+$files,}$pfile" ;; esac
  done < "$PAIRS_FILE"
  result=$(check_url "$url")

  case "$result" in
    SKIP*)
      skipped=$((skipped+1))
      note="skipped — ${result#SKIP }"
      status="—"
      ;;
    ERR*)
      err=$((err+1))
      note="${result#ERR }"
      status="ERR"
      ;;
    *)
      status="${result%% *}"
      final_url="${result#* }"
      if [ "$status" -ge 200 ] 2>/dev/null && [ "$status" -lt 300 ]; then
        ok=$((ok+1))
        if [ "$final_url" != "$url" ]; then
          redirected=$((redirected+1))
          note="redirected → $final_url"
        else
          note="ok"
        fi
      elif [ "$status" -ge 400 ] 2>/dev/null; then
        dead=$((dead+1))
        note="dead"
      else
        note="unexpected status"
      fi
      ;;
  esac

  echo "| $url | $files | $status | $note |"
done < "$urls_file"

echo
echo "## Summary"
echo
echo "- Total unique URLs: $total"
echo "- OK (2xx): $ok (of which redirected to a different final URL: $redirected)"
echo "- Dead (4xx/5xx): $dead"
echo "- Connection error/timeout: $err"
echo "- Skipped (needs credential): $skipped"
