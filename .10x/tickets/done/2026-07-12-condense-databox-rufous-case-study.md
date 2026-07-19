Status: done
Created: 2026-07-12
Updated: 2026-07-12
Parent: None
Depends-On: .10x/tickets/done/2026-07-12-write-databox-rufous-technical-case-study.md

# Condense the Databox-to-Rufous case study

## Scope

Reduce `content/posts/databox-rufous-warehouse/index.md` from roughly 1,650 words to approximately 900 words without weakening its approved technical argument:

parallel Quack ingestion → reviewed semantic workflow → SQLMesh business models → Rufous reference consumer.

Keep the two diagrams and two proof images. Compress or remove repetitive explanations, procedural substeps, and broad caveat repetition. Retain the AVONET parallel-refresh exception, Rufous reference-consumer caveat, source-contract hardening conclusion, and final limitations.

## Acceptance criteria

1. Article body is approximately 800–1,000 words, excluding metadata/captions/diagram source.
2. The causal argument remains technically accurate and source-backed.
3. Diagrams/images retain their placement and captions; no layout or accessibility regression is introduced.
4. Hugo build succeeds and rendered article is materially shorter without becoming a list of assertions.

## Exclusions

- No new claims, images, diagrams, or broad design changes.
- No loss of the AVONET exception, reference-consumer distinction, or stated limitations.

## Blockers

None. User explicitly requested a substantially less text-heavy article.

## Progress and notes

- 2026-07-12: Current article is approximately 1,650 words; target is a concise technical case study around 900 words.
- 2026-07-12: Condensed prose to 797 words excluding metadata, code, Mermaid source, and figures/captions. Preserved the two proof images, Quack diagram, desktop/mobile semantic workflow renderings, AVONET exception, Rufous reference-consumer caveat, hardening conclusion, and limits. Isolated Hugo build passed for 160 pages. Evidence: `.10x/evidence/2026-07-12-databox-rufous-case-study-condensation-validation.md`.
