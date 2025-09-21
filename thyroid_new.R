# Load required libraries
library(dplyr)
library(summarytools)   # for dfSummary
library(ggplot2)

# Read the data
df <- read.csv('thyroid_cancer_risk_data.csv')

# Dataset Preprocessing ----
# View the structure of the dataset
str(df)

# Find unique values in a categorical variable
unique(df$Country)
unique(df$Ethnicity)
colnames(df)
# Summary of the dataset
summary(df)

# Number of rows and columns
cat("Number of rows:", nrow(df), "\n")
cat("Number of columns:", ncol(df), "\n")

# Frequency distribution of the target variable
table(df$Thyroid_Cancer_Risk)

# Detailed variable summary (optional but useful in a paper/report)
dfSummary(df)

# Check for missing values
colSums(is.na(df))

# Preprocessing

# Drop uninformative column: Patient_ID
df <- df %>% select(-Patient_ID)

# Convert categorical variables to factors
categorical_vars <- c("Gender", "Country", "Ethnicity", "Family_History",
                      "Radiation_Exposure", "Iodine_Deficiency", "Smoking",
                      "Obesity", "Diabetes", "Thyroid_Cancer_Risk", "Diagnosis")

df[categorical_vars] <- lapply(df[categorical_vars], as.factor)

# Exploratory Data Analysis ----
# Distribution of Thyroid Cancer Risk 
ggplot(df, aes(x = Thyroid_Cancer_Risk)) +
  geom_bar(fill = "steelblue") +
  theme_minimal() +
  labs(title = "Distribution of Thyroid Cancer Risk Levels",
       x = "Risk Level", y = "Count")

# Boxplot of Age
ggplot(df, aes(y = Age)) +
  geom_boxplot(fill = "skyblue", outlier.color = "red", outlier.shape = 1) +
  labs(title = "Age Distribution", y = "Age") +
  theme_minimal()

# Boxplot of TSH_Level
ggplot(df, aes(y = TSH_Level)) +
  geom_boxplot(fill = "skyblue", outlier.color = "red", outlier.shape = 1) +
  labs(title = "TSH Level Distribution", y = "Age") +
  theme_minimal()

# Boxplot of T3 Level
ggplot(df, aes(y = T3_Level)) +
  geom_boxplot(fill = "skyblue", outlier.color = "red", outlier.shape = 1) +
  labs(title = "T3_Level Distribution", y = "Age") +
  theme_minimal()

# Boxplot of T4 Level
ggplot(df, aes(y = T4_Level)) +
  geom_boxplot(fill = "skyblue", outlier.color = "red", outlier.shape = 1) +
  labs(title = "T4_Level Distribution", y = "Age") +
  theme_minimal()

# Boxplot of Nodule Size
ggplot(df, aes(y = Nodule_Size)) +
  geom_boxplot(fill = "skyblue", outlier.color = "red", outlier.shape = 1) +
  labs(title = "Nodule_Size Distribution", y = "Age") +
  theme_minimal()

# Correlation between Numerical Variables
library(corrplot)
num_vars <- df %>%
  select(Age, TSH_Level, T3_Level, T4_Level, Nodule_Size)
cor_matrix <- cor(num_vars)
corrplot(cor_matrix, method = "color", addCoef.col = "black", tl.cex = 0.8)

df$Risk_Numeric <- as.numeric(factor(df$Thyroid_Cancer_Risk, levels = c("Low", "Medium", "High")))
cor.test(df$Risk_Numeric, df$Age, method = "spearman")
cor.test(df$Risk_Numeric, df$TSH_Level, method = "spearman")
cor.test(df$Risk_Numeric, df$T3_Level, method = "spearman")
cor.test(df$Risk_Numeric, df$T4_Level, method = "spearman")
cor.test(df$Risk_Numeric, df$Nodule_Size, method = "spearman")

# Age VS Thyroid Cancer Risk
ggplot(df, aes(x = Thyroid_Cancer_Risk, y = Age, fill = Thyroid_Cancer_Risk)) +
  geom_boxplot() +
  labs(title = "Age Distribution by Thyroid Cancer Risk",
       x = "Risk Level", y = "Age") +
  theme_minimal()

# TSH Level VS Thyroid Cancer Risk
ggplot(df, aes(x = Thyroid_Cancer_Risk, y = TSH_Level, fill = Thyroid_Cancer_Risk)) +
  geom_boxplot() +
  labs(title = "TSH Level Distribution by Thyroid Cancer Risk",
       x = "Risk Level", y = "TSH Level") +
  theme_minimal()

