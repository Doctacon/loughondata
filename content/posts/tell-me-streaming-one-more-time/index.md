---
title: "The Streaming and the Dead"
date: 2026-08-25
draft: false
featured: true
summary: "Streaming has become a must-have data engineering skill, even when batch is still the right architecture. So I built a Kafka and Flink lab on top of Rufous web analytics to find out what the job descriptions are really asking for."
tags: ["streaming", "data-engineering", "kafka", "flink", "cloudflare-r2"]
---

Streaming data.

I cannot speak for every data worker, but there have been very few moments in my career when I have looked at a problem and thought, "Wow, I am going to need a streaming architecture to get this working."

Then I started interviewing again.

I had not needed to search for a job in two years, and suddenly it seemed like three out of every four data engineering postings wanted Spark, Kafka, Flink, or some combination of the three. Apparently, while I was over here moving terabytes of data in fifteen-minute increments for very little money, the rest of the industry had agreed that every data engineer now needed to be a distributed systems engineer.

What happened?

Did batch processing stop working? Did customers become physically incapable of waiting fifteen minutes? Did every startup wake up with Netflix's traffic?

Not exactly.

But I do think streaming has become a must-have skill. That is different from streaming being a must-have architecture, and the distinction matters.

## Batch processing is not dead

For most of the last eight years, the companies I worked for were completely satisfied with batch processing.

The basic shape was familiar:

```text
source systems
-> ingestion
-> cloud warehouse
-> transformations
-> models and analysis
-> BI
```

And when I say ingestion, I do not mean copying a few Salesforce tables with Airbyte. I mean moving data out of production MongoDB environments that represented customers' pipelines, stages, and steps. Terabytes of operational data.

One stack I used was Python, dlt, ConnectorX, and PyArrow writing into BigQuery. It ran incremental jobs every fifteen minutes on a CI runner with 2 GB of memory and four cores. It was cheap, understandable, and boring in the most complimentary sense of the word.

Most data engineers could look at that system and know what it was doing. If it broke, we could rerun it. If a source changed, we could repair the affected batch. Nobody had to reason about watermarks before breakfast.

I pride myself on not creating promotion projects: elaborate systems whose primary output is a more impressive job title for the person who designed them. If the business is happy with data that is fifteen minutes old, adding Kafka does not make the data platform more mature. It makes it more complicated.

Large data also does not automatically mean streaming data. A terabyte is a statement about volume. Streaming is usually a statement about time.

> The useful question is not, "How much data do we have?" It is, "How stale can this data be before someone cares?"

For a lot of internal analytics, the honest answer is still hours. Sometimes it is a day. That is fine. The executive looking at last quarter's revenue does not need an event-time window and an exactly-once sink.

## Freshness became a product requirement

The place where my opinion starts to change is when the person looking at the data is a customer.

Internal BI trained us to think of the warehouse as the end of the pipeline. Data arrived, we modeled it, and someone opened a dashboard. If that dashboard lagged behind production by fifteen minutes, nobody panicked.

Now analytics increasingly lives inside the product. A customer takes an action in the application and then navigates to a usage panel, billing screen, security console, or operational dashboard. The application says there are ten active users. The embedded dashboard, still waiting on the warehouse, says there are six.

Both systems may be working exactly as designed. Together, they look broken.

That mismatch is not just a data quality problem. It is a product experience problem. The customer does not care that one number came from an application database and the other came through a beautifully modeled warehouse. They see one product disagreeing with itself.

The same pressure appears in a few other places:

- A data product becomes more valuable when newly collected information is available immediately.
- A company formed through acquisitions needs a common usage stream across products that were never designed to talk to one another.
- Consumption-based pricing needs usage records quickly enough for limits, forecasts, and billing to remain trustworthy.
- Fraud, security, and operational systems lose value when the response arrives long after the event.
- AI applications create more automated actions, more telemetry, and a much higher expectation that the next system in the chain can react now.

None of those examples means every transformation should become a stream. They mean freshness is moving from a nice platform metric into the product contract.

That is why streaming shows up in so many job descriptions. Some companies genuinely need it. Some expect to need it soon. Some are using "Kafka" as shorthand for "we have grown-up data infrastructure." And, yes, some are absolutely building promotion projects.

