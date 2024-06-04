---
layout: page
title: Differentiable Programming
description: Using differentiable programming for neural implicit modeling, optimization, control and inverse design in science and engineering.
img: assets/img/projects/differentiable_physics/eth_bunny.gif
importance: 1
category: ongoing
related_publications: false
---
## Overview
Differentiable programming holds significant promise for revolutionizing engineering design and computer graphics by integrating deep learning with physical process simulations. Our project centers around developing a new PyTorch-based differentiable numerical framework, **TensorMesh**, which is designed to make various numerical solving methods—such as finite element, finite difference, finite volume, spectral methods, and ordinary differential equations—differentiable. This capability allows for the seamless integration of these methods with contemporary machine learning algorithms, facilitating advanced neural implicit modeling.
## Applications and Innovations
1. **Modeling with Physical Processes:** Incorporating specific physical computations directly within machine learning models allows these models to leverage established theoretical frameworks rather than learning from scratch. For instance, by treating the material properties in Finite Element Method (FEM) simulations as learnable parameters within a differentiable FEM framework, models can learn robust generalizations from small datasets. This approach, referred to as the Neural Implicit Model, fills gaps in mature theoretical frameworks and enhances model generalizability.

2. **Optimization Solutions:** Differentiable programming enables the computation of gradients through automatic differentiation, which is instrumental in solving optimization problems and inferring physical system states, including solutions to partial differential equations (PDEs). Moreover, utilizing the implicit function theorem, differentiable programming facilitates the efficient and memory-saving calculation of adjoint variables, which is crucial for iterative convergence in physical studies, embodying the principle of least action that underlies physics.

3. **Control Problems:** Differentiable programming can adjust initial conditions and external fields to manipulate time-dependent physical processes, providing precise control over the systems' behavior throughout their dynamic evolution.

4. **Inverse Design:** This involves designing physical structures to achieve desired outcomes in force fields, light fields, electromagnetic fields, etc. Applications include electromagnetic cloaking and mechanical topology optimization, where the aim is to design structures that optimize specific performance criteria while adhering to physical laws.

## TensorMesh: A New Paradigm in Engineering and Graphics
<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/projects/differentiable_physics/tensormesh.jpg" title="Motor" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    FEM module in the TensorMesh framework.
</div>
The TensorMesh framework is set to revolutionize how engineers and designers approach problem-solving. By merging traditional numerical methods with the power of machine learning, TensorMesh enhances the efficiency and efficacy of engineering tasks related to optimization, control, and design. This integration not only speeds up the engineering processes but also opens up new possibilities for innovation in fields as diverse as aerospace engineering, automotive design, robotics, and virtual reality.

By leveraging the capabilities of TensorMesh, researchers and professionals can push the boundaries of what's possible in engineering and graphics, leading to smarter, more efficient designs and solutions that were previously unattainable. Our ongoing development and research into differentiable programming and neural implicit models underscore our commitment to leading the charge in this exciting new frontier of technology.

<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/projects/differentiable_physics/tm_monit.gif" title="Motor" class="img-fluid rounded z-depth-1" %}
    </div>
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/projects/differentiable_physics/tm_inv.gif" title="Motor" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    A PDE inference - defect monitoring using Tensormesh Framework.
</div>

