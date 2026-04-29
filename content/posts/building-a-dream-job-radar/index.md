---
title: "Building a Dream-Job Radar"
date: 2026-04-28
draft: false
summary: "On a dog-walk conversation with Claude that surfaced a role I would have otherwise missed — and the small dlt → S3 → MotherDuck pipeline I'm building so it doesn't happen again."
tags: ["data-engineering", "dlt", "motherduck", "duckdb", "aws-s3", "career", "side-project"]
---

I almost missed a dream job today.

I was on a 30-minute walk to pick up my dog from daycare and decided to test Claude's voice mode. It's gotten weirdly good in the last few months — no awkward pauses, knew what I meant before I finished the sentence, the whole thing felt like talking to someone who'd already read my résumé. Creepy. Useful.

I started with geospatial. What gaps would a real interviewer poke at if I, a senior analytics engineer, applied for a GIS-flavored role? We went through coordinate reference systems, WGS 84, the rabbit hole of how those things came to be in the first place. Then the conversation drifted, the way these conversations do, into what I actually want to do next.

For about a year and a half — basically since I got serious about big game hunting — I've known the answer is something like: data, but in an industry where what I do on weekends and what I do on weekdays draw the same Venn diagram. Data work is portable. You can do it anywhere. You might as well do it somewhere you'd actually want to go.

So I asked Claude what companies I should be aiming at. The two I always come back to are GoHunt and onX. I use them aggressively. (I've also tried to build my own offline version, mostly because both of them claim to be offline apps but treat "no service" like a cold-start problem. Fifteen minutes to load a downloaded map is not offline.) Anyway — shot in the dark question, and Claude surfaced a senior data role at one of them that I hadn't seen posted anywhere. That's a top-three dream-fit job for me. Easily worth the time investment of an actual application.

That's where the gut check happened: how did I not know about this until a chat agent told me on a dog walk? How many other top-three roles are quietly opening and closing while I'm not paying attention?

Being a data engineer, my answer to "I want to monitor a thing" is "build a small pipeline." So that's the next thing I'm building.

## The plan

Most public companies post jobs through Greenhouse, which has a free public API. The plan:

- A small dlt pipeline hits the Greenhouse API for a curated list of companies, filters by keywords I care about (titles like "data engineer," "analytics engineer," "platform engineer").
- A GitHub Action runs it on a schedule and ships the result to my personal AWS S3.
- MotherDuck reads from the bucket. I write a Dive — their dashboarding surface — that lists the open roles, links, and when each one was last seen.
- The Dive gets embedded, via iframe, right here on loughondata.com.

The thing I like about this shape is that the pipeline is doing what pipelines do, but the surface I actually use is a webpage on my phone. I'm fluent in SQL — I can poke at a DuckDB file all day. I can't poke at a DuckDB file on a Forest Service road with one bar of LTE. The output has to live somewhere I can see it without thinking.

It also means the part-two of this post would, if it works, have a live dashboard embedded below this paragraph. You'd see exactly which roles the radar is catching. Not which ones I'm applying to — that's between me and the cover letter — but the surface area of "things worth a closer look."

## One caveat

MotherDuck's published business plan is $250/month with compute charged on top. For a solo person tracking job postings, that's a lot of dashboard. There has to be a better embedded-dashboard story for individual contributors and I just don't know what it is yet. Streamlit Cloud, Evidence, a self-hosted Metabase, something dumb in plain HTML — something to figure out before I commit to the architecture.

Plan B, if Dives don't pencil out: same pipeline, same data, but I build a small front-end and skip the dashboard layer entirely. More work, more flexibility, less polish.

## Why I'm writing this down

Mostly because I want the embarrassment of an unfinished public project to keep me honest. The point isn't a job-board scraper. The point is closing the loop on "found role → tracked role → applied to role" so that the next dream job doesn't slip past me on a dog walk.

Part two will be the build itself — pipeline, dashboard, whatever embedded surface I land on, posted right here once it's working.

Hope it works.
