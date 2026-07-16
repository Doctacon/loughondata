Status: active
Created: 2026-07-12
Updated: 2026-07-12

# Contractor site v1

## Purpose and scope

Transform loughondata.com from a personal-blog-first Hugo site into the public presence for Lough on Data, an independent data-engineering practice operated through Quire LLC.

This specification governs the first contractor-site release. It covers public positioning, page responsibilities, primary conversion behavior, proof boundaries, and visual direction. It does not govern contracts, invoicing, legal advice, a CRM, scheduling, a contact form, or a new logo.

## Audience

The site MUST speak first to:

1. Growing data teams that need reliable foundations without immediately adding permanent headcount.
2. Early-stage startups that need a first durable path from source systems to trusted decisions.

The practice is available for remote engagements worldwide.

## Positioning and voice

The site MUST present Lough on Data as an independent data engineer who helps teams build reliable data systems through fixed-scope projects and ongoing advisory.

The homepage MUST name brittle pipelines as the lead condition it addresses: data that arrives late, breaks silently, or requires excessive manual repair.

The homepage hero MUST use this approved working copy direction:

> **Make your data systems dependable.**
>
> Lough on Data helps growing teams and early startups turn brittle pipelines into reliable foundations—so people can trust the data they use to decide, build, and operate.
>
> **Tell me what’s brittle →**

Copy MUST be warm and personal, direct, technically credible, and free of generic consultancy language. It MUST lead with outcomes and operating principles rather than a vendor/tool list.

## Service offer

A dedicated Services page MUST present these primary offers:

- **Platform assessment:** a time-boxed review of architecture, reliability, cost, modeling, and delivery risks.
- **Pipeline buildout:** design and implementation of reliable ingestion, transformation, orchestration, and observability.
- **Warehouse and modeling:** improvements to analytical storage, transformations, models, metrics, and semantic layers.
- **Data reliability:** tests, data contracts, observability, documentation, and incident-ready operating practices.

The Services page MUST render these as four visually distinct numbered cards. Every card MUST contain a **Best for** problem and a **You leave with** artifact line:

| Offer | Best for | You leave with |
| --- | --- | --- |
| Platform Assessment | Data is unreliable but the team cannot see where the system or ownership is breaking down. | A system map and ranked priorities for the next fixes. |
| Pipeline Buildout | Critical data arrives through manual loads, brittle scripts, or silently failing jobs. | A working source-to-warehouse pipeline and operating runbook. |
| Warehouse & Modeling | Teams debate numbers because definitions, joins, or trusted metrics are unclear. | A trusted model layer with inspectable agreed definitions. |
| Data Reliability | Problems reach downstream people before anyone detects, diagnoses, or owns them. | Quality checks and a response runbook. |

The service descriptions MUST actively support the following technical themes:

- pipelines and ingestion;
- warehouses and modeling;
- data quality and operations; and
- portable, auditable, open-source-friendly systems.

They MUST remain principles-first. Specific technologies may appear as supporting evidence in work and writing, but the service promise MUST NOT depend on named vendors or tools.

## Site architecture

The first release MUST include these public surfaces:

- **Home:** positioning, the brittle-pipeline problem, a visual reliability-flow map, numbered service cards, a visual public-work proof block, and the primary contact call to action. It MUST NOT be a single uninterrupted prose/article layout.
- **Services:** the four offers above, engagement approach, and a contact call to action.
- **Work:** Databox as the detailed public case study, followed by a concise card for Buoy Search (`Doctacon/buoy-search`). The public navigation label MUST be “Work,” while the existing `/projects/` and `/projects/databox/` URLs remain canonical; the release MUST NOT add a `/work/` content path or redirects.
- **About:** Connor’s operator story, independent data-engineer identity, relevant non-confidential prior in-house experience, and contact path. It MUST lead with the principle that code is a means to solve useful problems and make work quieter and clearer.
- **Journal:** the existing writing archive, kept accessible through primary navigation but not used as the contractor homepage’s featured-content feed.

The homepage MUST replace its existing personal-blog-first copy with contractor-focused content. It MUST retain the existing portrait in its initial redesign and MUST use the business name with that personal identity. It MUST include a short portrait-led operator section; the full career narrative belongs on About.

After the hero, the home page MUST include:

- a visual reliability-flow map: **sources → ingestion → models → quality and operations → trusted decisions**;
- four visibly numbered service cards for Platform Assessment, Pipeline Buildout, Warehouse & Modeling, and Data Reliability, replacing the current explanatory service paragraph; and
- a large Databox architecture panel using the supplied Dagster asset-lineage screenshot, with concise source-supported callouts and a Work/Databox link. The panel MUST also include a compact Databox case-study map: **eBird, NOAA, and USGS → shared spatial grain → DuckDB warehouse**.

