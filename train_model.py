"""
Script to train Linear Regression model for salary prediction API.
Outputs linear_regression.joblib and feature_columns.joblib for Railway deployment.
"""
import pandas as pd
import numpy as np
import sys

# Check if sklearn is available
try:
    from sklearn.linear_model import LinearRegression
    from sklearn.model_selection import train_test_split
    from sklearn.metrics import r2_score, mean_squared_error
    import joblib
    print("✓ All packages imported successfully")
except ImportError as e:
    print(f"Error importing packages: {e}")
    sys.exit(1)

# Load data
print("\n--- Loading Data ---")
df = pd.read_csv(r'C:\Users\VICTOR HUGO\Desktop\salary_data_cleaned.csv')
print(f"Dataset loaded: {len(df)} rows, {len(df.columns)} columns")

# Define features expected by API
EXPECTED_FEATURES = [
    'rating', 'age', 'same_state', 'python_yn', 'R_yn', 
    'spark', 'aws', 'excel', 'job_simp', 'seniority', 
    'desc_len', 'num_comp'
]

print(f"\nExpected features: {EXPECTED_FEATURES}")

# Check which features exist in dataset
existing_features = [f for f in EXPECTED_FEATURES if f in df.columns]
missing_features = [f for f in EXPECTED_FEATURES if f not in df.columns]

print(f"Found {len(existing_features)} features in dataset")
if missing_features:
    print(f"Missing features: {missing_features}")

# Preprocessing
print("\n--- Preprocessing ---")

# Create copy for processing
data = df.copy()

# Handle 'age' - if missing, calculate from 'Founded' column
if 'age' not in data.columns and 'Founded' in data.columns:
    current_year = 2024
    data['age'] = data['Founded'].apply(lambda x: current_year - x if x > 0 else 0)
    print("✓ Created 'age' from Founded column")

# Handle 'same_state' - if missing, try to derive from Location/Headquarters
if 'same_state' not in data.columns:
    if 'Location' in data.columns and 'Headquarters' in data.columns:
        def get_state(loc):
            if pd.isna(loc) or loc == '-1':
                return None
            parts = str(loc).split(',')
            return parts[-1].strip() if len(parts) > 1 else loc
        
        data['same_state'] = (
            data['Location'].apply(get_state) == data['Headquarters'].apply(get_state)
        ).astype(int)
        print("✓ Created 'same_state' from Location/Headquarters")
    else:
        data['same_state'] = 0
        print("⚠ 'same_state' set to 0 (no location data)")

# Handle 'desc_len' - if missing, use Job Description length
if 'desc_len' not in data.columns and 'Job Description' in data.columns:
    data['desc_len'] = data['Job Description'].str.len().fillna(0)
    print("✓ Created 'desc_len' from Job Description length")

# Handle 'num_comp' - if missing, try to count competitors
if 'num_comp' not in data.columns:
    if 'Competitors' in data.columns:
        def count_competitors(comp):
            if pd.isna(comp) or comp == '-1' or comp == -1:
                return 0
            return len(str(comp).split(','))
        data['num_comp'] = data['Competitors'].apply(count_competitors)
        print("✓ Created 'num_comp' from Competitors column")
    else:
        data['num_comp'] = 0
        print("⚠ 'num_comp' set to 0")

# Handle skill columns - python_yn, R_yn, spark, aws, excel
skill_cols = ['python_yn', 'R_yn', 'spark', 'aws', 'excel']
for col in skill_cols:
    if col not in data.columns:
        data[col] = 0
        print(f"⚠ '{col}' set to 0")

# Handle job_simp and seniority - use STRING values for one-hot encoding (matching API)
if 'job_simp' not in data.columns and 'Job Title' in data.columns:
    # Map to string categories that API will use
    def classify_job(title):
        title = str(title).lower()
        if 'scientist' in title:
            return 'data scientist'
        elif 'analyst' in title:
            return 'analyst'
        elif 'engineer' in title:
            return 'data engineer'
        elif 'manager' in title or 'director' in title:
            return 'manager'
        else:
            return 'other'
    data['job_simp'] = data['Job Title'].apply(classify_job)
    print("✓ Created 'job_simp' from Job Title (as string for one-hot encoding)")