# T3 Level VS Thyroid Cancer Risk
ggplot(df, aes(x = Thyroid_Cancer_Risk, y = T3_Level, fill = Thyroid_Cancer_Risk)) +
  geom_boxplot() +
  labs(title = "T3 Level Distribution by Thyroid Cancer Risk",
       x = "Risk Level", y = "T3 Level") +
  theme_minimal()

# T4 Level VS Thyroid Cancer Risk
ggplot(df, aes(x = Thyroid_Cancer_Risk, y = T4_Level, fill = Thyroid_Cancer_Risk)) +
  geom_boxplot() +
  labs(title = "T4 Level VS Thyroid Cancer Risk",
       x = "Thyroid Cancer Risk", y = "T4 Level") +
  theme_minimal()

# Nodule Size VS Thyroid Cancer Risk
ggplot(df, aes(x = Thyroid_Cancer_Risk, y = Nodule_Size, fill = Thyroid_Cancer_Risk)) +
  geom_boxplot() +
  labs(title = "Nodule Size VS Thyroid Cancer Risk",
       x = "Thyroid Cancer Risk", y = "Nodule Size") +
  theme_minimal()

# Relation between Nodule Size and Thyroid Cancer Risk
ggplot(df, aes(x = Age, y = Nodule_Size, color = Thyroid_Cancer_Risk)) +
  geom_point(alpha = 0.7) +
  labs(title = "Hubungan Usia dan Ukuran Nodul berdasarkan Risiko",
       x = "Usia", y = "Ukuran Nodul") +
  theme_minimal()

# Chi-square Test between Thyroid_Cancer_Risk and Categorical Variables
cat_vars <- c("Gender", "Country", "Ethnicity", "Family_History",
              "Radiation_Exposure", "Iodine_Deficiency", "Smoking",
              "Obesity", "Diabetes")

for (var in categorical_vars) {
  tbl <- table(df[[var]], df$Thyroid_Cancer_Risk)
  cat("Chi-square Test for", var, "\n")
  print(chisq.test(tbl))
  cat("\n")
}

# Proportion of Thyroid Cancer Risk by Country
ggplot(df, aes_string(x = "Country", fill = "Thyroid_Cancer_Risk")) +
  geom_bar(position = "fill") +
  labs(title = paste("Thyroid Cancer Risk by Country"),
       y = "Proporsi", x = "Country") +
  scale_y_continuous(labels = scales::percent) +
  theme_minimal()

# Proportion of Thyroid Cancer Risk by Ethnicity
ggplot(df, aes_string(x = "Ethnicity", fill = "Thyroid_Cancer_Risk")) +
  geom_bar(position = "fill") +
  labs(title = paste("Thyroid Cancer Risk by Ethnicity"),
       y = "Proporsi", x = "Ethnicity") +
  scale_y_continuous(labels = scales::percent) +
  theme_minimal()

# Proportion of Thyroid Cancer Risk by Family History
ggplot(df, aes_string(x = "Family_History", fill = "Thyroid_Cancer_Risk")) +
  geom_bar(position = "fill") +
  labs(title = paste("Thyroid Cancer Risk by Family History"),
       y = "Proporsi", x = "Family History") +
  scale_y_continuous(labels = scales::percent) +
  theme_minimal()

# Proportion of Thyroid Cancer Risk by Radiation Exposure
ggplot(df, aes_string(x = "Radiation_Exposure", fill = "Thyroid_Cancer_Risk")) +
  geom_bar(position = "fill") +
  labs(title = paste("Thyroid Cancer Risk by Radiation_Exposure"),
       y = "Proporsi", x = "Radiation_Exposure") +
  scale_y_continuous(labels = scales::percent) +
  theme_minimal()

# Proportion of Thyroid Cancer Risk by Radiation Exposure
ggplot(df, aes_string(x = "Radiation_Exposure", fill = "Thyroid_Cancer_Risk")) +
  geom_bar(position = "fill") +
  labs(title = paste("Thyroid Cancer Risk by Radiation Exposure"),
       y = "Proporsi", x = "Radiation Exposure") +
  scale_y_continuous(labels = scales::percent) +
  theme_minimal()

