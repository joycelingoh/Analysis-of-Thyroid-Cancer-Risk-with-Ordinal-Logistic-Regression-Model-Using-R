# Analysis-of-Thyroid-Cancer-Risk-with-Ordinal-Logistic-Regression-Model-Using-R
## Project Overview

This project focuses on thyroid cancer risk classification using ordinal logistic regression in R. The goal is to categorize individuals into low, medium, and high risk groups based on demographic, lifestyle, and physiological factors.
- Dataset: 212,000+ records from Kaggle, including: Age, Gender, Country, Ethnicity, Family History, Radiation Exposure, Iodine Deficiency, and Thyroid Hormone Levels (TSH, T3, T4)
  
## Key Insights
- Significant Predictors: Family history, radiation exposure, iodine deficiency, ethnicity, and country (p < 0.05)
- Non-significant: Age, TSH, T3, T4, and other lifestyle factors
- Model Comparison:
  - Full model (numerical + categorical)
  - Numerical-only model (lowest accuracy)
  - Categorical-only model (best trade-off: 51.36% accuracy, comparable to full model)
- Takeaway: Categorical data alone is sufficient for effective risk stratification.

## Tools & Methods
- Language: R
- Libraries: MASS, dplyr, ggplot2
- Methods: Data cleaning, Chi-Square & Spearman tests, Ordinal Logistic Regression, Confusion Matrix Evaluation

## Results
- Categorical-only model provides similar accuracy as full model while being simpler and more interpretable.
- Insights can help prioritize early screening efforts in regions with limited diagnostic resources.

## Future Work
- Implement advanced ML models (Random Forest, XGBoost) to improve accuracy
- Address class imbalance for better medium/high-risk predictions
- Add interactive visualizations and dashboards for easier interpretation
