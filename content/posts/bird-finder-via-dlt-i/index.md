---
title: "dlt Demo: Bird Hotspot Finder, pt. I"
date: 2023-06-01
draft: false
summary: "Loading eBird API data into DuckDB with dlt, then querying it in DBeaver. A first look at dlt as a Meltano/Airbyte alternative."
tags: ["dlt", "duckdb", "dbeaver", "python", "ebird", "data-engineering"]
series: ["Bird Hotspot Finder"]
series_order: 1
---

> [!TIP]
> Check out [this repository](https://github.com/CR-Lough/bird-finder-app) to see the end product.

## Background

There are a couple of tools that I've been meaning to demo but haven't found the time… no longer! Today we're going to demo the [dlt (data load tool)](https://github.com/dlt-hub/dlt) package as an alternative to Meltano or Airbyte. We'll also load that data to a [duckdb](https://duckdb.org/) and then use DBeaver as an IDE for querying. dlt is *very* cool in that it takes advantage of native data objects in Python for loading, has schema inference, schema evolution (exportable files), and can alert folks when things change. One thing I was not a fan of when using Meltano was that so many of the taps/sources were written to behave like the following:

1. use credentials to create a connection
2. load the entire dataset
3. bring to staging to be ingested to your favorite cloud warehouse

Which works great, until it doesn't. There are so many times when a single table is enormous (anything over 100GB), and loading in the whole table at once is just not an option. Enter dlt, which:

> *…For example, consider a scenario where you need to extract data from a massive database with millions of records. Instead of loading the entire dataset at once, `dlt` allows you to use iterators to fetch data in smaller, more manageable portions. This technique enables incremental processing and loading, which is particularly useful when dealing with limited memory resources.*

Without further ado:

## Environment set up

Make sure that you have [`poetry`](https://pypi.org/project/poetry/) installed from the PyPi package manager. Once that's done, do the following:

- make a new directory with whatever name you like
  - `mkdir birds_are_cool && cd birds_are_cool`
- In this new directory, create a file called `pyproject.toml`, and then copy + paste the following into that file:

```toml
[tool.poetry]
name = "bird-finder-2.0"
version = "0.1.0"
description = "birding hotspots relative to current location"
authors = ["Your Name <you@example.com>"]

[tool.poetry.dependencies]
python = "^3.10"
dlt = "^0.3.12"
duckdb = "^0.8.0"
python-dotenv = "^0.20.0"
click = "^8.1.1"
colorama = "^0.4.4"

[tool.poetry.dev-dependencies]

[build-system]
requires = ["poetry-core>=1.2.0"]
build-backend = "poetry.core.masonry.api"
```

- now we're going to create the environment that we've described via the `pyproject.toml`
  - `poetry install` (which will create a snapshot of the environment via the new file `poetry.lock`)
- and finally, we're going to activate this new environment we've made
  - `poetry shell`

So, now we've got everything set up for dlt and duckdb — last but not least, install the community edition (read "free" edition) of the IDE called [DBeaver](https://dbeaver.io/download/).

## Initialize a new project

We have our environment set up, now it's time to get loadin'. For our demo purposes, we're going to use the eBird API because it's very well documented, and load data from the exposed API endpoints into our duckdb. **dlt makes the duckdb for us when we eventually run our pipeline, we don't need to do ANYTHING.** Within our `birds_are_cool` directory, run the following:

- Scaffold a new project structure… duckdb is already a dlt-supported destination (along with Snowflake and others), but the `ebird_api` is not a [verified source](https://dlthub.com/docs/dlt-ecosystem/verified-sources/) so we'll be modifying it ourselves (don't be scared, it's ONE file).
  - [`dlt init ebird_api duckdb`](https://dlthub.com/docs/reference/command-line-interface#dlt-init)
- You should now have the following file structure in your directory:
  - `.dlt` folder
  - `.gitignore` file
  - `ebirdapi.py`
  - `poetry.lock`
  - `pyproject.toml`
  - `README.md`

## Set up source connection

### Get our API key from eBird

1. **Create an account.** If you don't already have an account on the eBird website, you'll need to create one. Go to [eBird](https://ebird.org) and sign up.
2. **Log in.** After creating an account, log in.
3. **Navigate to the API page.** Visit [https://ebird.org/api/keygen](https://ebird.org/api/keygen).
4. **Request an API key.** Fill out the form with the required information — name, email, project description, intended use.
5. **Agree to terms.** Review and agree to the eBird API terms of use.
6. **Submit request.**
7. **Get API key.** You should receive an email containing your key.
8. **Start using the API.** With your key in hand, you can authenticate requests.

> [!IMPORTANT]
> Place your API key inside of the `birds_are_cool/.dlt/secrets.toml` file.

### Edit the `ebirdapi.py` file

When you first get this file, there will be some helpful comments about how to structure the file, but ultimately it will look like this for our demo:

Standard imports:

```python
import dlt
from dlt.sources.helpers import requests
import requests as req  # We want the exceptions from the package
```

If you've never worked with an API before, this function might seem strange. We're creating the header for an application programming interface. We are eventually going to ask the API for data, and this header will contain some metadata to authenticate us (headers are also used for other things as well).

```python
def _create_auth_headers(api_secret_key):
    """Constructs Bearer type authorization header which is the most common authorization method."""
    headers = {"X-eBirdApiToken": f"{api_secret_key}"}
    return headers
```

Sources & resources:

- Both are denoted by a decorator (fancy Python for "add this functionality to my subsequent function").
- Sources are the high-level, logical grouping function for one or many resource functions.
- Resources are endpoints / tables / streams that are under the source in question.

```python
@dlt.source
def ebirdapi_source(loc_code: str = 'US-WA', api_secret_key=dlt.secrets.value):
    return recent_observations(loc_code, api_secret_key)


@dlt.resource(write_disposition="replace")
def recent_observations(loc_code: str, api_secret_key=dlt.secrets.value):
    headers = _create_auth_headers(api_secret_key)
    ebird_api_url = f'https://api.ebird.org/v2/data/obs/{loc_code}/recent/notable?detail=full'
    try:
        response = req.get(ebird_api_url, headers=headers)
        response.raise_for_status()
        data = response.json()
        yield data
    except req.exceptions.RequestException as e:
        print("Error fetching data from eBird API:", e)
        yield []
```

Here we first create an instance of a `dlt.pipeline`, and then execute the class's `run` method. On this rare occasion, the docs explain it best:

> *This method will `extract` the data from the `data` argument, infer the schema, `normalize` the data into a load package (i.e., jsonl or PARQUET files representing tables) and then `load` such packages into the `destination`.*
>
> *The data may be supplied in several forms:*
>
> - *a `list` or `Iterable` of any JSON-serializable objects, e.g. `dlt.run([1, 2, 3], table_name="numbers")`*
> - *any `Iterator` or a function that yields (`Generator`), e.g. `dlt.run(range(1, 10), table_name="range")`*
> - *a function or a list of functions decorated with `@dlt.resource`, e.g. `dlt.run([chess_players(title="GM"), chess_games()])`*
> - *a function or a list of functions decorated with `@dlt.source`.*

```python
if __name__ == "__main__":
    # Configure the pipeline with your destination details
    pipeline = dlt.pipeline(
        pipeline_name='ebirdapi', destination='duckdb', dataset_name='ebirdapi_data'
    )

    # Run the pipeline with your parameters
    load_info = pipeline.run(ebirdapi_source())

    # Pretty print the information on data that was loaded
    print(load_info)
```

Once you have this file in its entirety copied and pasted, you can change the location code in line 6 (to find birding hotspots near ***you***) and then in the terminal with your poetry shell, run:

```bash
python3 ebirdapi.py
```

Data will be put into a new `.duckdb` instance and it'll be ready to be checked out in DBeaver.

## Querying data

- Create a new connection and browse + select the new `.duckdb` you just made.
- Either view the database / schema / table layout in the lefthand pane, or go straight to a new worksheet and write whatever SQL you'd like.
