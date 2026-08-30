# Retail Sales & Customer Intelligence Dashboard

An end-to-end data analytics project analyzing 1M+ e-commerce transactions using **PostgreSQL** and **Python**, featuring customer segmentation (RFM analysis), market basket analysis, and an interactive live dashboard.

🔗 **Live Dashboard:** https://retail-sales-dashboard-r7um.onrender.com

## Business Problem
This project analyzes transactional data from a UK-based online retailer (2009-2011) to answer key business questions:
- What are our revenue trends, and when do sales peak?
- Which products and countries drive the most revenue?
- Which customers are most valuable, and which are at risk of churning?
- Which products are frequently bought together (cross-sell opportunities)?

## Tech Stack
- **SQL:** PostgreSQL (CTEs, window functions, aggregations)
- **Python:** Pandas, NumPy for data cleaning and analysis
- **Visualization:** Matplotlib, Seaborn, Plotly
- **Dashboard:** Plotly Dash, deployed on Render
- **Machine Learning:** Market Basket Analysis (Apriori algorithm via mlxtend)

## Key Insights
- **Seasonal spike:** Revenue peaks every November (~£1.4-1.5M), driven by holiday shopping, then drops sharply in December.
- **Customer segmentation (RFM):** Identified high-value "At Risk" customers — customers who historically spent significantly but haven't purchased recently, representing a strong retention opportunity.
- **Market basket analysis:** Found strong product affinities (e.g., matching teacup/saucer sets bought together 76% of the time), suggesting opportunities for bundle promotions.
- **Geographic concentration:** UK dominates revenue, with EIRE, Netherlands, and Germany as the next largest markets.

## Project Structure
1. **Data Engineering:** Loaded 1M+ transaction records into PostgreSQL
2. **SQL Analysis:** Wrote analytical queries using CTEs and window functions for revenue trends, customer metrics, and cohort analysis
3. **Data Cleaning:** Handled duplicates, missing values, returns, and invalid entries using Pandas
4. **EDA:** Visualized trends, top products, and geographic performance
5. **Customer Segmentation:** Built an RFM (Recency, Frequency, Monetary) model to classify customers into segments (Champions, Loyal, At Risk, Lost)
6. **Market Basket Analysis:** Applied the Apriori algorithm to find product association rules
7. **Dashboard:** Built and deployed an interactive Plotly Dash dashboard

## Dataset
[Online Retail II](https://archive.ics.uci.edu/dataset/502/online+retail+ii) — UCI Machine Learning Repository

## Author
Md Ayaan U Ansari