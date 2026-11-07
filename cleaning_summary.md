# Data Cleaning Summary

## Dataset
Illustrative customer purchase dataset created for this internship task. It is a small sample dataset, not a Kaggle download or real customer data.

## Changes performed
- Removed duplicate rows.
- Renamed column headers to lowercase with underscores.
- Removed extra spaces from text values and standardized city capitalization.
- Standardized gender values to `Female`, `Male`, or `Unknown`.
- Converted age and purchase amount to numeric values.
- Treated ages outside 0–100 as invalid and replaced missing/invalid ages with the median valid age.
- Replaced missing purchase amounts with the median.
- Parsed mixed date formats and converted dates to `DD-MM-YYYY`.
- Removed rows with dates that could not be parsed.

## Row counts
- Raw rows: 12
- Rows after duplicate removal: 11
- Final cleaned rows: 11

## Files
- `raw_customer_data.csv` – original sample data with intentional data-quality issues.
- `cleaned_customer_data.csv` – cleaned output.
- `clean_data.py` – Python script used for cleaning.
- `README.md` – project instructions and overview.

## Note
The median replacement and age validation rules are example choices for this practice dataset. For a real dataset, confirm appropriate rules with the data owner before changing values.
