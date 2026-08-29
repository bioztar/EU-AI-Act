# Adversarial Review — 2026-08-29

Written before this repo goes public on LinkedIn. Two personas: a sceptical EU AI Act
lawyer looking for a reason to say "that's not what that article says," and a competing
compliance consultant looking for a reason to say "ours is better." Every attack below
gets a verdict — **fixed here**, **worth doing next** (real gap, out of scope for one
session), or **rejected** (with reason). Findings are ordered by how much they'd actually
cost Vitaly if a reader found them first.

---

## 1. The timeline read as a countdown to law that already happened

**The attack (lawyer):** "Your own tables say the Annex III high-risk regime 'applies
from 2 Aug 2026.' It's 29 Aug 2026. You're either four weeks out of date or you don't
realise your own deadline already passed. Which is it?"

This was real. `analysis/timeline-compliance-dates.md`, `analysis/risk-tier-classifier.md`,
`analysis/obligations-matrix.md`, and their `skill/references/` mirrors all used "applies
from 2 Aug 2026" / "from 2 Aug 2025" phrasing throughout — accurate as *law*, but written
in a tense that reads as future to anyone skimming on the date this repo is being promoted.
A reader (or an agent running the skill against a live codebase) could walk away thinking
the Annex III regime, Art. 50 transparency duties, GPAI Chapter V obligations, and the
governance/penalties infrastructure are still upcoming, when they've been binding law for
almost a month. For a consulting deliverable whose entire value proposition is "we track
the calendar for you," getting the calendar's own tense wrong is the one mistake a
competitor would lead with.

**Verdict: fixed here.** Added an explicit "Status check (2026-08-29)" line to the top of
`timeline-compliance-dates.md` / `skill/references/timeline.md`, `risk-tier-classifier.md`
(+ mirror), and `obligations-matrix.md` (+ mirror `obligations-by-role.md`) stating plainly
that everything through 2 Aug 2026 is already in force and only the Annex I product path
(2 Aug 2027) and the 2030/2031 legacy dates remain future. Also reworded
`analysis/gap-checklists/product-idea.md` item B3, which asked "can you be
conformity-assessment-ready *before* [2 Aug 2026]" — the honest question today is whether
you're compliant *now*. Did not rewrite every individual date mention in every file (dozens
of occurrences) — the top-of-file status banner is the fix that scales; a reader who skips
it and reads only a mid-document date in isolation is a much smaller residual risk than the
one just closed.

---

## 2. Twenty-five of twenty-seven national authorities are "reported," a year past their own legal deadline

**The attack (competitor):** "Article 70 required every Member State to publish its
contact point by 2 August 2025 — thirteen months ago. Your table still says 'reported'
for 25 of 27 countries, sourced to a single web-search pass from 2026-08-25. I called three
ministries. You didn't call any."

This is a real, only-partially-closed gap. The freshness pass this session re-verified and
upgraded six countries with primary/official sourcing (Germany → Bundesnetzagentur via the
KI-MIG law in force 29 Jul 2026; France → CNIL formally designated; Italy → implementing
decrees preliminarily approved; Ireland → Regulation of AI Act 2026 signed 21 Jul 2026;
Denmark → Digitaliseringsstyrelsen, not the previously-reported Datatilsynet; Netherlands →
draft Implementation Act published but not yet enacted). The other 21 entries are unchanged
"reported" status from the 2026-08-25 build, honestly labeled as such with a status legend
and an explicit "verify before relying on any `reported` entry" instruction already in the
file header — this repo doesn't hide the gap, but it also hasn't closed it.

**Verdict: partially fixed here** (6 of 27 upgraded with sourced, dated confirmation);
**worth doing next** for the remaining 21 — each needs an actual check of that state's
official gazette or a working (non-bot-gated) search path, which this session's tooling
couldn't do for all 27 in the time available. The table's own legend and the
`national-implementations/index.md` freshness note already say this plainly — that framing
is the right one to keep, not something to paper over with false confidence.

---

