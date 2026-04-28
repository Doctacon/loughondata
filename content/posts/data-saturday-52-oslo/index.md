---
title: "Data Saturday #52 — Oslo"
date: 2024-08-31
draft: false
summary: "Session notes from Data Saturday #52 in Oslo: tools that came up, Roche's Maxim, testing in the dev cycle, data mesh, and turning data into influence."
tags: ["conferences", "data-mesh", "testing", "polars", "ibis", "dlt"]
---

## Tools talked about throughout the day

1. [Polars](https://docs.pola.rs/user-guide/getting-started/#filter)
2. [Apache Arrow](https://arrow.apache.org/cookbook/py/io.html#reading-a-parquet-file) / [PyArrow](https://arrow.apache.org/docs/python/index.html)
3. [Ibis](https://ibis-project.org/)
4. [ConnectorX](https://github.com/sfu-db/connector-x)
5. [dltHub](https://dlthub.com/blog/dlt-arrow-loading)

## Source of Truth — Dr. Thibaud Freyd

- Slides used GPT images.
- Talked about "shifting the work, left."
- Azure AI Document Intelligence seems like a worthwhile tool. I wonder what alternatives are out there?

## Roche's Maxim of Data Transformation — Alexander Arvidsson

- Slides used GPT images.
- Talked about "shifting the work, left."
- "You should do the transformation as far upstream as possible, and as far downstream as necessary."

## The Importance of Testing in the Development Cycle — John Martin

- Slides used GPT images.
- I've got hundreds of sources and they of course have many endpoints and tables:
  - Should I be testing all of these?
  - How do I pull out from business users what the data tests *should* be? Especially when they don't know their own data?
- Recommends that we go the route of:
  1. Take mock / test data.
  2. Run tests.
  3. Take processed test data.
  4. Match against real data that's also been run through the tests.
- Do you test every single table / endpoint? No — work with the business to define the most important datasets, because testing costs time and money.
- Terminology:
  - **Test scope:** what will and won't be tested.
  - **Test cases:** scenarios which will be verified.
  - **Assertions:** validation of expected behavior.
- Management of reference data is key — leverage source control and make it part of the development tasks.

## Visualizing Data Mesh — Anurag Kale

- Talked about "shifting the work, left."
- Why is the data world behind the software engineering world?
  1. Domain ownership.
  2. Data as a product.
     - Open Data Product Specification — linting, SLA, quality, etc.
     - Open data contracts.
  3. Self-serve data platform.
  4. Distributed governance.
- You must have a catalog so that you can enforce a unified request access — this means you'll have to implement infrastructure as code.
- [Roger Martin's Cascade of Choices for Strategy](https://rogerlmartin.com/thought-pillars/strategy).
- Failure — but why did Anurag fail?
  - Didn't have an access control system (RBAC) in place across the whole company.
    - What user is what user across systems, getting people access to the necessary tools.
  - Underestimated the end users.
    - They found ways to use the end product in a different way than anticipated.
  - Didn't have an executive-level sponsor.
    - Doing a bottom-up approach meant that there was no business buy-in.
- Recommended books:
  - *Data Mesh* (O'Reilly)
  - *Flow Engineering*
  - *Team Topologies*
  - *The Phoenix Project*

## Turning Data into Influence — Roman Tesolkin

Notes light — interesting talk on translating data work into organizational influence.
