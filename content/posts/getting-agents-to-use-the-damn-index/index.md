---
title: "Getting Agents To Use The Damn Index"
date: 2026-05-15
draft: false
summary: "Notes from AI Council on turbopuffer, embeddings, semantic code search, and why the hardest part is not building the index but getting agents to use it."
tags: ["ai", "embeddings", "rag", "semantic-search", "coding-agents", "conferences"]
---

AI Council was a hell of a week.

It was only 3 days in the heart of San Francisco, but it was action packed. I have heard people call it the practitioners conference, and that felt right. The people there were not just selling some AI future. They were demoing what they had learned, what broke, what scaled, what did not scale, and what they were still confused by.

Even some of the company talks barely felt like company talks. They were not sales pitches so much as, "here is a person at this company who did something cool, and maybe it is adjacent to the product, but mostly it is just interesting."

If the conference had themes, they were probably something like:

- embeddings
- agent evaluations
- autonomous agents
- the feasibility of local models
- data engineering in an age of AI

Two sessions stuck with me more than the others. One was about making neural networks smaller through quantization and pruning, which was fascinating and also firmly in the "I am doing my best to keep up" category. The speaker walked through making local LLMs more efficient, including ideas like preserving important outlier weights instead of accidentally smoothing them into oblivion. It made me dream a little bit about the day when local models can take over more of the work we currently hand to proprietary frontier models.

But the session I have not stopped thinking about was the turbopuffer workshop and talk about embeddings, semantic search, and what becomes possible when your index can support trillions of embeddings.

## Embeddings are cached compute

The phrase that stuck with me was this:

> Embeddings are cached compute.

That is such a clean mental model.

An embedding is not magic. It is not intelligence. It is not the answer. It is a bunch of numbers that represent something about the meaning of text, code, an image, a customer call, or whatever else you fed into the embedding model. You paid the model once to turn that thing into numbers. Later, when a user asks a question, you turn the question into numbers too and compare it against the numbers you already stored.

In other words: you did some thinking ahead of time, cached the shape of that thinking, and made it cheap to search later.

That is interesting for normal RAG over documents. It is much more interesting for code.

Codebases are massive piles of relationships. Files call files. Modules imply ownership. Test names imply behavior. The thing you need is often not named the way you would have named it. And if you work at a company with thousands of repositories, the question is not "can I grep for a function name?" The question is closer to: "where the hell does this behavior live?"

That is where embeddings feel like a legitimate unlock. Not because they replace exact search, but because they give you a way to enter a codebase through meaning instead of vocabulary.

## The indexing part is not the whole problem

The week before AI Council, I saw that turbopuffer was giving a workshop about teaching Claude how to do semantic search. I was excited because this is a problem I had already been circling.