# Proportion of Thyroid Cancer Risk by Iodine Deficiency
ggplot(df, aes_string(x = "Iodine_Deficiency", fill = "Thyroid_Cancer_Risk")) +
  geom_bar(position = "fill") +
  labs(title = paste("Thyroid Cancer Risk by Iodine Deficiency"),
       y = "Proporsi", x = "Iodine Deficiency") +
  scale_y_continuous(labels = scales::percent) +
  theme_minimal()


# Building Ordinal Logistic Regression Models ----
library(nnet)

df$Thyroid_Cancer_Risk <- as.factor(df$Thyroid_Cancer_Risk)
df$Thyroid_Cancer_Risk <- factor(df$Thyroid_Cancer_Risk, 
                                 levels = c("Low", "Medium", "High"), 
                                 ordered = TRUE)
# Model building
# Model 1: All Variables
model1 <- polr(Thyroid_Cancer_Risk ~ Age + Gender + Country + Ethnicity + Family_History + Radiation_Exposure + Iodine_Deficiency + Smoking + Obesity + Diabetes + TSH_Level + T3_Level + T4_Level + Nodule_Size, data = df, Hess = TRUE) 

# Model 2: Numerical Only
model2 <- polr(Thyroid_Cancer_Risk ~ Age + TSH_Level + T3_Level + T4_Level + Nodule_Size, data = df, Hess = TRUE) 

# Model 3: Categorical Only
model3 <- polr(Thyroid_Cancer_Risk ~ Gender + Country + Ethnicity + Family_History + Radiation_Exposure + Iodine_Deficiency + Smoking + Obesity + Diabetes, data = df, Hess = TRUE)

# Model Summary
# Model 1
ctable1 <- coef(summary(model1))
p_values1 <- pnorm(abs(ctable1[, "t value"]), lower.tail = FALSE) * 2
ctable1 <- cbind(ctable1, "p value"= round(p_values1, 5))
print(ctable1)

# Model 2
ctable2 <- coef(summary(model2))
p_values2 <- pnorm(abs(ctable2[, "t value"]), lower.tail = FALSE) * 2
ctable2 <- cbind(ctable2, round(p_values2, 5))
print(ctable2)

# Model 3
ctable3 <- coef(summary(model3))
p_values3 <- pnorm(abs(ctable3[, "t value"]), lower.tail = FALSE) * 2
ctable3 <- cbind(ctable3, round(p_values3, 5))
print(ctable3)

# Model Evaluation ----
levels_ordered <- levels(df$Thyroid_Cancer_Risk)

# Model 1
predicted1 <- predict(model1, newdata = df)
predicted1 <- factor(predicted1, levels = levels_ordered, ordered = TRUE)
conf_matrix1 <- table(Predicted = predicted1, Actual = df$Thyroid_Cancer_Risk)
accuracy1 <- mean(predicted1 == df$Thyroid_Cancer_Risk)

# Model 2
predicted2 <- predict(model2, newdata = df)
predicted2 <- factor(predicted2, levels = levels_ordered, ordered = TRUE)
conf_matrix2 <- table(Predicted = predicted2, Actual = df$Thyroid_Cancer_Risk)
accuracy2 <- mean(predicted2 == df$Thyroid_Cancer_Risk)

# Model 3
predicted3 <- predict(model3, newdata = df)
predicted3 <- factor(predicted3, levels = levels_ordered, ordered = TRUE)
conf_matrix3 <- table(Predicted = predicted3, Actual = df$Thyroid_Cancer_Risk)
accuracy3 <- mean(predicted3 == df$Thyroid_Cancer_Risk)

# Print results
cat("Accuracy - Model 1 (All Variables):", round(accuracy1 * 100, 3), "%\n")
cat("Accuracy - Model 2 (Numerical Only):", round(accuracy2 * 100, 3), "%\n")
cat("Accuracy - Model 3 (Categorical Only):", round(accuracy3 * 100, 3), "%\n")


# Model Comparison Visualization ----
# Create data frame for all models' accuracy
accuracy_df <- data.frame(
  Model = c("Model 1 (All Variables)", "Model 2 (Numerical Only)", "Model 3 (Categorical Only)"),
  Accuracy = c(accuracy1, accuracy2, accuracy3)
)

# Plot
library(ggplot2)
ggplot(accuracy_df, aes(x = Model, y = Accuracy, fill = Model)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = paste0(round(Accuracy * 100, 3), "%")), vjust = -0.5) +
  ylim(0, 1) +
  labs(title = "Model Accuracy Comparison", x = "Model", y = "Accuracy") +
  scale_fill_manual(values = c("salmon", "forestgreen", "cornflowerblue")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 30, hjust = 1))




