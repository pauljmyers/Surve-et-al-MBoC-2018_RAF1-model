# Surve-et-al-MBoC-2019_RAF1-model
 
This repository contains the code needed to run the computational model of RAS-RAF signaling described in Surve et al., *Localization dynamics of endogenous fluorescently labeled RAF1 in EGF-stimulated cells*. Molecular Biology of the Cell 2019 30:4, 506-523 (PMID: 30586319, https://doi.org/10.1091/mbc.E18-08-0512). A full description of the model, including its development and implementation in MATLAB, can be found in the methods section of the paper. The model was originally built with MATLAB 2017A, and it has been tested to run correctly on MATLAB releases as late as 2020B.

## VCell model
The model was originally designed and exported as MATLAB ODE function files from the modeling software *The Virtual Cell* (*VCell*) (https://vcell.org/). The VCell model, “Surve_et_al_RAF1,” is available in the public domain at http://vcell.org/vcell-models and can also be accessed within *VCell* under the "Public BioModels/Published" section/folder. Within this section, the model is titled "Surve 2019 Localization dynamics of endogenous fluorescently-labeled RAF1 in EGF-stimulated cells" under the username "pmyers1995".

## File descriptions
Below is a list of the model files contained in this repository and their descriptions:
* **Model and helper functions**: These functions are used to run model simulations or perform other calculations (e.g., PLSR-based sensitivity analysis) within the primary scripts used to generate figures.
  1. **_minus_sorafenib_new.m_**: Function for running the initial model, prior to refitting RAS-RAF binding (without sorafenib).
  2. **_minus_sorafenib_new_fitting.n_**: Function for running the model during fitting of RAS-RAF binding rate constants (without sorafenib).
  3. **_minus_sorafenib_new_refitted_rasraf_binding_**: Function for running the reparameterized model with refitted RAS-RAF binding rate constants (without sorafenib).
  4. **_minus_sorafenib_new_pRAF1fitting_** and **_minus_sorafenib_new_pRAF1fitting2_**: Functions for running the model while fitting it to RAF1 pSer338 data.
  5. **_plus_sorafenib_new_**: Function for running the model with sorafenib (with refitted RAS-iRAF [inhibited RAF1] binding parameters).
  6. **_plus_sorafenib_new_fitting_**: Function for running the model during fitting of RAS-iRAF binding rate constants.
  7. **_constant_rasgtp_new_**: Function for running the model with simulations of constitutively active RAS-GTP (initial value of RAS-GTP set to a constant, no forcing function).
  8. **_PLSR_SA_func_**: Function for running model predictions and calculating partial least squares regression-based multivariate sensitivity analysis (PLSR-SA) results using randomized sets of model parameter values.
  9. **_vcell_outputfuncs_**: Helper function for easily getting model outputs of interest for the reparameterized model **without sorafenib**.
  10. **_vcell_outputfuncs_sorafenib_**: Helper function for easily getting model outputs of interest for the reparameterized model **with sorafenib**.
  11. **_vcell_outputfuncs_Ras_**: Helper function for easily getting model outputs of interest for the reparameterized model **with constitutively active RAS (-sorafenib)**.
  12. **_simpsons.m_**: Function for running quadrature/numerical integration using Simpson's rule combined with the trapezoidal rule for handling cases with even numbers of intervals. Works with constant and variable interval widths.
  13. **_fminsearchbnd_**: Function for running the Nelder-Mead/Simplex optimization routine with bounds (John D'Errico (2022). fminsearchbnd, fminsearchcon (https://www.mathworks.com/matlabcentral/fileexchange/8277-fminsearchbnd-fminsearchcon), MATLAB Central File Exchange.). Used throughout for fitting tasks.

* **Primary scripts for producing model results and figures**:
  1. **_memRAF1_fitting_and_predictions_Fig9A_FigS5A_**: Generates plots of model fits to RAS-GTP and membrane RAF1 experimental data. Reproduces Figures 9A and S5A. 
  2. **_SA_minus_sorafenib_init_model_Fig9B_**: Univariate sensitivity analysis for membrane RAF1 predictions from the initial model (-sorafenib). Generates plots for Figure 9B (rows 1-2).
  3. **_SA_minus_sorafenib_Fig9BE_**: Univariate sensitivity analysis for membrane RAF1 and phospho-RAF1 predictions from the reparameterized model (-sorafenib). Generates plots for Figure 9B (rows 3-4) and 9E.
  4. **_SA_plus_sorafenib_Fig9B_**: Univariate sensitivity analysis for membrane RAF1 predictions from the reparameterized model with sorafenib present. Generates plots for Figure 9B (rows 5-6).
  5. **_PLSR_SA_memRAF1_max_Fig9C_**: Function for calculating multivariate PLSR-SA results using the maximum value of membrane RAF1 as model output. Generates part of the results from Figure 9C.
  6. **_PLSR_SA_memRAF1_ave_Fig9C_**: Function for calculating multivariate PLSR-SA results using the time-averaged value of membrane RAF1 as model output. Generates part of the results from Figure 9C.
  7. **_pRAF1_calcs_Fig9D_**: Performs model fitting to phospho-RAF1 Ser338 experimental data and produces model predictions for pRAF1 abundance in respone to EGF stimulation. Generates the plot for Figure 9D.
  8. **_PLSR_SA_convergence_FigS5B_**: Analysis of PLSR-SA convergence based on number of parameter sets used. Generates the plot for Figure S5B.
  9. **_RAS_RAF1_overexpress_FigS5CD_**: Analysis of the effects of RAS/RAF1 overexpression on RAF1 membrane localization and comparison to experimental results. Generates plots for Figure S5C-D.
  10. **_sorafenib_chase_calcs_FigS5E_**: Analysis of RAF1 membrane localization after adding sorafenib to cells that have been pre-treated with EGF for various amounts of time. Generates plot for Figure S5E.
