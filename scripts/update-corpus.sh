#!/usr/bin/env bash
# Idempotent re-fetch of the EU AI Act corpus. Plain curl, no API keys, no credentials.
# Usage: scripts/update-corpus.sh
# Polite pacing: sleep between bulk fetches. Local-only: never pushes anything.
set -uo pipefail
cd "$(dirname "$0")/.."

TODAY="$(date +%F)"
UA="Mozilla/5.0 (corpus-updater; plain curl)"
CELLAR="http://publications.europa.eu/resource/celex"
NEWSROOM="https://ec.europa.eu/newsroom/dae/redirection/document"

fetch() { # fetch <url> <outfile> [accept]
  local url="$1" out="$2" accept="${3:-}"
  mkdir -p "$(dirname "$out")"
  local args=(-sL -A "$UA" --max-time 300 -o "$out")
  [ -n "$accept" ] && args+=(-H "Accept: $accept")
  if curl "${args[@]}" "$url"; then
    echo "OK   $out ($(wc -c < "$out") bytes) from $url"
  else
    echo "FAIL $out from $url (curl exit $?)" >&2; return 1
  fi
}

pdf2md() { # pdf2md <base-without-ext> <description> <landing-url> <direct-url> <date-note>
  local base="$1" desc="$2" landing="$3" direct="$4" datenote="$5"
  local pdf="${base}.pdf" md="${base}.md"
  pdftotext -layout "$pdf" "/tmp/upd_$(basename "$base").txt" || return 1
  {
    echo "<!--"
    echo "  Document : $desc"
    echo "  Landing  : $landing"
    echo "  Direct   : $direct"
    echo "  Date     : $datenote | fetched: $TODAY"
    echo "  Note     : converted with 'pdftotext -layout'; wording preserved verbatim."
    echo "-->"
    echo; cat "/tmp/upd_$(basename "$base").txt"
  } > "$md"
  echo "OK   $md"
}

echo "== 1. AI Act (Regulation (EU) 2024/1689), CELLAR content negotiation =="
fetch "$CELLAR/32024R1689" corpus/act/regulation-eu-2024-1689.oj.html "application/xhtml+xml; Accept-Language=eng"; sleep 3
fetch "$CELLAR/32024R1689" corpus/act/regulation-eu-2024-1689.oj.pdf "application/pdf; Accept-Language=eng"
python3 scripts/html2md.py corpus/act/regulation-eu-2024-1689.oj.html corpus/act/regulation-eu-2024-1689.md
sleep 3
echo "== 1b. Digital Omnibus on AI (Regulation (EU) 2026/1744) + consolidated AI Act =="
fetch "$CELLAR/32026R1744" corpus/act/regulation-eu-2026-1744-digital-omnibus.oj.html "application/xhtml+xml; Accept-Language=eng"; sleep 3
python3 scripts/html2md.py corpus/act/regulation-eu-2026-1744-digital-omnibus.oj.html corpus/act/regulation-eu-2026-1744-digital-omnibus.md
# Consolidated version id changes with each amendment: check EUR-Lex "Current consolidated version" first.
fetch "$CELLAR/02024R1689-20260727" corpus/act/regulation-eu-2024-1689-consolidated-2026-07-27.html "application/xhtml+xml; Accept-Language=eng"; sleep 3
python3 scripts/html2md.py corpus/act/regulation-eu-2024-1689-consolidated-2026-07-27.html corpus/act/regulation-eu-2024-1689-consolidated-2026-07-27.md

echo "== 2. Commission guidelines (digital-strategy library pages -> newsroom DAE docs) =="
dl_guideline() { # dl_guideline <docid> <base> <description> <landing-url> <date-note>
  local docid="$1" base="$2" desc="$3" landing="$4" datenote="$5"
  fetch "$NEWSROOM/$docid" "corpus/guidelines/${base}.en.pdf"; sleep 2
  pdf2md "corpus/guidelines/${base}" "$desc" "$landing" "$NEWSROOM/$docid" "$datenote"
}
GL_PROHIBITED="https://digital-strategy.ec.europa.eu/en/library/commission-publishes-guidelines-prohibited-artificial-intelligence-ai-practices-defined-ai-act"
GL_DEFINITION="https://digital-strategy.ec.europa.eu/en/library/commission-publishes-guidelines-ai-system-definition-facilitate-first-ai-acts-rules-application"
GL_GPAI="https://digital-strategy.ec.europa.eu/en/library/guidelines-scope-obligations-providers-general-purpose-ai-models-under-ai-act"
GL_HIGHRISK="https://digital-strategy.ec.europa.eu/en/library/draft-commission-guidelines-classification-high-risk-ai-systems"

