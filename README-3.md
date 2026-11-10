# Task 4: Sales & Financial Dashboard

## Objective
Create an interactive dashboard that helps business stakeholders understand sales and financial performance.

## Files included
- `sales_financial_dataset.csv` — 500-row sample dataset (synthetic).
- `sales_dashboard_workbook.xlsx` — Excel preview with KPI summary and charts.
- `task4_dashboard_summary.pptx` — 9-slide project summary.
- `README.md` — project documentation.

## Dataset fields
Order_ID, Order_Date, Year, Month, Region, Category, Product, Units_Sold, Unit_Price, Sales, Cost, Profit.

## Build the interactive dashboard in Power BI
1. Open Power BI Desktop (free) and select **Get Data → Text/CSV**.
2. Import `sales_financial_dataset.csv`.
3. Create KPI cards for Sales, Profit, Profit Margin and Units Sold.
4. Add a line chart with Month on the X-axis and Sales and Profit as values.
5. Add a bar chart with Category and Sales.
6. Add slicers for Year, Month, Region and Category.
7. Format the page with a consistent navy/blue/white theme.
8. Save the report as a `.pbix` file and take screenshots for your submission.

## Suggested DAX measures
```DAX
Total Sales = SUM(Sales_Financial[Sales])
Total Profit = SUM(Sales_Financial[Profit])
Total Units = SUM(Sales_Financial[Units_Sold])
Profit Margin = DIVIDE([Total Profit], [Total Sales], 0)
```

## Important note
The dataset is synthetic sample data generated for this assignment. It is not actual company or Kaggle data. Mention this clearly in your submission and replace it if your instructor requires a specific Kaggle dataset.

## GitHub submission
Create a new repository named `task-4-dashboard-design`, upload these files, add your final Power BI `.pbix` file and dashboard screenshots, then submit the repository link.
