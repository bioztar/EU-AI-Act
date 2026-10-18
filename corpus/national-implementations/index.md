# National implementations — one subdirectory per EU member state

The EU AI Act is a Regulation and applies directly; "implementation" at national level means
(1) designation of AI Act supervisory/market-surveillance/notifying authorities and
(2) complementary national AI framework laws.

## Status legend
- **fetch-verified**: URL probed with curl during this mission; HTTP status recorded.
- **reported/unverified**: widely reported designation, not verified against an official
  source yet. Every file states what was searched and when, per corpus policy.

## Directories
Spain, Italy, France, Germany, Denmark, Netherlands, Ireland carry fetch-verified probe logs
from 2026-08-25. Remaining 19 states document search constraints + reported designations.

All entries fetched/searched: 2026-08-25. A later mission should re-run probes with working
search infrastructure and replace unverified claims with cited sources.

**Update (checked 2026-08-29):** Germany and Spain re-checked this pass — see their index.md
files. Germany's authority designation is now confirmed enacted (Bundesnetzagentur via KI-MIG,
29 Jul 2026). Spain's AESIA designation is cross-confirmed by secondary sources but the primary
aesia.gob.es site is still unreachable (TLS certificate failure this time, vs. connection failure
on 2026-08-25). The remaining 25 member states were not re-verified in this pass — still open for
a later mission per the note above.

**Update (checked 2026-10-18):** the Commission's list of market-surveillance single points of
contact (https://digital-strategy.ec.europa.eu/en/policies/market-surveillance-authorities-under-ai-act,
fetched 2026-10-18) is now the primary cross-check for all 27 states; it is reproduced in
`skill/references/national-authorities.md` (SPOC column). It lists 21 states (11 marked `*`,
designation pending final adoption) and no entry for Austria, Belgium, Bulgaria, Croatia, Hungary
and Slovakia. Spain re-checked against BOE (see spain/index.md; RD number corrected). Per-state
files other than Spain were not otherwise re-probed this pass.
