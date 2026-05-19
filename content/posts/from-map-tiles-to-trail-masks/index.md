---
title: "From Map Tiles To Trail Masks"
date: 2026-05-18
draft: false
summary: "A checkpoint from learning geospatial computer vision from first principles: map tiles, weak OSM labels, raster masks, PyTorch tensors, and why the first model failed in a useful way."
tags: ["geospatial", "computer-vision", "machine-learning", "pytorch", "openstreetmap"]
---

I have been working through a small geospatial computer vision project from first principles. The goal sounds simple: take satellite imagery and teach a model to find trails.

In practice, I learned that most of the work is not the model. It is getting geography, imagery, labels, and pixels to line up correctly.

The pipeline now looks like this:

```text
bbox + zoom
-> XYZ map tiles
-> satellite imagery
-> OSM trail vectors
-> rasterized trail masks
-> dataset CSV
-> PyTorch tensors
-> tiny segmentation model
-> validation predictions
```

That is enough to be worth writing down, even though it is not a useful trail detector yet.

## Images, but as data

The first mental shift was remembering that a satellite tile is not just a picture. It is a grid of numbers.

In this project, each image tile is a 256x256 PNG. When loaded into PyTorch, it becomes a tensor shaped like this:

```text
3 x 256 x 256
```

That means:

```text
3 color channels
256 pixels tall
256 pixels wide
```

PyTorch usually uses `channels x height x width`, so the RGB channels come first. Other tools use different conventions, which is annoying in the same way metric vs. imperial is annoying. The practical rule is simple: check the shape at every boundary.

The model does not see “a satellite image” the way I do. It sees normalized numeric arrays.

## Labels are the hard part

A model needs examples. For trail detection, one example is not just an image. It is an image plus an answer key.

For segmentation, the answer key is a mask:

```text
image: 256 x 256 RGB pixels
mask:  256 x 256 label pixels
```

In the current binary setup, each mask pixel means:

```text
0 = not trail
1 = trail
```

That is why this is called segmentation. We are not asking, “does this tile contain a trail?” We are asking, “which pixels are trail?”

## Rasterizing OSM trails

To avoid hand-labeling every tile, I used OpenStreetMap as weak supervision. OSM trail data starts as vector geometry: lines made of longitude/latitude points.

The satellite image is already raster data. It is pixels. The OSM trail is vector data. It is geometry.

Rasterization is the bridge between them:

```text
OSM LineString geometry
-> pixel coordinates inside a tile
-> black/white mask PNG
```

In plain English, I take a trail line from a map and paint it onto the exact pixels of the satellite tile.

After that step, I have two aligned rasters:

```text
input raster: satellite pixels
label raster: trail/not-trail pixels
```

That alignment is the whole point. Pixel `(100, 50)` in the image must line up with pixel `(100, 50)` in the mask.

## The first dataset

The first working dataset had one image/mask pair. That was enough to prove the loader worked:

```text
image: 3 x 256 x 256
mask:  1 x 256 x 256
```

Then I expanded to a tiny Moab demo area. A bounding box plus zoom level produced 25 XYZ tiles:

```text
25 tiles total
13 with trail pixels
12 with no trail pixels
```

The CSV manifest became the bridge between files on disk and training data:

```text
image_path, mask_path, z, x, y, bbox, split
```

From there, I split the rows into:

```text
20 training tiles
5 validation tiles
```

That was the first move from “can the model memorize this?” toward “can the model predict on something it did not train on?”

## The useful failure

The tiny model trained. The losses went down. It generated validation prediction overlays.

Then I opened one of the validation images and expected to see a prediction line. There was no line.

The ground-truth mask for that tile had trail pixels. The model predicted zero trail pixels.

That sounds bad, and it is, but it is also the first useful failure. The pipeline worked well enough to expose a real machine learning problem: class imbalance.

A 256x256 tile has 65,536 pixels. A trail may only occupy a few hundred or a thousand of them. Most pixels are background. If the model predicts “not trail” everywhere, it is wrong in the way I care about, but still right for most pixels.

So the lesson is not “the model is good.” The lesson is:

> A working pipeline is not enough; the training objective has to make the rare thing matter.

## Where this stands

This feels like a good `v0.1.0` milestone:

```text
geographic area
-> imagery tiles
-> weak OSM labels
-> raster masks
-> dataset manifest
-> PyTorch tensors
-> tiny segmentation model
-> validation predictions
```

It is not a trail detector yet. It is a toy geospatial segmentation pipeline that demonstrates the full shape of the problem.

The next steps are clear:

- use weighted loss so trail pixels count more than background pixels
- save probability heatmaps, not just thresholded masks
- compare satellite image, ground-truth overlay, and predicted overlay side by side
- expand beyond one tiny adjacent tile grid
- eventually replace the tiny model with a real segmentation architecture

For now, I am happy with the checkpoint. I started with map tiles and ended with a model failing in an understandable way. That is progress.
