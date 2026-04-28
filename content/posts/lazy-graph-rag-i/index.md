---
title: "Lazy Graph RAG"
date: 2025-01-20
draft: false
summary: "A first pass at LazyGraphRAG — defer all LLM calls until query time, build a concept graph from NLP, and chase the cost/quality sweet spot."
tags: ["rag", "graph-rag", "llm", "nlp", "ai"]
---

RAG is awesome. If you haven't used it yet, you can think of it as giving your LLM extra context — like giving it a database that houses "chunks" of text that have been transformed with a special LLM called an embedding model, and telling it: "hey, if you transform my query the same way as the chunks in this database, you'll find the `x` most relevant bits of information are transformed the same way, and they'll help you answer my original question." With me?

If you read that back enough times, you'll realize that it's pretty heavy on the LLM-usage side, and it could be made a lot smarter. For example, should you ask the LLM "how many deer are in the Tonto National Forest?", it doesn't know that Tonto National Forest is in Arizona, or anything else other than what words you used. The LLM simply says: "those words you gave me, if they had a mathematical shape, they'd look like `x`. Do I see anything in here that looks like `x`?" That means that if you're not using similar wording, or including relevant words related to your topic, your LLM isn't going to know to pull back that information.

There are fun ways to improve your RAG. Vector RAG, Graph RAG — but we won't get into those here, simply because I'm currently distracted by the shiny promise of Lazy Graph RAG, which puts off all LLM calls until query time and represents perhaps the most scalable RAG that I've encountered in terms of cost / quality trade-off.

We simply want to prove that we can build it and that it's smart, so we'll need to:

1. **Build Index**
   1. Find an NLP library capable of extracting document concepts and their co-occurrences.
   2. Make a concept graph and enhance it with graph statistics.
   3. Extract hierarchical community structure from the concept graph.
2. **Build Query Refiner**
   1. Use an LLM to (a) identify relevant subqueries and recombine them into a single expanded query, and (b) refine subqueries with matching concepts from the concept graph.
3. **Build Query Matcher** — for each of *q* subqueries (3–5):
   - Use text-chunk embeddings and chunk-community relationships to first rank text chunks by similarity to the query, then rank communities by the rank of their top-*k* text chunks (*best first*).
   - Use an LLM-based sentence-level relevance assessor to rate the relevance of the top-*k* untested text chunks from communities in rank order (*breadth first*).
   - Recurse into relevant sub-communities after *z* successive communities yield zero relevant text chunks (*iterative deepening*).
   - Terminate when no relevant communities remain or the *relevance test budget* / *q* is reached.
4. **Build Answer Mapper** — for each of *q* subqueries (3–5):
   - Build a subgraph of concepts from the relevant text chunks.
   - Use the community assignments of concepts to group related chunks together.
   - Use an LLM to extract subquery-relevant claims from groups of related chunks as a way of focusing on relevant content only.
   - Rank and filter extracted claims to fit a pre-defined context window size.
5. **Build Answer Reducer** — take an LLM and tell it to answer the expanded query from step 2 with the extracted map claims from step 4.

## Build Index

## Summarize Index

## Refine Query

## Match Query

## Map Answers

## Reduce Answers

## Articles referenced

1. [A Comprehensive Review of Community Detection in Graphs](https://arxiv.org/html/2309.11798v4)
2. [LazyGraphRAG: Setting a new standard for quality and cost](https://www.microsoft.com/en-us/research/blog/lazygraphrag-setting-a-new-standard-for-quality-and-cost/)
3. [BenchmarkQED: Automated benchmarking of RAG systems](https://www.microsoft.com/en-us/research/blog/benchmarkqed-automated-benchmarking-of-rag-systems/)
4. [GitHub — benchmark-qed](https://github.com/microsoft/benchmark-qed)
5. [From Local to Global: A Graph RAG Approach to Query-Focused Summarization](https://arxiv.org/abs/2404.16130)

## LazyGraphRAG at a glance

| Stage | LazyGraphRAG |
| --- | --- |
| Build index | Uses NLP noun-phrase extraction to extract concepts and their co-occurrences; uses graph statistics to optimize the concept graph and extract hierarchical community structure. |
| Summarize index | None — the "lazy" approach defers all LLM use until query time. |
| Refine query | Uses an LLM to (a) identify relevant subqueries and recombine them into a single expanded query, and (b) refine subqueries with matching concepts from the concept graph. |
| Match query | For each of *q* subqueries (3–5): rank chunks by embedding similarity, rank communities by their top-*k* chunks (best first); LLM-rated sentence-level relevance assessment in rank order (breadth first); recurse into sub-communities after *z* zero-yield communities (iterative deepening); terminate when no relevant communities remain or budget exhausted. |
| Map answers | For each of *q* subqueries: build subgraph of concepts from relevant chunks; group chunks by community; LLM extracts subquery-relevant claims; rank and filter claims to fit context window. |
| Reduce answers | LLM answers the expanded query using the extracted map claims. |