These components are public architecture evidence, not performance claims, customer metrics, or a generic dashboard.

## Credibility boundaries

The site MAY use Databox, Buoy Search (`Doctacon/buoy-search`), public GitHub/open-source work, public writing, and non-confidential descriptions of previous in-house data-engineering experience. Databox MUST be framed as architecture evidence—a local-first, forkable warehouse scaffold with inspectable design choices, controls, and tradeoffs—rather than with unverified performance or business-impact claims. Its page MUST lead with the scaffold/platform, use the source-to-model workflow, reference sources, and Rufous reference consumer as proof, and speak first to technical evaluators.

The site MUST NOT name Harness, disclose confidential client/employer details, invent results or client outcomes, or imply testimonials, certifications, or engagements not supported by public evidence.

## Conversion behavior

The primary conversion action MUST be email, not a booking system, pricing page, or inquiry form.

Every primary contact call to action MUST use the approved wording **“Tell me what’s brittle”** and invite a prospect to share the unreliable problem they face and sufficient context to understand who relies on the system and what outcome they need. After an inquiry, the expected next step is a discussion to determine fit and then, if appropriate, a focused scope. The initial destination is `connor@loughondata.com` unless superseded by an explicit business-email decision.

The site MUST NOT publish rates, starting prices, or fixed package prices in v1.

## Legal identity

The public brand MUST be Lough on Data. A footer or legal-area disclosure MUST state that Lough on Data is a trade name of Quire LLC. Quire LLC MUST NOT be used as the primary header or hero identity.

## Visual direction

The design MUST evolve the existing forest visual identity rather than replace it with a new logo-led identity.

- Dark forest MUST be the default appearance.
- A deliberate, accessible light appearance MUST remain available through the existing manual appearance switcher.
- The hero MUST be portrait-led, without a decorative system diagram or map/data motif competing with the opening message.
- Supporting surfaces MAY use a quiet, low-contrast terrain/contour texture, but it MUST NOT compete with text or primary actions.
- Typography MUST use a warm, highly readable humanist-utility character rather than an editorial-serif or overtly technical-monospace-first system.
- The interface MUST favor an intentional evolution of the existing site over a generic enterprise-consultancy aesthetic.

## Accessibility and technical constraints

The redesign MUST preserve semantic navigation, visible keyboard focus, accessible link names, readable text contrast in both appearances, responsive layout, and a usable no-JavaScript baseline for primary content and links.

The implementation MUST remain a Hugo site using the existing Blowfish theme submodule and targeted layout/configuration overrides unless a separate decision supersedes that constraint.

## Acceptance criteria

1. A visitor can identify, from the home page without entering the journal, that Lough on Data is an independent data-engineering practice for growing data teams and early-stage startups.
2. The home page explicitly connects the offer to brittle pipelines and reliable data foundations.
3. The primary navigation provides Home, Services, Work, About, and Journal access.
4. Services renders four visually distinct numbered cards, each with the ratified Best for problem and You leave with artifact, and describes the principles-first technical stance without making unsubstantiated tool or outcome claims.
5. Work presents Databox as architecture evidence and includes Buoy Search as public open-source evidence, without naming Harness or exposing confidential information.
6. Every primary page provides a working email path that requests the prospect’s problem and context.
7. The initial public identity uses Lough on Data with Connor’s existing portrait and a short operator section; Quire LLC appears only in the footer/legal disclosure.
8. Dark forest is the default, a functional accessible light appearance exists, and the hero is portrait-led.
9. The existing writing archive remains available as a separately navigable journal and is not the contractor homepage’s primary featured-content feed.
10. The home page uses the ratified reliability-flow map, four numbered service cards, and a large source-supported Databox architecture panel to create layered visual rhythm beyond text blocks.

## Explicit exclusions

- Public pricing, day/hour rates, fixed-price packages, booking links, or contact forms.
- Named client/employer case studies, testimonials, or confidential work details.
- A new logo, full brand-identity program, or professional-photo shoot.
- A CRM, newsletter, lead automation, analytics integration, or deployment-platform migration.

## References

- `.10x/decisions/lough-on-data-public-brand.md`
- `config/_default/languages.en.toml`
- `config/_default/menus.en.toml`
- `config/_default/params.toml`
- `content/_index.md`
- `content/about/index.md`
- `content/projects/databox/index.md`
