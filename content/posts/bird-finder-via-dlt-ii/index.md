---
title: "dlt Demo: Bird Hotspot Finder, pt. II"
date: 2023-06-15
draft: false
summary: "Extending the dlt pipeline: stage load packages to S3, persist schema changes back to DuckDB, and ping Slack on schema drift."
tags: ["dlt", "duckdb", "dbeaver", "python", "ebird", "aws", "s3", "slack", "data-engineering"]
series: ["Bird Hotspot Finder"]
series_order: 2
---

> [!TIP]
> Check out [this repository](https://github.com/CR-Lough/bird-finder-app) to see the end product.

## Background

One of the cooler things about `dlt` is the schema inference and its inherent statefulness. As data engineers, we are typically subject to our data sources changing shape at any given point in time. Let's move beyond our simple pipeline from the [previous post]({{< ref "bird-finder-via-dlt-i" >}}) and add three new features:

1. Send the `dlt` loaded package **data** to AWS S3.
2. Store original schema and then any future changes in our destination database.
3. Send Slack notifications via incoming webhooks on changed table schemas (comes from package information).

## Send load package data to AWS S3 bucket

### Create S3 bucket and IAM role with permissions

These steps are fairly straightforward if you're familiar with AWS, but if you're not, here is a [video overview](https://www.youtube.com/watch?v=v33Kl-Kx30o). As you watch, know that your goals are essentially:

1. Create an AWS account (or log in to your existing one).
2. Make sure that you have a user.
3. Make sure that you have a role with the right permissions (AWS calls it IAM, or Identity Access Management).
4. Click into the S3 service and create a new bucket to hold your files.

### Update `secrets.toml` and `pipeline.py`

The way that we're going to accomplish sending our pipeline data to S3 is by creating a [staging (read: intermediate) layer](https://dlthub.com/docs/dlt-ecosystem/staging) between our source and [destination](https://dlthub.com/docs/dlt-ecosystem/destinations/filesystem). Within the scope of our example, we're going to send eBird API data (source) to a destination compatible with remote staging layers.

**Note:** because I am a poor simple caveman data engineer, I do not have a personal cloud warehouse at my disposal. Even though the DuckDB destination is not enabled with having a `dlt` staging layer, we will continue our example like it is.

To update the `secrets.toml` file, add the following:

```toml
[destination.filesystem]
bucket_url = "s3://[your_bucket_name]" # replace with your bucket name

[destination.filesystem.credentials]
aws_access_key_id = "please set me up!" # copy the access key here
aws_secret_access_key = "please set me up!" # copy the secret access key here
```

We'll simply need to add the following to our `dlt` pipeline object:

```python
if __name__ == "__main__":
    pipeline = dlt.pipeline(
        pipeline_name='ebirdapi',
        destination='duckdb',
        staging='filesystem',  # This line is what you'll need to add
        dataset_name='ebirdapi_data',
        full_refresh=True,
    )
```

Conveniently, `dlt` will choose the file format for us — but you can always manually specify, like so:

```python
load_info = pipeline.run(ebirdapi_source(), loader_file_format="parquet")
```

> [!CAUTION]
> At this step, [`dlt` will not dump the current schema content to the bucket](https://dlthub.com/docs/dlt-ecosystem/destinations/filesystem#data-loading). Please continue for that.

## Send load package schemas to destination database

Originally, this section was going to be titled: "Send schemas to AWS S3." And it's great if you'd like to do that. Simply ask ChatGPT to "write a Python script to send a file in a specific directory to an AWS S3 bucket" and you'll be good to go. HOWEVER, because `dlt` is stateful, you might as well add two lines to your pipeline script and load the schema changes as tables directly to your destination warehouse.

Adding these two lines for an extra run of your pipeline object will initially generate the schema of your table and columns, and subsequently will generate schema changes:

```python
table_updates = [p.asdict()["tables"] for p in load_info.load_packages]
pipeline.run(table_updates, table_name="_new_tables")
```

## Send Slack notification on schema change

Use the following [Slack walkthrough](https://api.slack.com/messaging/webhooks) to:

1. Create a Slack app.
2. Enable incoming webhooks for the new app.
3. Create an incoming webhook (get a URL to pass to your `secrets.toml` for the new app).

Add the following code to your script:

```python
from dlt.common.runtime.slack import send_slack_message

send_slack_message(pipeline.runtime_config.slack_incoming_hook, message)
```