## 3. High-risk classification guidelines missed their own statutory deadline — and this repo now says so, which is a strength

**The attack (lawyer):** "Art. 6(5) required the Commission to adopt these guidelines by
2 February 2026. Are you telling me they're still draft, seven months late, and you're
citing a consultation document as if it were law?"

Checked today: yes, still draft. Published as a draft on 19 May 2026 (itself 3.5 months
after the statutory deadline), targeted consultation closed 23 July 2026, no adoption date
set. `corpus/SOURCES.md` and all three `corpus/guidelines/high-risk-classification-draft-*.md`
headers now say this explicitly, dated. The risk-tier classifier already labelled these as
"draft Commission guidelines (persuasive until finalised)" rather than binding — that
framing was already correct before this pass; what changed is the freshness date attached
to "still draft."

**Verdict: rejected as an attack** — the repo's own framing (guidelines are persuasive, not
binding; Article text governs) already inoculates against this, and the draft status is now
dated and explicit rather than silently stale. No further fix needed.

---

## 4. AESIA — the one country this repo calls out by name as "first formally designated" is the one we can't reach

**The attack (lawyer):** "You cite AESIA as Spain's authority, but your own corpus admits
the primary site doesn't load. What are you actually citing?"

True on both counts: AESIA is genuinely the best-documented national designation in this
corpus (Royal Decree 817/2023, widely and consistently reported), and `aesia.gob.es` is
still unreachable from this environment — a plain connection failure on 2026-08-25 became a
TLS certificate-signature failure on 2026-08-29, which if anything suggests a problem on the
agency's side, not just network flakiness on ours. The freshness pass cross-confirmed the
designation via secondary sources (Wikipedia ES, Spain's official `espanadigital.gob.es`
measure page, several 2026 law-firm compliance guides) — consistent, but not a primary-source
check, and the file says so.

**Verdict: rejected as fixable here** — this session genuinely cannot reach the primary
site; the honest move is exactly what's in the file (dated retry, documented failure mode,
secondary-source cross-check labelled as such, not as a citation). **Worth doing next**:
retry from a different network/egress the next time this repo is refreshed.

---

## 5. Zero of 160 external URLs needed fixing — legitimate, but worth stating why

**The attack (competitor):** "A link-check script that finds nothing wrong on a
year-old corpus either means the corpus is unusually solid, or the check is too weak to
find anything."

Fair challenge to pre-empt. The script (`scripts/check-links.sh`) checked all 160 unique
external URLs across every tracked `.md`/`.html`/`.sh`/`.py` file, with HEAD-then-GET
fallback and a 15s timeout — not a weak check. 19 came back dead/blocked and 3 unreachable;
manually triaged every one in `scripts/link-check-report-2026-08-29.md`. None were
repo-authored citations pointing a reader at a broken canonical source: two were false
positives from base-URL script variables, one was a prose description (not a link), one was
an HTML namespace artifact, two were already-known CEN-CENELEC bot-gating, three were the
already-documented AESIA failure, one was an already-self-documented 404 finding from the
Germany probe log, seven were footnote URLs truncated by PDF→Markdown line-wrapping inside
*verbatim* Commission guideline text (not ours to rewrite per "don't invent legal content"),
two were DOI/publisher 403s consistent with bot-blocking rather than genuine deadness, and
one (a Belgian crisis-centre footnote inside the verbatim guideline text) is a real 404 in
primary-source text that this repo correctly leaves untouched rather than silently editing
official government text.

**Verdict: rejected as an attack** — the null result is explained, not asserted, and the
explanation is auditable in the report. **Worth doing next**: the seven truncated-footnote
URLs are a known conversion artifact (the corpus mission already flagged a related
Annex I list-conversion bug) — a future corpus refresh could re-run `html2md.py` against the
`.oj.html`/PDF siblings with better line-unwrapping to recover full footnote URLs, the same
fix pattern already used once for the Annex I content-drop bug.

---

## 6. The skill's cross-harness duplication is a silent-drift risk

