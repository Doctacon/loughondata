---
title: "Never Make Another dbt model .yml"
date: 2024-02-10
draft: false
summary: "A GitHub Action that runs dbt-osmosis + dbt2looker on every push, then commits the regenerated .yml and .lookml files back to your repo."
tags: ["dbt", "dbt-osmosis", "dbt2looker", "github-actions", "ci", "data-engineering"]
---

With dbt projects, `.yml` files can quickly get out of hand as your project grows. Some specific pain points that come to mind:

1. The process of making them can be tedious.
2. Keeping their columns up to date so that you have an accurate representation of your project is time-consuming at best.
   - This is especially true of projects using the [dbt2looker package](https://github.com/lightdash/dbt2looker), which requires your `.yml` files to not have a single column present in your project that is not present in your database.

It's easy to download the [dbt-osmosis package](https://github.com/z3z1ma/dbt-osmosis) to refactor (create and/or modify) locally and run `dbt-osmosis yaml refactor` — but what if you wanted to automate that? You'd need a GitHub Action. I found myself in this position the other day and what seemed like a quick solution took a little longer than I expected.

First the end product, then a piece-by-piece walkthrough.

> [!NOTE]
> A GitHub **Action** is the full `.yml` file that you make under the `/workflows` folder in your repository. A **workflow** is a single run of an action. Within a single workflow run, one or many **jobs** run, and each of these have one or many **steps**.

## Final product

```yaml
name: Development Workflow

env:
  DOTNET_VERSION: '6.0.x'
  # your dbt variables, here
on:
  pull_request:
    branches:
      - main
  push:
    branches:
      - main
jobs:
  get-version:
    runs-on: ubuntu-latest
    outputs:
      current_version: ${{ steps.curr_ver.outputs.current_version }}
    steps:
      - name: Check out code
        uses: actions/checkout@v3

      - name: Read version from version.txt
        id: curr_ver
        run: |
          CURRENT_VERSION=$(cat version.txt)
          echo "current_version=${CURRENT_VERSION}" >> "$GITHUB_OUTPUT"

  build-and-push-image:
    runs-on: ubuntu-latest
    defaults:
      run:
        working-directory: '.'
    needs: get-version
    steps:
      - name: Check out code
        uses: actions/checkout@v3

      - name: Check if tag already exists
        id: check_tag
        env:
          CURR_VERSION: ${{ needs.get-version.outputs.current_version }}
        run: |
          echo $CURR_VERSION
          GHCR_TOKEN=$(echo ${{ secrets.GITHUB_TOKEN }} | base64)
          RESPONSE=$(curl -s -H "Authorization: Bearer ${GHCR_TOKEN}" "https://ghcr.io/v2/{owner}/{repo}/tags/list")
          if echo "$RESPONSE" | jq -e --arg ver "$CURR_VERSION" '.tags | index($ver)' >/dev/null; then
            echo "Version is already present"
            exit 1
          else
            echo "Version is not found"
            exit 0
          fi

      - name: 'Login to GitHub Container Registry'
        uses: docker/login-action@v1
        with:
          registry: ghcr.io
          username: ${{github.actor}}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Build and push Docker image
        env:
          CURR_VERSION: ${{ needs.get-version.outputs.current_version }}
        run: |
          if [[ "${{ github.base_ref }}" == "main" ]]; then
            docker build . --tag ghcr.io/{owner}/{repo}:"$CURR_VERSION"
            docker push ghcr.io/{owner}/{repo}:"$CURR_VERSION"
          else
            docker build . --tag ghcr.io/{owner}/{repo}:"$CURR_VERSION"-dev
            docker push ghcr.io/{owner}/{repo}:"$CURR_VERSION"-dev
          fi

  get-latest-tag:
    runs-on: ubuntu-latest
    needs: build-and-push-image
    outputs:
      latest_tag: ${{ steps.get_tag.outputs.latest_tag }}
    steps:
      - name: Get latest tag from GHCR
        id: get_tag
        run: |
          GHCR_TOKEN=$(echo ${{ secrets.GITHUB_TOKEN }} | base64)
          RESPONSE=$(curl -s -H "Authorization: Bearer ${GHCR_TOKEN}" "https://ghcr.io/v2/{owner}/{repo}/tags/list")
          LATEST_TAG=$(echo "$RESPONSE" | jq -r '[.tags[] | select(test("-dev"))] | .[-1]')
          echo "latest_tag=${LATEST_TAG}" >> "$GITHUB_OUTPUT"

  run-and-refactor-yml:
    runs-on: ubuntu-latest
    needs: get-latest-tag
    container:
      image: ghcr.io/{owner}/{repo}:${{ needs.get_latest_tag.outputs.latest_tag }}
    steps:
      - name: check out code
        uses: actions/checkout@v3
        with:
          fetch-depth: 0
      - name: build dbt
        run: |
          dbt build
      - name: dbt-osmosis yaml refactor
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        run: |
          dbt-osmosis yaml refactor
      - name: dbt2looker
        run: |
          dbt2looker
      - name: Commit files
        run: |
          git config --global user.name "GitHub Actions Bot"
          git config --global user.email "<>"
          if ! git diff --exit-code; then
              git add models
              git add snapshots
              git add lookml
              git commit -am "GH Action updating models/*.yml, snapshot/*.yml, and .lookml files"
              git push -f origin main
          fi
```

## Triggers and variables

```yaml
name: Development Workflow
env:
  # your dbt variables, here
on:
  pull_request:
    branches:
      - main
  push:
    branches:
      - main
```

Here we're setting the name of the GitHub Action to "Development Workflow." The action will trigger a workflow any time there is a push or pull to the `main` branch.

## Job: `get-version`

```yaml
  get-version:
    runs-on: ubuntu-latest
    outputs:
      current_version: ${{ steps.curr_ver.outputs.current_version }}
    steps:
      - name: Check out code
        uses: actions/checkout@v3

      - name: Read version from version.txt
        id: curr_ver
        run: |
          CURRENT_VERSION=$(cat version.txt)
          echo "current_version=${CURRENT_VERSION}" >> "$GITHUB_OUTPUT"
```

Once the first job in the workflow starts, GitHub will take a self-hosted runner (fancy for "virtual computer that will be executing all your bash commands") of type `ubuntu-latest` and immediately have it check out your GitHub repository branch. It then looks for a file called `version.txt`. The goal here is to take the contents of the `version.txt` file and make them into a variable called `CURRENT_VERSION`. Because my repository follows [semantic versioning](https://semver.org/) syntax, each new release must have a higher number than the last. For example, let's say `CURRENT_VERSION = '1.2.3'`.

## Job: `build-and-push-image`

```yaml
  build-and-push-image:
    runs-on: ubuntu-latest
    defaults:
      run:
        working-directory: '.'
    needs: get-version
    steps:
      - name: Check out code
        uses: actions/checkout@v3

      - name: Check if tag already exists
        id: check_tag
        env:
          CURR_VERSION: ${{ needs.get-version.outputs.current_version }}
        run: |
          echo $CURR_VERSION
          GHCR_TOKEN=$(echo ${{ secrets.GITHUB_TOKEN }} | base64)
          RESPONSE=$(curl -s -H "Authorization: Bearer ${GHCR_TOKEN}" "https://ghcr.io/v2/{owner}/{repo}/tags/list")
          if echo "$RESPONSE" | jq -e --arg ver "$CURR_VERSION" '.tags | index($ver)' >/dev/null; then
            echo "Version is already present"
            exit 1
          else
            echo "Version is not found"
            exit 0
          fi

      - name: 'Login to GitHub Container Registry'
        uses: docker/login-action@v1
        with:
          registry: ghcr.io
          username: ${{github.actor}}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Build and push Docker image
        env:
          CURR_VERSION: ${{ needs.get-version.outputs.current_version }}
        run: |
          docker build . --tag ghcr.io/{owner}/{repo}:"$CURR_VERSION"
          docker push ghcr.io/{owner}/{repo}:"$CURR_VERSION"
```

We have a couple of steps in this job, which runs as soon as the first finishes (we explicitly tell this to happen). The first is once again to check out the repository's branch — because each job in the GitHub action's workflow has its own virtual computer. Next, we use the `$GITHUB_TOKEN` variable given to every action to authorize the retrieving of all published Docker images in the repository's container registry (GHCR). We need to see if the previously retrieved `CURRENT_VERSION` variable already exists. If it doesn't, we move on to the next step: logging into the GHCR for your repository (branch agnostic). Finally, we build and push a tagged image of our specifications to the GHCR. The tag will be the `CURRENT_VERSION`.

## Job: `get-latest-tag`

```yaml
  get-latest-tag:
    runs-on: ubuntu-latest
    needs: build-and-push-image
    outputs:
      latest_tag: ${{ steps.get_tag.outputs.latest_tag }}
    steps:
      - name: Get latest tag from GHCR
        id: get_tag
        run: |
          GHCR_TOKEN=$(echo ${{ secrets.GITHUB_TOKEN }} | base64)
          RESPONSE=$(curl -s -H "Authorization: Bearer ${GHCR_TOKEN}" "https://ghcr.io/v2/{owner}/{repo}/tags/list")
          LATEST_TAG=$(echo "$RESPONSE" | jq -r '[.tags[] | select(test("-dev"))] | .[-1]')
          echo "latest_tag=${LATEST_TAG}" >> "$GITHUB_OUTPUT"
```

Here we make a GitHub API call to retrieve the latest version of the repository image and keep this as a job output to be used by the next job. Instead of this job, we could have just used our previous output `${{ needs.get-version.outputs.current_version }}`, but I've adapted this script a little bit to the walk-through. Also, we run the risk that another image has been built and pushed in the short time it takes for the next job to start (the joys of working with others).

## Job: `run-and-refactor-yml`

```yaml
  run-and-refactor-yml:
    runs-on: ubuntu-latest
    needs: get-latest-tag
    container:
      image: ghcr.io/{owner}/{repo}:${{ needs.get_latest_tag.outputs.latest_tag }}
    steps:
      - name: check out code
        uses: actions/checkout@v3
        with:
          fetch-depth: 0
      - name: build dbt
        run: |
          dbt build
      - name: dbt-osmosis yaml refactor
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        run: |
          dbt-osmosis yaml refactor
      - name: dbt2looker
        run: |
          dbt2looker
      - name: Commit files
        run: |
          git config --global user.name "GitHub Actions Bot"
          git config --global user.email "<>"
          if ! git diff --exit-code; then
              git add models
              git add snapshots
              git add lookml
              git commit -am "GH Action updating models/*.yml, snapshot/*.yml, and .lookml files"
              git push -f origin main
          fi
```

In the last job, we retrieved the latest GHCR image. Here, we use that tag to tell the runner (virtual computer) that it should still run `ubuntu-latest`, but use our image. You may have noticed that we never had a step to install dependencies (dbt, sqlfluff, networkx…). All of that is taken care of by the image, and now our runner can take advantage of it. We run `dbt build`, `dbt-osmosis yaml refactor`, and `dbt2looker`, then we commit + push our changes.

## Extensions

There are a number of things that can be done to take this to the next level:

1. **Support a dev and prod workflow.** Likely you're not working in a `main` branch exclusively, but also have a `develop` branch. It makes sense then to have one image for `develop` and another for `main`. A repository where only you are a wiz is one that's sure to fail. Support your fellow coders and make it easy for them to contribute.
2. **Remove the `git push -f origin main`.** It's also not likely that you are able to force push to the main branch of your repository. More likely, you must create a pull request from your branch against `main` and it must pass checks first. In that case, you might consider checking out the PR's hidden branch in your GitHub Action, and pushing your modifications (`dbt2looker`, `dbt-osmosis`, others) there. I'll be making a separate post on this because it has its own issues.
