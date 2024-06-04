---
layout: page
title: Physics Constrained Learning
description: Impose physics priors into the ML workflow (data, architecture, loss function, optimization).
img: assets/img/publication_preview/preprint_physics.gif
importance: 1
category: ongoing
related_publications: true
---
## Overview
In the rapidly evolving field of machine learning, establishing a robust workflow is crucial. A typical workflow encompasses several stages: identifying a problem, curating data, designing an architecture, crafting a loss function, and employing optimization techniques. By integrating physics-based priors into each stage, we can develop models that are not only robust and capable of learning from small sample sizes but are also truly reflective of underlying physical principles rather than merely fitting curves. This approach paves the way for creating models that can generalize well and potentially simulate real-world physics accurately.

## Physics constrained loss function
Our project's first phase has successfully integrated physics priors into the machine learning workflow, particularly within the loss function design. We have developed "Physics-Constrained Graph Galerkin Learning," an innovative method tailored for solving spatio-temporal partial differential equations (PDEs). This method combines the Galerkin method for spatial discretization with an autoregressive scheme for capturing temporal dynamics. Conceptualized through a map-reduce operation, the mapping phase of our approach is fully parallelizable, and the reduction phase leverages Sparse Matrix Multiplication (SPMM). This integration is operationalized within a graph-based network framework, utilizing native PyTorch operators for seamless execution across diverse computing platforms. {% cite wen2024graph %}
<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/projects/physical_constrained_learning/pcl_data.gif" title="Motor" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    Comparison of long-term rollout between Galerkin loss autoregressive model and data loss one.
</div>

The efficiency of our approach is further enhanced by minimizing the computational graph, which facilitates rapid back-propagation and enhances overall performance. Our method has shown to achieve training speeds comparable to those of data-driven loss models and excels in scalability, efficiency, accuracy, and capability for long-term predictions.

<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/projects/physical_constrained_learning/pcl_sample.png" title="Motor" class="img-fluid rounded z-depth-1" %}
    </div>
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/projects/physical_constrained_learning/pcl_convergence.png" title="Motor" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    Comparison of learning efficiency and convergent speed between Galerkin loss model and data loss model.
</div>
