"""
Task 1: Data Cleaning and Preprocessing
Run: python clean_data.py
Input : raw_customer_data.csv
Output: cleaned_customer_data.csv
"""
import pandas as pd

df = pd.read_csv("raw_customer_data.csv")

# 1. Standardize column names
df.columns = (df.columns.str.strip().str.lower()
              .str.replace(r"\s+", "_", regex=True))

# 2. Remove duplicate rows
df = df.drop_duplicates()

# 3. Clean text fields
for col in ["customer_name", "city", "gender"]:
    df[col] = df[col].astype("string").str.strip()
df["city"] = df["city"].str.title()

# 4. Standardize gender values
gender_map = {"f": "Female", "female": "Female",
              "m": "Male", "male": "Male"}
df["gender"] = df["gender"].str.lower().map(gender_map)
df["gender"] = df["gender"].fillna("Unknown")

# 5. Convert and validate numeric fields
df["age"] = pd.to_numeric(df["age"], errors="coerce")
df.loc[~df["age"].between(0, 100), "age"] = pd.NA
df["age"] = df["age"].fillna(df["age"].median()).round().astype("int64")

df["purchase_amount"] = pd.to_numeric(df["purchase_amount"], errors="coerce")
df["purchase_amount"] = df["purchase_amount"].fillna(
    df["purchase_amount"].median()
)

# 6. Standardize dates; remove rows with dates that cannot be parsed
df["join_date"] = pd.to_datetime(df["join_date"], errors="coerce", format="mixed", dayfirst=True)
df = df.dropna(subset=["join_date"])
df["join_date"] = df["join_date"].dt.strftime("%d-%m-%Y")

# 7. Save cleaned data
df.to_csv("cleaned_customer_data.csv", index=False)
print("Cleaning completed. Output: cleaned_customer_data.csv")
print(f"Rows after cleaning: {len(df)}")
