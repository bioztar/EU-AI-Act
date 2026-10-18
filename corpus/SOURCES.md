# Corpus sources index

Every corpus artifact with path → source → format → fetch date. Fetched with plain curl,
no credentials. Re-fetch via `scripts/update-corpus.sh`.

Fetched on: 2026-08-25 (see per-file headers for individual dates if refetched later).

## corpus/act/

| Path | Source | Format |
|---|---|---|
| regulation-eu-2024-1689.oj.html | http://publications.europa.eu/resource/celex/32024R1689 (Accept: application/xhtml+xml) | XHTML |
| regulation-eu-2024-1689.oj.pdf | http://publications.europa.eu/resource/celex/32024R1689 (Accept: application/pdf) | PDF, 144 pp |
| regulation-eu-2024-1689.md | converted from .oj.html via scripts/html2md.py | Markdown |

| regulation-eu-2026-1744-digital-omnibus.oj.html | http://publications.europa.eu/resource/celex/32026R1744 (Accept: application/xhtml+xml) — fetched 2026-10-18 | XHTML |
| regulation-eu-2026-1744-digital-omnibus.md | converted via scripts/html2md.py | Markdown |
| regulation-eu-2024-1689-consolidated-2026-07-27.html | http://publications.europa.eu/resource/celex/02024R1689-20260727 (Accept: application/xhtml+xml) — fetched 2026-10-18 | XHTML |
| regulation-eu-2024-1689-consolidated-2026-07-27.md | converted via scripts/html2md.py | Markdown |