But the underlying shift is real. Data engineers are being asked to move closer to application behavior, not only prepare tables for tomorrow's dashboard.

## So what is streaming?

The least useful definition is "data, but fast."

For me, the more useful definition is a system that treats its input as an unbounded sequence of records. Producers keep producing. Processors maintain state as records arrive. Consumers act without waiting for somebody to declare the day's dataset complete.

That does not promise zero latency. A streaming job can still use a five-minute window. A micro-batch can refresh every minute. The difference is the operating model: instead of repeatedly rebuilding an answer from a bounded pile of data, the system keeps an answer moving as new data arrives.

Once the input is unbounded, time and failure become part of the data model. Records arrive late or out of order. Producers retry. Consumers stop and resume. Schemas change while old records remain in the log. "What happened?" and "When did we learn about it?" become two different questions.

That was the part I needed to learn. Not how to move a JSON object quickly, but how to keep a result trustworthy when there is no natural end to the input.

## Fine. I will learn Kafka

I could keep complaining about job descriptions, or I could make the complaint useful.

I built `streams2r2`, an on-demand streaming lab using the web analytics from Rufous, my local birding application. [Rufous already sits on top of Databox]({{< ref "databox-rufous-warehouse" >}}), a local-first warehouse that combines public birding, weather, audio, and trait data. The streaming project looks in the other direction: instead of asking what data Rufous consumes, it asks what data Rufous produces when people use it.

The pipeline looks like this:

```text
Cloudflare Web Analytics
-> Python producer
-> Kafka raw topic
-> Flink event-time windows
-> Kafka curated topic
-> Kafka Connect
-> private Cloudflare R2 bucket
```

This is deliberately too much machinery for the amount of traffic my birding app receives. That is the point. A learning project should give each component a real job without requiring me to cosplay as a Fortune 50 company.

Rufous already uses Cloudflare Web Analytics, so I did not add a custom tracking script just to manufacture events. A Python producer queries Cloudflare's GraphQL API for page-load aggregates and publishes versioned records into a raw Kafka topic. Flink groups those records into five-minute event-time windows by path, country, device type, and browser. The curated records go to another Kafka topic, and Kafka Connect writes gzip-compressed JSON Lines into a private R2 bucket.

It is a compact tour through most of the concepts hiding behind the word "streaming."

## It is not a firehose, and that is useful

There is an important cheat in this project: Cloudflare Web Analytics does not give me a raw stream of individual clicks. Its GraphQL API returns aggregated, adaptively sampled page-load data.

One source record represents one minute plus a collection of dimensions. It is not one visitor. It is not one page load. The pipeline preserves Cloudflare's `sampleInterval` so the output does not pretend sampled estimates are raw facts.

The producer also polls the API. It does not receive events continuously from a webhook.

Does that disqualify it as a streaming project? I do not think so. Kafka and Flink still process an unbounded sequence of records, use event time, maintain state, checkpoint progress, and deliver derived results downstream. More importantly, the awkward source forced me to think about something a perfect demo generator would have hidden: what happens when the lab is turned off?

My laptop is not a production server. Colima is usually stopped. A browser-to-local-Kafka design would lose every event generated while my laptop was asleep, which would make the architecture very live and very useless.

Cloudflare retains enough history for the producer to catch up. The producer stores a durable cursor and queries the backlog in bounded daily chunks. Each chunk is published as one Kafka transaction, and the cursor moves only after that transaction commits. If the laptop is off for a week, the next run resumes where the last one stopped.

That makes the source feel less like the canonical "firehose" diagram and more like real data engineering. Sources are late. Consumers go offline. APIs paginate. State has to live somewhere. Recovery is part of the design.

## Kafka is the boundary, not the point

Before this project, it was easy for me to reduce Kafka to "a queue for data people." That is not entirely wrong, but it misses why the boundary is useful.

The raw topic separates collection from computation. The producer does not need to know how Flink will aggregate the records. Flink does not need Cloudflare credentials or API logic. Kafka Connect does not need to understand either one; it consumes curated records and handles object delivery.

That separation gives me replay.

