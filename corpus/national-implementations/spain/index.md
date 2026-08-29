<!-- searched/fetched: 2026-08-25 -->
# Spain — AI Act transposition status & national AI authority

## Fetch log (2026-08-25)
- https://www.aesia.gob.es/ and https://aesia.gob.es/ — **unreachable from this network**
  (connection failed twice). Not verified today.

## Retry (checked 2026-08-29)
- https://www.aesia.gob.es/ and http://www.aesia.gob.es/ — still not reachable: this time the
  site resolves but fails TLS with **"certificate signature failure"** (different failure mode
  than 2026-08-25's plain connection failure — the network path to the domain now gets further,
  but the cert chain doesn't validate from this agent's environment). Direct `curl` from Bash to
  aesia.gob.es also returned no response (exit/000) within a 15s timeout. Still not independently
  verified against the primary site.
- Cross-checked via web search instead (secondary sources, not primary): AESIA's designation as
  Spain's AI Act reference authority (coordinating with AEPD and sectoral bodies), HQ A Coruña +
  Madrid office, created 2023 (statutes approved 22 Aug 2023), is consistently reported across
  multiple 2026 sources (es.wikipedia.org/wiki/Agencia_Española_de_Supervisión_de_la_Inteligencia_Artificial,
  espanadigital.gob.es/en/measure/aesia, and several Spanish AI-Act law-firm/compliance guides
  dated 2026). This corroborates but does not replace a primary-source check.

## Known / reported (TO BE VERIFIED in a later mission)
- AESIA (Agencia Española de Supervisión de la Inteligencia Artificial, HQ A Coruña) is widely
  reported as the first EU member state to be formally designated an AI supervisory authority
  under the AI Act (created 2023, Royal Decree 817/2023).
- Transposition: the AI Act is a Regulation — direct application, no national transposition act
  required; national acts concern designation of market surveillance/notified bodies.

## What should be checked next
- aesia.gob.es availability from a different network; BOE for designation instruments.
