---
title: "Giving Your LLM Context"
date: 2025-09-15
draft: false
summary: "Working through RAG approaches — from the dummy-simple Ollama + AnythingLLM path to a GCP RAG Engine setup that lives next to your IDE."
tags: ["llm", "rag", "claude", "gcp", "ollama", "ai"]
---

## Overview

Claude has [lost its mind](https://the-decoder.com/anthropic-confirms-technical-bugs-after-weeks-of-complaints-about-declining-claude-code-quality/). But there was a lag between "wow does this suck, now?" and Anthropic publicly admitting to the very real decline in Claude Code quality. In that time, we all thought of ways to circumvent this decline. With respect to the holy trinity that dictates LLM output (1. context, 2. model, 3. prompt), I chose to explore how to improve the in-context learning, and this blog will chronicle my findings. Specifically: how could I get Claude Code to understand and reference an entire book?

For me, when starting on a new topic, it's best to start with understanding the relative extremes. What is the crudest approach I could take to this problem and get ***any*** benefit? What is the most complex? For example, here, the simplest approach is stuffing as much relevant text as you can into the prompt until the context window caps out. But as you'll find if you try that method, a 2x longer prompt doesn't always equate to a 2x better answer. Instead of adding more, a more complex method is adding conditional *access* to more. That can be accomplished with retrieval-augmented generation, or RAG. RAG is not a specific technology but a technique. It answers my question of "how do I get this book into Claude Code?" by:

- **Simple:** take pdf, turn words into numbers, turn prompt words into numbers, find pdf numbers that look like prompt numbers.
- **Less Simple:** take pdf, chunk pdf into manageable sizes, for each chunk make into numbers, store numbers in a special database, turn prompt words into numbers, compare numbers in database to prompt numbers, return the *x* most similar.
- **Less Hard:** take pdf, chunk pdf smartly (overlap chunks, try different sizes), make chunks into better numbers (use good embedding model), store numbers with metadata in fancy database, turn prompt into better numbers, use hybrid search (numbers + keywords), rerank results, return best chunks.
- **Hard:** take pdf, extract structure (headers, tables, images), chunk based on document structure and meaning, make chunks into multiple types of numbers (different embedding models), store in graph database with relationships, turn prompt into numbers and understand intent, route query to right parts of database, use multiple retrieval strategies, rerank with cross-encoder, generate answer with citations, learn from user feedback.

Wow, to be honest with you, I filled in the first two bullets, then realized I was at my understanding's limit and asked Claude to finish the next two… but I didn't dream it would suggest something as complex as that last bullet. Oh well, good to know. Let's get going with the **Less Simple** option.

## Walkthrough: RAG

> *We've got a PDF, we've got a MacBook, and we're ready to ask some questions of a PDF book.*

### Naïve approach

The dummy-simple way to do the above is:

1. `brew install ollama`
2. `brew services start ollama`
3. `ollama pull gpt-oss:20b`
4. `ollama run gpt-oss:20b`
5. Install [AnythingLLM](https://anythingllm.com/), a free GUI that runs off your now-running open-source model. It can take in PDFs, GitHub repos, websites — you name it — and serve it up as context accessible to your model.
6. Start asking questions / chatting.

The problem with the above is that as a coder trying to further your career, you've realized the fatal flaw — you can't use this to your benefit at work. It's siloed to AnythingLLM and some OS model. You want it to be available to your code editor.

### Less naïve approach

What!? It's proprietary! You want me to show you what I made for work?!
…
Well…
Okay…
But I'm only going to give you the directions.

I use Google Cloud Platform, so for me the overall flow looks like:

1. Take the PDF; if it's greater than 20MB, split it up into multiple sub-20MB files.
2. Make a new bucket in your company's cloud storage system.
3. Put your PDF file(s) into this new bucket.
4. Make a new "corpus" (gatekeeper for "bunch of files") in your cloud provider's equivalent of [GCP RAG Engine](https://cloud.google.com/vertex-ai/generative-ai/docs/rag-engine/rag-overview).
   - GCP's RAG Engine handles the embedding/index/retrieval steps for you behind the scenes — it's a good option when you want to "just go," but know that when you get to the point where you need to fine-tune these steps, that's an option too.
5. Point this corpus at your cloud storage bucket.

At this point, you're pretty darn close to your IDE being able to reference your book. The only thing that's stopping you is the MCP server you need to create so that Claude Code (or whatever you use) knows how to compare your prompt to your PDF. Don't kid yourself — give your LLM this blog's URL and tell it to make the MCP server.

There will, of course, be some nuances to iron out as you try to implement this yourself. But the important thing is that you now have the overall process down. What will you build?
