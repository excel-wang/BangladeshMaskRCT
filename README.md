# A re-analysis of Bangladesh mask RCT data
This repository contains the code to re-analyse the Bangladesh mask RCT (https://www.science.org/doi/full/10.1126/science.abi9069) data. In particular we are interested in how different modelling approaches affect the results presented in Table 2 in the paper.

## Preparing the data
Go to https://gitlab.com/emily-crawford/bd-mask-rct which contains the raw data and code supplied by the authors. Download the files and follow the instructions there. Run the following commands to genearte necessary data for Table 2 in the paper:
```stata
do main.do table1
do main.do table2
```
Note `do main.do table1` must not be skipped as otherwise the generated data may be different.

After successfully generating the data, run the code in `mycodes_github.do` in this repository. You could either open the file and click "Execute (do)" or type `do mycodes_github.do` in the command window. Most of the commands in the .do file were from the study authors' shared code ("03a_reg_symp_sero.do") including the steps for futher data clean. Authors' original model specificaitons were kept (lines starting with 'glm') as comments. The data was re-analysed using random-effects Poisson models ('xtpoisson' commands) and results are to be compared with Table 2 in the paper.

The final results will be displayed in the Results window in Stata (exponentiated coefficients which indicate risk ratios and their p-values). Optionally, if you have installed `estout` package (to install type "ssc install estout" in command window), a HTML document containing the results will be generated.

## Results

Symptomatic Seroprevalence with Poisson random-effects models

|              |         Pooled with bc                  |         Pooled w.o. bc                  |   By mask type with bc                  |   By mask type w.o. bc                  |
| ------------ | :-------------------------------------: | :-------------------------------------: | :-------------------------------------: | :-------------------------------------: |
| treatment    |                  0.910                  |                  0.908                  |                                         |                                         |
|              |          [0.327,2.532]                  |          [0.682,1.210]                  |                                         |                                         |
| proper\_mask\_base |                 10.706                  |                                         |                 10.817                  |                                         |
|              |        [0.000,3.5e+12]                  |                                         |        [0.000,5.3e+11]                  |                                         |
| prop\_resp\_ill\_base\_2 |                  0.299                  |                                         |                  0.291                  |                                         |
|              |        [0.000,1.1e+47]                  |                                         |        [0.000,2.1e+46]                  |                                         |
| treat\_surg   |                                         |                                         |                  0.896                  |                  0.900                  |
|              |                                         |                                         |          [0.118,6.791]                  |          [0.424,1.912]                  |
| treat\_cloth  |                                         |                                         |                  0.943                  |                  0.927                  |
|              |                                         |                                         |          [0.229,3.892]                  |          [0.363,2.365]                  |
| \_cons       |                  0.003<sup>\*\*\*</sup> |                  0.003<sup>\*\*\*</sup> |                  0.003<sup>\*\*\*</sup> |                  0.003<sup>\*\*\*</sup> |
|              |          [0.001,0.007]                  |          [0.001,0.011]                  |          [0.001,0.012]                  |          [0.001,0.009]                  |
| lnalpha      |                  0.008                  |                  0.018                  |                  0.008                  |                  0.018                  |
|              |              [0.000,.]                  |              [0.000,.]                  |              [0.000,.]                  |              [0.000,.]                  |
| *N*          |                 287351                  |                 287351                  |                 287351                  |                 287351                  |

Exponentiated coefficients; 95\% confidence intervals in brackets<br>
bc: baseline control; results for pairID not displayed<br>
<sup>\*</sup> *p* < 0.05, <sup>\*\*</sup> *p* < 0.01, <sup>\*\*\*</sup> *p* < 0.001