Cursor does this natively and does it well. In their own writing, they describe semantic search as one of the biggest drivers of agent performance, improving response accuracy by 12.5% on average. Cursor also published a great post on [securely indexing large codebases](https://cursor.com/blog/secure-codebase-indexing), where they explain how they use Merkle trees, content hashes, and reusable indexes so big repos can become searchable in seconds instead of hours.

That got me thinking: why shouldn't I have something like that in my own editor?

I do not use Claude Code. I use [OpenCode](https://github.com/anomalyco/opencode), Anomaly's open-source AI coding editor. So the weekend before the conference I tried to spin up my own local MCP server for semantic code search.

The first version was not that hard. Take the codebase, chunk it, embed the chunks, store vectors in LanceDB, expose a search tool over MCP. A local-first semantic search server is very buildable.

Then you hit the real problem.

You built an MCP server or CLI tool. Great. You have semantic search. Great.

Now how do you get the agent you are talking to to use the damn thing?

## The grep doom spiral

This was the part of the workshop that resonated with me the most, because the turbopuffer speaker basically named the same problem I had run into.

Agents want to grep everything.

That is not even always wrong. `grep`, `rg`, and `find` are fantastic tools. They are deterministic, fast, and exact. If you know the function name, error string, import path, route, config key, or class name, semantic search is usually not the first thing you want. You want exact search.

But if you are trying to find behavior-adjacent files, understand a new codebase, discover the module that owns a concept, or figure out where some product behavior probably lives, exact search can be a bad starting point. It forces you to know the vocabulary before you have learned the territory.

So I tried the obvious thing: tell the agent to use semantic search in .md.

That made things worse.

The more I told the model to use semantic search, the more it would get flustered. It would start reaching for `grep`, remember the instruction, apologize to itself, say something like, "I should use semantic search first," then sometimes reach for `grep` again anyway. It created this little doom spiral where the agent was no longer just solving the task. It was spending tokens litigating whether it was allowed to search the way it wanted to search.

That is a bad trade. You do not want your agent burning context on tool guilt.

This also matches one of the more interesting findings around agent retrieval benchmarks. [ContextBench](https://contextbench.github.io/) evaluates how well coding agents retrieve the right multi-file context for issue-resolution tasks. Its findings are pretty sobering: frontier models still struggle to retrieve precise code context, they tend to favor recall over precision, and retrieved context is often not used in final solutions.

In other words, retrieval is not just an infrastructure problem. It is a behavior problem.

## Turbopuffer's answer: upgrade grep

The turbopuffer answer, at least as I understood it from the workshop, is not to ban grep. It is to make something grep-shaped that can do more than grep.

Their public repo [`turbopuffer/turbogrep`](https://github.com/turbopuffer/turbogrep) is a small Rust CLI called `tg`. The README describes it as a semantic, full-text, and regex grep tool using turbopuffer. It uses Voyage embeddings and turbopuffer as the backend index.

That is an important product shape.

Instead of handing the agent a new abstract semantic-search tool and then begging it to remember when to use it, you give it a search tool that satisfies the grep instinct. The model still feels like it is searching. It still has a CLI. It still gets regex and full-text behavior. But now semantic search is part of the same path.

Do not fight the agent's grep impulse. Upgrade grep.

That feels correct to me. Especially if you are building the tool for a general coding agent where you cannot fully control the harness, model, routing layer, or system prompts.

But because I am using OpenCode, I think I have another option that I like.

## My answer: conditionally prime the agent before it starts

OpenCode has an experimental plugin hook that can transform chat messages before the main model sees them.

That is a very interesting place to intervene.

Instead of telling the main model, "please use semantic search," my plugin tries to make the semantic-search decision before the main model even starts. The flow is:

1. The user sends a message.
2. A small classifier model starts in a separate OpenCode session.
3. The classifier sees the user prompt and answers one question: should semantic code search run first, yes or no?
4. If the classifier says no, the user's message stays unchanged.
5. If the classifier says yes, the plugin calls [SocratiCode](https://github.com/giancarloerra/SocratiCode)'s semantic search MCP tool using the user's prompt (_a more sophisticated version of my semantic search MCP_).
6. The plugin appends the search results as synthetic context to the user message.
7. The main model starts fresh and sees the original request plus the semantic search results.
8. The main model can still use `rg` or `grep` for exact verification without having to feel bad about it.

The plugin is here: [`socraticode-primer.js`](https://github.com/Doctacon/dream-job-radar/blob/main/.opencode/plugins/socraticode-primer.js).

At the time of writing, the classifier model defaults to `openai/gpt-5.4-mini`. The classifier is intentionally constrained. It is not supposed to answer the coding question, plan the task, or use tools. It just returns compact JSON like:

```json
{"search": true, "reason": "repository context likely needed"}
```

If `search=true`, the plugin calls SocratiCode's `codebase_search` tool, wraps the result in a `<socraticode-semantic-search>` block, and appends that block to the latest user message as synthetic text. There is also a small guard that warns before broad `rg` or `grep` usage after semantic search has already succeeded.

The important difference is that the main model is not being asked to choose semantic search as a matter of virtue. It is simply given useful context at the start of the session when a small router thought that context would help.

That makes the model calmer.

It can start from semantic discovery and still use exact search for proof.

## Semantic search for discovery, grep for proof

This is the practical split I keep coming back to:

> Semantic search is for discovery. Grep is for proof.

Semantic search wins when the query looks like:

- Where is this behavior implemented?
- What module owns this concept?
- How does this feature work?
- What files are probably related to this business process?
- Where should I start in this codebase?

Grep wins when the query looks like:

- Where is this exact function called?
- Where does this import come from?
- What code produces this exact error string?
- Which tests reference this class?
- Where is this route or config key defined?

Most real debugging work needs both. You use semantic search to find the neighborhood, then grep to trace the addresses.

The mistake is trying to make one tool morally superior to the other. That is how you get the doom spiral. The agent does not need a lecture. It needs the right context at the right time and permission to use exact tools when exactness matters.

## Why this matters outside code

Code search is just the easiest place for me to feel the problem.

The same pattern applies to basically every pile of company knowledge:

- all of your codebases
- all of your sales call transcripts
- all of your Slack messages
- all of your docs
- all of your support tickets

Every company is already feeling the pressure of AI making downstream people more capable. People ask better questions. They ask more questions. They move faster. That is good, but it also pushes more strain upstream onto the people who know where things live and why they work the way they do.

At some point, the bottleneck is not whether a model can generate text. The bottleneck is whether humans and agents can navigate the organization quickly enough to find the right context.

A few years ago it would have sounded ridiculous to say, "I work at a 1,500-person SaaS company and I understand every repository." Of course you do not. Nobody does. Different teams, different languages, different conventions, different historical accidents.

But now I am less sure that it should sound ridiculous.

Not because every engineer needs to hold every codebase in their head. That is not the goal. The goal is more like: can we build an encyclopedia of the company that agents can search well enough to help us navigate? Can we understand the high-level purpose of every repository? Can we find the fifteen repos that matter for a cross-cutting change without spending a week asking around?

Embeddings make that question feel less absurd.

## What I am trying next

For now, my bias is local-first.

Turbopuffer is extremely cool. Their architecture is compelling: vector and full-text search built on object storage, with production claims in the trillions of documents and very low query latencies. But I am already paying for LLMs, and turbopuffer is not priced like a toy I casually add to my personal stack.

So the personal path is:

1. Use SocratiCode locally.
2. Use a local or cheap embedding model where possible.
3. Prime OpenCode sessions with semantic results only when a small classifier thinks it is useful.
4. Let the main model use grep for exact verification.
5. Find a way to quantify whether this actually improves outcomes.

That last part is the missing piece. Qualitatively, I have seen gains. The sessions feel less lost at the beginning. The model finds behavior-adjacent files faster. It spends less time wandering the repo. But I have not put hard numbers behind it yet.

That is probably the next project.

Because after AI Council, I am convinced the interesting question is not only, "can we embed everything?"

It is:

> Once we embed everything, how do we get agents to use the damn index?