CELEX 32024R1689 — Regulation (EU) 2024/1689, OJ L series 12.7.2024 (original text, kept unchanged).
CELEX 32026R1744 — Regulation (EU) 2026/1744 "Digital Omnibus on AI", OJ L, 2026/1744, 24.7.2026,
in force 27.7.2026 (ELI http://data.europa.eu/eli/reg/2026/1744/oj). **Adopted & in force.**
Consolidated text 02024R1689-20260727 is a documentation tool with no legal effect (EUR-Lex
disclaimer); the OJ texts are authentic. Use the consolidated file for "current wording" look-ups.
Also noted, **proposed** (Commission proposal, not adopted law): COM(2025) 1023 (EUR-Lex 52025PC1023),
amending the medical-devices Regulations (EU) 2017/745 and 2017/746; its EUR-Lex page references
Regulation (EU) 2024/1689 — whether and how it amends the AI Act was not analysed this pass (open item).
Verified complete: 180 recitals, 113 articles, Annexes I–XIII.

## corpus/guidelines/

| Path | Landing page | Direct document |
|---|---|---|
| prohibited-practices-guidelines.en.pdf/.md | digital-strategy.ec.europa.eu/en/library/commission-publishes-guidelines-prohibited-artificial-intelligence-ai-practices-defined-ai-act | newsroom/dae/redirection/document/112367 |
| prohibited-practices-approval-communication.en.pdf/.md | same | document/112366 |
| ai-system-definition-guidelines.en.pdf/.md | digital-strategy.ec.europa.eu/en/library/commission-publishes-guidelines-ai-system-definition-facilitate-first-ai-acts-rules-application | document/112455 |
| ai-system-definition-approval-communication.en.pdf/.md | same | document/118559 |
| gpai-models-scope-guidelines.en.pdf/.md | digital-strategy.ec.europa.eu/en/library/guidelines-scope-obligations-providers-general-purpose-ai-models-under-ai-act | document/118340 |
| gpai-models-scope-approval-communication.en.pdf/.md | same | document/118343 |
| high-risk-classification-draft-general-principles.en.pdf/.md | digital-strategy.ec.europa.eu/en/library/draft-commission-guidelines-classification-high-risk-ai-systems | document/128559 |
| high-risk-classification-draft-annex-i.en.pdf/.md | same | document/128560 |
| high-risk-classification-draft-annex-iii.en.pdf/.md | same | document/128561 |
| transparency-art50-guidelines.en.pdf/.md | digital-strategy.ec.europa.eu/en/library/guidelines-transparency-obligations-providers-and-deployers-ai-systems | document/131215 (Annex to C(2026) 5054, 20.7.2026) — fetched 2026-10-18 |
| transparency-art50-approval-communication.en.pdf/.md | same | document/131214 — fetched 2026-10-18 |

All direct documents under `ec.europa.eu/newsroom/dae/redirection/document/<id>` (base path, not a page).
Note: high-risk classification guidelines exist only as draft consultation versions as of fetch date
(2026-08-25). Checked again 2026-08-29 against digital-strategy.ec.europa.eu: still draft — published
19 May 2026 (missing the Art. 6(5) 2 Feb 2026 statutory deadline), targeted stakeholder consultation
ran through 23 July 2026, page last updated 23 July 2026, no adoption/finalisation date shown. No
final (non-draft) version has been published as of 2026-08-29; re-check
https://digital-strategy.ec.europa.eu/en/library/draft-commission-guidelines-classification-high-risk-ai-systems
periodically and replace these three files when it lands. **Re-checked 2026-10-18: still titled
"Draft Commission guidelines…", page last update 23 July 2026 — no final version.**
Final GPAI-scope and AI-system-definition guidelines carry later revision dates than their
approval communications (documents are self-dated in their headers).

## corpus/gpai-code-of-practice/

Landing page: https://digital-strategy.ec.europa.eu/en/policies/contents-code-gpai
Published 10 July 2025 by the AI Office. See directory index.md for details.

| Path | Source |
|---|---|
| gpai-code-transparency-chapter.pdf/.md | https://ec.europa.eu/newsroom/dae/redirection/document/118120 |
| gpai-code-copyright-chapter.pdf/.md | https://ec.europa.eu/newsroom/dae/redirection/document/118115 |
| gpai-code-safety-security-chapter.pdf/.md | https://ec.europa.eu/newsroom/dae/redirection/document/118119 |
| gpai-code-model-documentation-form.docx | https://ec.europa.eu/newsroom/dae/redirection/document/118118 |

## corpus/transparency-code-of-practice/

Fetched 2026-10-18. Landing pages: https://digital-strategy.ec.europa.eu/en/policies/code-practice-ai-generated-content
and https://digital-strategy.ec.europa.eu/en/library/commission-opinion-assessment-code-practice-transparency-ai-generated-content

| Path | Source |
|---|---|
| code-of-practice-transparency-ai-generated-content.pdf/.md | https://ec.europa.eu/newsroom/dae/redirection/document/129555 |
| commission-opinion-transparency-code.pdf/.md | document/130913 (C(2026) 4839 final, 8.7.2026) |
| ai-board-adequacy-assessment-transparency-code.pdf/.md | document/130916 |

## corpus/related-legislation/
Pointer files only (no full text fetched). CELEX + EUR-Lex links + interplay notes inside each file:
gdpr-regulation-2016-679.md, product-liability-directive-85-374-eec.md,
machinery-regulation-2023-1230.md, data-act-regulation-2023-2854.md, index.md.

## corpus/national-implementations/
27 member-state directories, each with an index.md logging what was searched and when
(2026-08-25). Spain/Italy/France/Germany/Denmark/Netherlands/Ireland include curl probe results.
No external files fetched.

## corpus/standards/
| Path | Source | Format |
|---|---|---|
| cen-cenelec-artificial-intelligence-page.html | https://www.cencenelec.eu/areas-of-work/cen-cenelec-topics/artificial-intelligence/ (HTTP 200) | HTML snapshot |
| index.md | JTC 21 landscape; work-programme listing was bot-gated (406/500) — flagged unverified | Markdown |

## Fetch notes
- EUR-Lex web pages returned a JS bot-gate (TodayOJ redirect) for all document URLs during this
  session; CELLAR content-negotiation endpoints worked and are the primary act source.
- Commission guidelines/CoP live on ec.europa.eu/newsroom DAE document redirection IDs.
