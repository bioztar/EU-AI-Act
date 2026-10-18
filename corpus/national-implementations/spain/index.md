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

## Update (checked 2026-10-18)
Primary sources fetched 2026-10-18:
- **AESIA statute** — Real Decreto 729/2023, de 22 de agosto, por el que se aprueba el Estatuto de
  la Agencia Española de Supervisión de Inteligencia Artificial (BOE-A-2023-18911, published
  2 Sep 2023): https://www.boe.es/buscar/act.php?id=BOE-A-2023-18911
- **Correction:** the note above ("created 2023, Royal Decree 817/2023") was wrong. Real Decreto
  817/2023, de 8 de noviembre (BOE-A-2023-22767) establishes the *entorno controlado de pruebas*
  (AI regulatory sandbox) for the then-proposed AI Act, not AESIA:
  https://www.boe.es/buscar/doc.php?id=BOE-A-2023-22767
- **Commission SPOC list** (https://digital-strategy.ec.europa.eu/en/policies/market-surveillance-authorities-under-ai-act):
  Spain → "Agencia Española de Supervisión de Inteligencia Artificial", marked `*` = "the national
  designation decision is still pending final adoption". So the "first formally designated" claim
  above is not supported by the Commission's own list; treat as reported only.
- **Spanish AI law — status: PROPOSED (anteproyecto), not enacted.** Consejo de Ministros of
  11 March 2025 approved the "Anteproyecto de Ley para el buen uso y la gobernanza de la
  Inteligencia Artificial" "a los efectos previstos en el artículo 26.4 de la Ley 50/1997" (first
  reading) and authorised urgent processing:
  https://www.lamoncloa.gob.es/consejodeministros/referencias/paginas/2025/20250311-referencia-rueda-de-prensa-ministros.aspx
  A BOE consolidated-legislation search (open-data API, title contains "inteligencia artificial")
  on 2026-10-18 returned no national AI law — only RD 729/2023 and unrelated items. Whether the
  text has been approved as a *proyecto de ley* and sent to the Cortes could not be confirmed
  (congreso.es search returned no usable result) — open item.
- aesia.gob.es: still no response from this network (curl exit/000) on 2026-10-18.