**The attack (lawyer, on maintainability):** "Your `analysis/` files and
`skill/references/` files look identical — are they actually kept in sync, or will they
quietly diverge the next time someone edits one and forgets the other?"

Checked: `analysis/*.md` and their `skill/references/` counterparts are byte-identical
(confirmed via diff) for every pair except `automation-agent.md`, where the only difference
is relative path prefixes (`analysis/...` vs `../...`) required by the skill's
self-contained-directory contract — a correct, intentional divergence, not drift. There is
no automated check enforcing this sync going forward, though; a future edit to one copy
without the other would silently produce a report-vs-reference mismatch that nothing in
this repo would catch.

**Verdict: worth doing next** — a one-line CI or pre-commit check (`diff` each pair, ignoring
known path differences) would catch drift cheaply. Not built here: this mission's mandate is
validate-and-fix, not add new tooling infrastructure, and building an unrequested CI check
is exactly the kind of speculative addition this repo's own engineering conventions would
flag.

---

## 7. README now states audience and a 5-minute path; the disclaimer question is settled correctly

**The attack (competitor):** "Who is this actually for? A lawyer, an engineer, or an
agent? And can I get value without installing anything?"

Before this pass, the README explained *what* the repo was well but never said *who* should
read which layer, and its only "get started" path was `git clone` + install a skill — no
route for a reader who just wants to read. It also placed a "not legal advice" disclaimer
exactly once, which the mission brief specifically wanted (many competing compliance repos
either bury this or repeat it defensively on every page — neither reads well).

**Verdict: fixed here.** Added a "Who this is for" section naming three reader types
(compliance/legal, engineering leads, agent users) and a stated 5-minute, no-install path
(`analysis/risk-tier-classifier.md` read cold). Replaced the `git clone <this repo>`
placeholder with the real GitHub URL. Updated the disclaimer's freshness date and pointed it
at this review + the link-check report rather than leaving a static "as of 2026-08-25" claim
that would itself go stale the moment this mission lands. The single-disclaimer placement
was already correct and is unchanged.

---

## 8. What a competing consultant's material would still beat this on

**The attack (competitor, honest self-assessment):** live-updating trackers (several law
firms and the EU AI Act Explorer-style sites) show a "last verified" timestamp per page and
re-run automatically; this repo is a point-in-time corpus with no stated refresh cadence
beyond "run `scripts/update-corpus.sh` manually."

**Verdict: worth doing next, not rejected.** This is a legitimate structural difference, not
a factual error — fixing it means either standing up scheduled re-validation (a `/loop` or
cron-driven re-run of this same validate mission) or explicitly stating the refresh cadence
Vitaly intends to commit to. Out of scope to build in this mission (adding automation
infrastructure wasn't requested and the mission's own scope was validate-and-fix, not
build-new-capability), but it's the single highest-value thing to decide before heavy
promotion, since every fact in this repo has a shelf life and none of them currently say so
except the two dated freshness/link reports this mission adds.

---

## Backlog (prioritised)

1. Verify the remaining 21 "reported" national authorities against primary sources
   (official gazettes / national contact-point lists) — Art. 70's own deadline is over a
   year past.
2. Decide and state a refresh cadence for this repo (manual quarterly re-run of this
   validation mission, or a scheduled agent loop) and put a "content current as of" banner
   somewhere durable (e.g. README) that updates with each refresh instead of being edited
   by hand each time.
3. Retry AESIA (aesia.gob.es) from a different network path at the next refresh.
4. Add a lightweight sync check between `analysis/*.md` and `skill/references/*.md` pairs
   so future edits to one can't silently drift from the other.
5. Re-run `html2md.py` against the `.oj.html`/PDF corpus siblings with improved line-
   unwrapping to recover the ~7 footnote URLs currently truncated mid-word by the existing
   conversion (same class of bug as the Annex I list-content drop fixed in the corpus
   mission).
6. Re-check `digital-strategy.ec.europa.eu` periodically for the final (non-draft)
   high-risk classification guidelines — still draft as of 2026-08-29, seven months past
   the Art. 6(5) statutory deadline.
