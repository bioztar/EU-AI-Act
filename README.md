# EU-AI-Act

Full corpus of Regulation (EU) 2024/1689 (the EU AI Act) and its surrounding
knowledge — guidelines, national implementations, standards landscape — a
structured analysis layer distilled from it, and a cross-harness compliance
skill built on both.

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
git clone <this repo> && cd EU-AI-Act && ./scripts/install-skill.sh --all
```

then in your agent session:

> run eu-ai-act compliance on this codebase / design doc / idea

The agent walks intake → role determination → risk-tier classification → gap
analysis → report, using only as much of the reference material as the case
demands.

## Repo map

```
corpus/                  raw source documents (do not treat as analysis)
  act/                   Regulation (EU) 2024/1689 full text
  guidelines/            Commission guidelines & drafts
  gpai-code-of-practice/ AI Office GPAI Code (3 chapters + doc form)
  national-implementations/  27 member-state authority notes
  related-legislation/   GDPR, Data Act, machinery, PLD pointers
  standards/             harmonised-standards landscape pointers
  SOURCES.md             provenance for everything above
analysis/                reviewed distillations (the skill's source material)
skill/                   installable skill (self-contained; no paths escaping it)
scripts/                 update-corpus.sh, html2md.py, install-skill.sh
```

## Disclaimer

Informational analysis, not legal advice. Corpus reflects sources fetched
2026-08-25; verify current law and designated national authorities before
relying on any output in a binding context.
