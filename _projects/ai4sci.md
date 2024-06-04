---
layout: page
title: AI for Applied Physics/Mechanics
description: Figure out the potentials of AI in multiferroic composites, complex fluid flows and near-field radiative heat transfer.
img: assets/img/projects/ai4sci/featured.gif
importance: 1
category: done
related_publications: true
---

## Overview
Artificial Intelligence (AI) has become a transformative force across various scientific domains, offering novel methodologies for simulation, design, and optimization. Its integration into scientific research promises accelerated discoveries, enhanced precision in simulations, and optimized design processes that can tackle complex multi-variable systems. This project leverages AI's robust capabilities in three critical areas: multiferroic composites, complex fluid flows, and near-field radiative heat transfer, each presenting unique challenges and opportunities for technological advancements.

## Enhancing Solid-State Cooling with AI-Driven Phase-Field Simulations
The first paper introduces an innovative non-isothermal Phase-Field Model (PFM) integrated with machine learning to study the magneto-elastocaloric effect in multiferroic composites. This approach simulates the interactions of martensitic transformation, mechanics, heat transfer, and magnetostrictive behaviors under low magnetic fields. By employing a machine learning algorithm on PFM simulation data, the research optimizes the geometrical dimensions of Magnetostrictive-Shape Memory Alloys (MEA-SMA) composites to achieve significant improvements in the adiabatic temperature change and operational temperature range. This combined methodology not only augments the design of more efficient solid-state cooling devices but also extends its applicability to other multicaloric effects like the electro-elastocaloric effect. {% cite tang2024phase %}
<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/publication_preview/ijms_phase.jpg" title="Motor" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    Workflow proposed in this paper.
</div>

## Deciphering Complex Fluid Dynamics through Convolutional Neural Networks
The second paper explores the application of a convolutional neural network (CNN) for feature identification in subsonic buffet flows over high-incidence airfoils. By training the CNN with a limited dataset, the study achieves near-perfect accuracy in distinguishing between periodic, quasi-periodic, and chaotic flow regimes. The neural network identifies large-scale coherent structures without requiring temporal information, enhancing our understanding of fluid dynamics across various Reynolds numbers. This research highlights the potential of AI to not only predict fluid behavior but also to provide deeper insights into the underlying dynamics of complex fluid systems. {% cite wen2023feature %}
<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/publication_preview/taml_feature.gif" title="Motor" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    Fluid's pattern identification.
</div>

## Optimizing Near-Field Radiative Heat Transfer Designs with Machine Learning
The third paper presents a machine learning strategy combining artificial neural networks (ANN) and genetic algorithms (GA) to model and optimize near-field radiative heat transfer (NFRHT) scenarios. This approach significantly simplifies the design process of thermal devices like thermal photovoltaics and thermal diodes, traditionally reliant on designer intuition and expertise. The ANN models NFRHT between various materials, including metamaterials and nanoparticles, accurately predicting heat flow and rectification ratios. The genetic algorithm then optimizes physical parameters to achieve the best thermal performance, showcasing how AI can lead to precise, effective design solutions in thermal management applications. {% cite wen2022machine %}
<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/publication_preview/apl_amachine.jpg" title="Motor" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    Proposed workflow.
</div>

## Conclusion
This project illustrates the substantial benefits of integrating AI into scientific research, where complex systems and phenomena can be modeled, analyzed, and optimized more efficiently than ever before. It paves the way for future innovations that could revolutionize industries dependent on cooling technology, fluid dynamics, and thermal management.

