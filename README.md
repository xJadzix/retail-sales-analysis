# Retail Sales Analysis

SQL analysis of a real-world e-commerce dataset containing ~540 000 transactions
from a UK-based online retailer. The project covers exploratory analysis,
aggregations, window functions, and RFM customer segmentation.

## Dataset

[Online Retail - UCI / Kaggle](https://www.kaggle.com/datasets/vijayuv/onlineretail)

Transactions from a UK-based online retailer (2010-2011).
Data not included in this repository due to file size - download directly from Kaggle.

## Tools

- PostgreSQL 17
- DBeaver (SQL client)

## Project Structure
```
queries/
├── 01_exploration.sql - row counts, nulls, distinct values
├── 02_aggregations.sql - revenue by country, top products, HAVING
├── 03_window_functions.sql - ROW_NUMBER, RANK, LAG, monthly trends
└── 04_rfm.sql - RFM customer segmentation with NTILE
README.md - dataset source and description
```
## Key Findings

- **Top market**: United Kingdom accounts for the vast majority of revenue
- **Seasonality**: Revenue peaks in October-November 2011 ahead of the holiday season;
  December appears lower but the data covers only 9 days of the month
- **Customer segments** (RFM analysis):
  - 3% VIP customers - recent, frequent, high spend
  - 19% At Risk - previously frequent buyers who have not returned
  - 29.5% Promising - recent but not frequent (good retention targets)
