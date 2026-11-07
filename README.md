# Task 1: Data Cleaning and Preprocessing

## Objective
Clean a raw dataset containing missing values, duplicate rows, inconsistent text, and mixed date formats.

## Tools
- Python
- Pandas

## Dataset
This repository includes a small illustrative customer dataset with deliberately inserted data-quality issues. It is sample data created for demonstrating the task; it is not downloaded from Kaggle and does not contain real customer information.

## Files
- `raw_customer_data.csv` – raw sample dataset.
- `cleaned_customer_data.csv` – processed dataset.
- `clean_data.py` – reproducible cleaning script.
- `cleaning_summary.md` – summary of the cleaning steps and row counts.

## How to run
1. Install Python 3.
2. Install Pandas: `pip install pandas`
3. Keep `clean_data.py` and `raw_customer_data.csv` in the same folder.
4. Run: `python clean_data.py`

The script creates `cleaned_customer_data.csv` in the current folder.

## Cleaning performed
Duplicate removal, column-name standardization, text cleanup, gender standardization, numeric conversion and validation, missing-value handling, and date standardization.

## Important
Review the cleaning rules before applying them to real business data. In particular, median imputation and the valid age range are demonstration assumptions.
