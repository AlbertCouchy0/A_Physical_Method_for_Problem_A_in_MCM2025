# A Physical Method for Problem A in MCM2025

## Projiect Description

This project aims to analyze the wear and tear on building staircases to develop mathematical models that infer various information about the staircases and human activities involving their use. By conducting an in-depth study of the relationship between staircase wear and usage frequency, the project team proposes linear and accelerated wear-frequency models and combines them with genetic algorithms and finite element analysis to provide archaeologists with a new method for analyzing building information based on staircase wear.

### Main Functions and Methods:
1. **Linear Wear-Frequency Model**: Based on the Archard wear equation and incorporating foot pressure distribution, the model uses computer simulation to reproduce the actual wear curve. The staircase surface is meshed and analyzed using finite element methods to quantify wear.
2. **Genetic Algorithm**: Given the complexity of staircase wear data, a genetic algorithm is employed to optimize the distribution of stepping points, thereby inferring staircase usage frequency and human walking habits.
3. **Accelerated Wear-Frequency Model**: By introducing a time variable and considering material variation over time, the model is further refined to more accurately reflect the historical usage of staircases.
4. **Similarity Evaluation Model**: Based on the entropy weight method, this model assesses the origin of materials by quantifying various indicators and introducing entropy weights to calculate similarity with the staircase materials.
5. **Staircase Renovation Detection**: Two methods, the Gradient Method and the Regional Method, are proposed to detect whether a staircase has been renovated and to estimate the renovation time based on wear data.

### Project Achievements:
1. Successfully established linear and accelerated wear-frequency models that accurately infer staircase usage frequency and human activity patterns.
2. Optimized the model solution process using genetic algorithms, enhancing model accuracy and reliability.
3. Proposed a similarity evaluation model based on the entropy weight method, providing a scientific basis for inferring material origins.
4. Validated the models through simulation and experimental verification, offering new tools and methods for archaeological research.

### Application Scenarios:
This project is applicable to archaeological research, assisting archaeologists in analyzing historical building information through staircase wear, including building age, usage patterns, renovation history, and material origins. Additionally, the models can be used in the conservation and restoration of ancient buildings to support the development of rational protection strategies.

## Running Steps
1. Unzip to the same directory.
2. Use MATLAB, set the path to the "Codes" folder, and add all subfolders to the path.
3. Simply run the files `Final_123.mlx`, `Final_4.mlx`, `Final_5.mlx`, `Final_6.mlx`, `Final_7.mlx`, and `Final_8.mlx`.
