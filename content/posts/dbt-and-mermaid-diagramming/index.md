---
title: "Creating a Mermaid Diagram for Your dbt Project Using graph.gpickle"
date: 2023-04-15
draft: false
summary: "Turn a dbt project's compiled graph.gpickle into a Mermaid diagram so you can actually see what your models depend on."
tags: ["dbt", "mermaid", "python", "data-engineering"]
---

If you're a data engineer working with dbt (data build tool), you probably know the importance of visualizing the relationships between your data models. In this post I'll show you how to create a Mermaid diagram representation of your dbt project using the `graph.gpickle` file. Let's dive in.

## What is Mermaid?

[Mermaid](https://mermaid-js.github.io/mermaid/#/) is a powerful, open-source tool that allows you to create diagrams and flowcharts using simple text syntax. With Mermaid, you can quickly generate visuals to help you understand complex systems and the relationships between components.

## What you'll need

1. A dbt project with a `graph.gpickle` file generated after running `dbt compile`.
2. Python 3 and the following libraries installed: `networkx`, `pymermaid`, and `pandas`.

## Step 1: extract the graph from `graph.gpickle`

First, load the graph from the `graph.gpickle` file using the NetworkX library.

```python
import networkx as nx

graph_file = 'graph.gpickle'
G = nx.read_gpickle(graph_file)
```

## Step 2: convert the graph to a Mermaid diagram

Now that we have the graph loaded, let's create a function to convert it to a Mermaid diagram.

```python
from pymermaid import Mermaid

def create_mermaid_diagram(graph):
    mermaid = Mermaid()

    # Iterate through nodes and edges
    for node in graph.nodes:
        mermaid.add_node(node, label=graph.nodes[node]["resource_type"])
    for edge in graph.edges:
        mermaid.add_edge(edge[0], edge[1])

    return mermaid
```

## Step 3: save the Mermaid diagram as an HTML file

Next, a function that saves the Mermaid diagram as an HTML file.

```python
def save_mermaid_diagram_to_html(mermaid, output_file):
    mermaid_html = f"""<!DOCTYPE html>
    <html>
    <head>
        <title>dbt Mermaid Diagram</title>
        <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
        <script>mermaid.initialize({{startOnLoad:true}});</script>
    </head>
    <body>
        <div class="mermaid">
            {mermaid.to_mmd()}
        </div>
    </body>
    </html>
    """

    with open(output_file, "w") as f:
        f.write(mermaid_html)

output_file = "dbt_mermaid_diagram.html"
```

## Step 4: putting it all together

Combine the functions to generate the Mermaid diagram of your dbt project.

```python
def main():
    # Load graph from graph.gpickle
    G = nx.read_gpickle('graph.gpickle')

    # Create a Mermaid diagram
    mermaid = create_mermaid_diagram(G)

    # Save the Mermaid diagram as an HTML file
    save_mermaid_diagram_to_html(mermaid, 'dbt_mermaid_diagram.html')

if __name__ == "__main__":
    main()
```

Now run the script and you'll find a new `dbt_mermaid_diagram.html` file in your project folder. Open it in your browser to view your dbt project's Mermaid diagram and better understand the relationships between your data models.