If I change the Flink query, I can process retained raw records again instead of asking Cloudflare to reproduce the exact response it returned last week. If the R2 sink is unavailable, the curated topic remains the handoff point. If I want a second consumer later, I do not have to modify the producer.

Kafka also forced decisions that batch tools often make easy to ignore:

- What is the event key?
- What makes an event deterministic?
- When is a group of writes committed?
- What does a consumer see after a producer crashes?
- How long should raw records remain replayable?
- Which schema changes are compatible with existing consumers?

Those are not Kafka trivia questions. They are data contract questions with a clock attached.

## Event time is when the thing happened

Flink was where the project stopped feeling like "put JSON on a topic" and started feeling like streaming.

Suppose the producer catches up on a day of Cloudflare history at 9:00 this morning. Processing time says every record arrived around 9:00. Event time says one record describes 2:31 yesterday afternoon and another describes 11:58 last night.

For analytics, event time is the truth I care about.

The Flink job assigns a watermark, allows records to arrive out of order within a defined boundary, and produces five-minute tumbling windows. A record belongs to the window for when the page view happened, not the moment my laptop finally downloaded it.

That distinction barely exists in a scheduled batch query because the batch already has a bounded input. In a stream, the input never declares itself finished. The watermark is how the system makes a practical statement that it has probably seen enough of the past to produce a result.

This is the concept I was not going to learn by adding `kafka-python` to a toy script. You need late data and stateful computation before watermarks stop sounding like vocabulary from an interview guide.

## Exactly once, except for the whole system

The project also cured me of saying "exactly once" too casually.

Inside the pipeline, I can make strong guarantees at particular boundaries. The producer publishes each Cloudflare query chunk in a Kafka transaction. Flink checkpoints its state and uses an exactly-once Kafka sink. Consumers read only committed records. Kafka Connect tracks offsets as it writes objects to R2.

The end-to-end pipeline is still effectively at-least-once.

A crash can happen after Kafka commits a source transaction but before the producer saves its cursor. On restart, that time window may be queried and published again. The producer generates deterministic event IDs from stable dimensions so a downstream system can recognize the replay, but the possibility still exists.

That is the useful lesson: delivery guarantees belong to boundaries, not architecture diagrams. "Exactly once" written over an arrow does not make every side effect in a distributed system happen exactly once.

At Rufous traffic, I do not need to build a grand deduplication service. I need to understand where duplication can occur, make event identity stable, and preserve an upgrade path if it becomes observable.

## Privacy belongs before the durable log

Rufous target-plan URLs contain a random identifier stored in the browser. It is not useful for this analysis, and it would create a high-cardinality path in the output.

Before a record reaches Kafka, the producer replaces any concrete target-plan URL with the stable path `/target-plans/:plan`. The event ID, key, payload, and eventual R2 object all use the normalized value.

That ordering matters. Kafka is a durable log. Sanitizing a record after publication means the sensitive or needlessly identifying value is already sitting in retained raw data.

This may be the least flashy part of the project, but it is one of the most transferable. Streaming shortens the distance between production behavior and analytical storage. It should also move minimization, validation, and schema enforcement closer to the source.

## So, is streaming mandatory now?

For a data platform? No.

If the business can tolerate fifteen-minute freshness, I will still take the boring incremental pipeline. It will be cheaper to run, easier to understand, and easier for the next person to repair. A nightly model does not become more valuable because its inputs took a victory lap through Kafka.

For a data engineering career? Increasingly, yes.

Not because every company needs millisecond latency, and not because batch is dying. Streaming makes you confront time, state, ordering, replay, schema evolution, idempotency, and failure between independently running systems. Those problems appear whenever data becomes part of a live product, and more data teams are being pulled in that direction.

`streams2r2` is comically overbuilt for counting visits to a personal birding app. It is also small enough that I can turn it off, break it, replay it, inspect every topic, and understand what each guarantee actually means. That is much more useful than memorizing Kafka terminology until an interviewer is satisfied.

So yes, fine: streaming is a must-have nowadays.

Just do not tell me my fifteen-minute batch pipeline is dead. It is cheap, it works, and it has never once asked me to configure a watermark.