if 'seniority' not in data.columns and 'Job Title' in data.columns:
    def get_seniority(title):
        title = str(title).lower()
        if 'senior' in title or 'sr.' in title:
            return 'senior'
        elif 'junior' in title or 'jr.' in title:
            return 'junior'
        else:
            return 'na'
    data['seniority'] = data['Job Title'].apply(get_seniority)
    print("✓ Created 'seniority' from Job Title (as string for one-hot encoding)")

# Handle rating
if 'rating' not in data.columns and 'Rating' in data.columns:
    data['rating'] = pd.to_numeric(data['Rating'], errors='coerce').fillna(3.0)
    print("✓ Using 'Rating' column as 'rating'")
elif 'rating' not in data.columns:
    data['rating'] = 3.0
    print("⚠ 'rating' set to default 3.0")

# Determine target variable
target_column = None
for col in ['avg_salary', 'Avg Salary(K)', 'Salary Estimate', 'min_salary', 'max_salary']:
    if col in data.columns:
        target_column = col
        break

if target_column is None:
    print("\n⚠ No salary column found. Looking for alternatives...")
    salary_cols = [c for c in data.columns if 'salary' in c.lower()]
    print(f"Found salary-related columns: {salary_cols}")
    if salary_cols:
        target_column = salary_cols[0]
    else:
        print("ERROR: Cannot find a suitable target column")
        sys.exit(1)

print(f"\n✓ Using '{target_column}' as target variable")

# Prepare target
if target_column == 'Salary Estimate':
    # Parse salary range like "$50K - $100K (Glassdoor est.)"
    def parse_salary(s):
        if pd.isna(s):
            return np.nan
        s = str(s).replace('$', '').replace('K', '').replace(',', '')
        s = s.split('(')[0].strip()
        parts = s.split('-')
        try:
            if len(parts) == 2:
                return (float(parts[0].strip()) + float(parts[1].strip())) / 2
            return float(parts[0].strip())
        except:
            return np.nan
    data['target'] = data[target_column].apply(parse_salary)
else:
    data['target'] = pd.to_numeric(data[target_column], errors='coerce')

# Verify all features exist now
print("\n--- Feature Verification ---")
final_features = []
for f in EXPECTED_FEATURES:
    if f in data.columns:
        final_features.append(f)
        print(f"✓ {f}")
    else:
        print(f"✗ {f} - MISSING")

# Prepare dataset with ONE-HOT ENCODING for job_simp and seniority
# This matches how the API preprocesses data using pd.get_dummies()
print("\n--- One-Hot Encoding (matching API) ---")
X = data[final_features].copy()
y = data['target'].copy()

# Remove rows with missing target first
valid_idx = y.notna()
X = X[valid_idx]
y = y[valid_idx]

# Handle numeric columns
numeric_cols = ['rating', 'age', 'same_state', 'python_yn', 'R_yn', 'spark', 'aws', 'excel', 'desc_len', 'num_comp']
for col in numeric_cols:
    if col in X.columns:
        X[col] = pd.to_numeric(X[col], errors='coerce').fillna(0)

# Apply one-hot encoding to categorical columns (like the API does)
categorical_cols = ['job_simp', 'seniority']
X = pd.get_dummies(X, columns=[c for c in categorical_cols if c in X.columns], drop_first=True)

# Get the final feature column names after one-hot encoding
final_feature_columns = list(X.columns)
print(f"Features after one-hot encoding: {final_feature_columns}")

print(f"\n✓ Final dataset: {len(X)} samples, {len(final_feature_columns)} features")

# Train model
print("\n--- Training Model ---")
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

model = LinearRegression()
model.fit(X_train, y_train)

# Evaluate
y_pred = model.predict(X_test)
r2 = r2_score(y_test, y_pred)
rmse = np.sqrt(mean_squared_error(y_test, y_pred))

print(f"R² Score: {r2:.4f}")
print(f"RMSE: {rmse:.2f}")

# Feature importance
print("\n--- Feature Coefficients ---")
for feat, coef in sorted(zip(final_feature_columns, model.coef_), key=lambda x: abs(x[1]), reverse=True):
    print(f"  {feat}: {coef:.4f}")

# Save models
print("\n--- Saving Models ---")
joblib.dump(model, 'linear_regression.joblib')
joblib.dump(final_feature_columns, 'feature_columns.joblib')

print(f"\n✓ Saved: linear_regression.joblib")
print(f"✓ Saved: feature_columns.joblib")
print(f"\nFeatures saved: {final_feature_columns}")
print("\n✅ DONE! Upload these files to your Railway repository's models/ folder.")
