# EU-AI-Act

Full corpus of Regulation (EU) 2024/1689 (the EU AI Act) and its surrounding
knowledge — guidelines, national implementations, standards landscape — a
structured analysis layer distilled from it, and a cross-harness compliance
skill built on both.

## Who this is for

- **Compliance / legal reviewers** who want every claim traceable to a binding
  article — no reading required beyond `analysis/`; every line cites Art./Annex/Rec.
- **Engineering leads** who want concrete build patterns (log schema, oversight
  UI, doc pipeline) instead of legal prose — `analysis/design-recommendations.md`.
- **Anyone running an AI coding agent** (Claude Code, Pi, Codex, similar) who
  wants that agent to self-check a codebase, design doc, or product idea against
  the Act — install `skill/` and ask it to.

Five minutes, no install: open `analysis/risk-tier-classifier.md`, walk it against
your system, land on a tier with citations. That's the whole product in one file.

## What this is

Three layers, strictly ordered:

1. **`corpus/`** — raw sources (EUR-Lex + Commission + member-state texts).
   The regulation itself, Commission guidelines (prohibited practices, AI-system
   definition, GPAI scope, draft high-risk classification), the GPAI Code of
   Practice, per-member-state authority/transposition notes, related-legislation
   pointers. Provenance for every file in `corpus/SOURCES.md`; refresh via
   `scripts/update-corpus.sh`.
2. **`analysis/`** — structured deep-analysis outputs: risk-tier decision tree,
   obligations matrix by role × tier, compliance timeline, penalties &
   enforcement mechanics, engineering design recommendations, and gap checklists
   for four artifact types.
3. **`skill/`** — the installable, self-contained **EU AI Act compliance skill**
   (`eu-ai-act-compliance`). Any agent that reads SKILL.md conventions — Claude
   Code, Pi, Codex, anything similar — can invoke it against any input (a
   codebase, design doc, product idea, or automation concept) and get a
   structured report: classification, severity-ranked gaps, required actions,
   design recommendations. Token-economical by construction: a small entry file
   points down a hierarchy; deeper references are read only when the case
   requires them.

## Quickstart

Clone this repo, run the install script (symlinks `skill/` into every harness
skill directory that exists), then tell your agent:

```
git clone https://github.com/bioztar/EU-AI-Act.git && cd EU-AI-Act && ./scripts/install-skill.sh --all
```

then in your agent session:

> run eu-ai-act compliance on this codebase / design doc / idea

The agent walks intake → role determination → risk-tier classification → gap
analysis → report, using only as much of the reference material as the case
demands.

## Repo map

```
corpus/                  raw source documents (do not treat as analysis)
  act/                   Regulation (EU) 2024/1689 full text, Omnibus 2026/1744, consolidated text
  guidelines/            Commission guidelines & drafts
  gpai-code-of-practice/ AI Office GPAI Code (3 chapters + doc form)
  transparency-code-of-practice/  Art. 50 code + Commission/Board adequacy assessment
  national-implementations/  27 member-state authority notes
  related-legislation/   GDPR, Data Act, machinery, PLD pointers
  standards/             harmonised-standards landscape pointers
  SOURCES.md             provenance for everything above
analysis/                reviewed distillations (the skill's source material)
skill/                   installable skill (self-contained; no paths escaping it)
scripts/                 update-corpus.sh, html2md.py, install-skill.sh
```

## Disclaimer

Informational analysis, not legal advice. Corpus fetched 2026-08-25, spot-checked
and re-verified against primary sources 2026-08-29; freshness pass 2026-10-18 added the
Digital Omnibus on AI (Regulation (EU) 2026/1744) and updated dates throughout (see
`scripts/freshness-report-2026-10-18.md`, `scripts/link-check-report-2026-10-18.md`,
`docs/adversarial-review-2026-08-29.md` and `scripts/link-check-report-2026-08-29.md`
for what changed and what's still open). Verify current law and designated national
authorities before relying on any output in a binding context.
