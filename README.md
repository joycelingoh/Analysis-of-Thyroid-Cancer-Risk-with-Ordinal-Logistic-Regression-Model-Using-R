# Analysis-of-Thyroid-Cancer-Risk-with-Ordinal-Logistic-Regression-Model-Using-R
## Thyroid Cancer Risk Classification (Ordinal Logistic Regression in R)

This project predicts thyroid cancer risk levels (low, medium, high) using ordinal logistic regression in R.  
The dataset (212k+ records from Kaggle) contains demographic, lifestyle, and physiological factors such as:

- Age, Gender, Ethnicity, Country  
- Family History, Radiation Exposure, Iodine Deficiency  
- Thyroid Hormone Levels (TSH, T3, T4)

## Key Insights
- Important Risk Factors: Family history, radiation exposure, iodine deficiency, ethnicity, and country  
- Model Comparison:
  - Full model (numerical + categorical)
  - Numerical-only model
  - Categorical-only model (**best trade-off: 51.36% accuracy**)
- Takeaway: Categorical data alone can effectively stratify thyroid cancer risk.

## Tools Used
- R (MASS, dplyr, ggplot2)
- Ordinal Logistic Regression for risk classification
- Exploratory Data Analysis for feature importance

## Future Work
- Improve accuracy using advanced ML models (e.g., Random Forest, XGBoost)
- Address class imbalance for better prediction of high-risk cases
- Add visualization dashboards for easier interpretation

