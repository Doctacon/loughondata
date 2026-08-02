---
title: "Rufous"
date: 2026-08-01
draft: false
summary: "A static Arizona bird-finding field companion that turns licensed GBIF evidence into an explainable outing and downloadable calendar file."
tags: ["birds", "data-engineering", "cloudflare", "open-data", "maps"]
showAuthor: false
---

# Rufous

Rufous is the public field companion built on top of the Databox reference warehouse. Pick an Arizona bird and place; Rufous checks licensed observations in the current public snapshot, builds an explainable outing around your selected time, and creates a calendar file on your device.

{{< rufous-embed >}}

## What it demonstrates

- **A warehouse with a real consumer.** Rufous turns modeled observations, species context, licensed provenance, and place data into an application rather than another static dashboard.
- **Explainable recommendations.** Candidate locations and guidance are calculated deterministically from the selected origin, radius, time, and licensed occurrence evidence, so the result does not depend on a remote model.
- **A deliberately small public footprint.** Search, watch evaluation, and calendar generation run in the browser. Watches stay on the device, and no email address is collected.
- **A static-compute launch.** Cloudflare Pages serves the application and its complete fallback snapshot; Cloudflare R2 serves the primary immutable JSON release. There is no application server, weather call, AI call, or email server.

## Public-data boundary

The initial release uses the [EOD – eBird Observation Dataset distributed by GBIF](https://www.gbif.org/dataset/4fa7b334-ce0d-4e88-aaae-2e0c138d049e) under its published CC BY 4.0 license. Direct eBird API data, downloads, hotspots, observer names, private locations, email state, and raw occurrence or checklist identifiers are excluded. Cornell’s written permission would still be required before Rufous adds a separate direct-eBird data path.

The application is built from the open-source [Databox repository](https://github.com/Doctacon/databox). Its current data sources and required credits are available in the application’s attribution view.