dl_guideline 112367 prohibited-practices-guidelines \
  "Commission Guidelines on prohibited AI practices" "$GL_PROHIBITED" "document date 29.7.2025"
dl_guideline 112366 prohibited-practices-approval-communication \
  "Commission Communication approving draft Guidelines on prohibited AI practices" "$GL_PROHIBITED" "document date 4.2.2025"
dl_guideline 112455 ai-system-definition-guidelines \
  "Commission Guidelines on the definition of an artificial intelligence system" "$GL_DEFINITION" "document date 29.7.2025"
dl_guideline 118559 ai-system-definition-approval-communication \
  "Commission Communication approving draft Guidelines on AI system definition" "$GL_DEFINITION" "document date 6.2.2025"
dl_guideline 118340 gpai-models-scope-guidelines \
  "Commission Guidelines on the scope of obligations for providers of general-purpose AI models under the AI Act" "$GL_GPAI" "document date 19.11.2025"
dl_guideline 118343 gpai-models-scope-approval-communication \
  "Commission Communication approving draft GPAI models scope guidelines" "$GL_GPAI" "document date 18.7.2025"
dl_guideline 128559 high-risk-classification-draft-general-principles \
  "DRAFT Commission Guidelines on classification of high-risk AI systems - General principles" "$GL_HIGHRISK" "draft (undated)"
dl_guideline 128560 high-risk-classification-draft-annex-i \
  "DRAFT Commission Guidelines on classification of high-risk AI systems - Annex I legislation" "$GL_HIGHRISK" "draft (undated)"
dl_guideline 128561 high-risk-classification-draft-annex-iii \
  "DRAFT Commission Guidelines on classification of high-risk AI systems - Annex III areas" "$GL_HIGHRISK" "draft (undated)"

GL_TRANSP="https://digital-strategy.ec.europa.eu/en/library/guidelines-transparency-obligations-providers-and-deployers-ai-systems"
dl_guideline 131215 transparency-art50-guidelines \
  "Commission Guidelines on the implementation of the transparency obligations for certain AI systems under Article 50 of the AI Act (Annex to C(2026) 5054 final)" "$GL_TRANSP" "document date 20.7.2026"
dl_guideline 131214 transparency-art50-approval-communication \
  "Communication to the Commission approving the content of the Article 50 transparency Guidelines, C(2026) 5054 final" "$GL_TRANSP" "document date 20.7.2026"

echo "== 3. General-Purpose AI Code of Practice (July 2025) =="
dl_cop() { # dl_cop <docid> <base> <description>
  local docid="$1" base="$2" desc="$3"
  fetch "$NEWSROOM/$docid" "corpus/gpai-code-of-practice/${base}.pdf"; sleep 2
  pdf2md "corpus/gpai-code-of-practice/${base}" \
    "General-Purpose AI Code of Practice - ${desc}" \
    "https://digital-strategy.ec.europa.eu/en/policies/contents-code-gpai" \
    "$NEWSROOM/$docid" "published 10.7.2025"
}
dl_cop 118120 gpai-code-transparency-chapter "Transparency Chapter"
dl_cop 118115 gpai-code-copyright-chapter "Copyright Chapter"
dl_cop 118119 gpai-code-safety-security-chapter "Safety and Security Chapter"

echo "== 4. Code of Practice on Transparency of AI-generated Content + adequacy assessment =="
COP_T="https://digital-strategy.ec.europa.eu/en/policies/code-practice-ai-generated-content"
COP_O="https://digital-strategy.ec.europa.eu/en/library/commission-opinion-assessment-code-practice-transparency-ai-generated-content"
dl_tcop() { # dl_tcop <docid> <base> <description> <landing> <date-note>
  fetch "$NEWSROOM/$1" "corpus/transparency-code-of-practice/$2.pdf"; sleep 2
  pdf2md "corpus/transparency-code-of-practice/$2" "$3" "$4" "$NEWSROOM/$1" "$5"
}
dl_tcop 129555 code-of-practice-transparency-ai-generated-content \
  "Code of Practice on Transparency of AI-Generated Content" "$COP_T" "see document; Commission adequacy opinion 8.7.2026"
dl_tcop 130913 commission-opinion-transparency-code \
  "Commission Opinion on the assessment of the Code of Practice on Transparency of AI-generated content, C(2026) 4839 final" "$COP_O" "document date 8.7.2026"
dl_tcop 130916 ai-board-adequacy-assessment-transparency-code \
  "AI Board conclusion on the assessment of the Code of Practice on Transparency of AI-generated content (Art. 50(7))" "$COP_O" "see document"

echo "== done =="
echo "Related-legislation and national-implementations are pointer/log files — nothing to re-fetch."
echo "Standards: JTC21 work programme is bot-gated; see corpus/standards/index.md before retrying."
