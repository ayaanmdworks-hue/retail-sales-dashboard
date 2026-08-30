-- Table creation
CREATE TABLE retail_transactions (
    invoice_no      VARCHAR(20),
    stock_code      VARCHAR(20),
    description     TEXT,
    quantity        INTEGER,
    invoice_date    TIMESTAMP,
    unit_price      NUMERIC(10,2),
    customer_id     INTEGER,
    country         VARCHAR(50)
);

-- Query 1: Monthly Revenue Trend
SELECT 
    DATE_TRUNC('month', invoice_date) AS month,
    SUM(quantity * unit_price) AS total_revenue
FROM retail_transactions
WHERE quantity > 0
GROUP BY DATE_TRUNC('month', invoice_date)
ORDER BY month;

-- Query 2: Top 10 Products by Revenue
SELECT 
    stock_code,
    description,
    SUM(quantity * unit_price) AS total_revenue,
    SUM(quantity) AS total_units_sold
FROM retail_transactions
WHERE quantity > 0
GROUP BY stock_code, description
ORDER BY total_revenue DESC
LIMIT 10;

-- Query 3: Revenue by Country
SELECT 
    country,
    SUM(quantity * unit_price) AS total_revenue,
    COUNT(DISTINCT invoice_no) AS total_orders
FROM retail_transactions
WHERE quantity > 0
GROUP BY country
ORDER BY total_revenue DESC;

-- Query 4: Top 10 Customers by Spend
SELECT 
    customer_id,
    SUM(quantity * unit_price) AS total_spent,
    COUNT(DISTINCT invoice_no) AS total_orders
FROM retail_transactions
WHERE quantity > 0 AND customer_id IS NOT NULL
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- Query 5: RFM Base Metrics (Recency, Frequency, Monetary)
SELECT 
    customer_id,
    MAX(invoice_date) AS last_purchase_date,
    COUNT(DISTINCT invoice_no) AS frequency,
    SUM(quantity * unit_price) AS monetary
FROM retail_transactions
WHERE quantity > 0 AND customer_id IS NOT NULL
GROUP BY customer_id;

-- Query 6: Monthly New vs Returning Customers
WITH first_purchase AS (
    SELECT 
        customer_id,
        MIN(DATE_TRUNC('month', invoice_date)) AS first_month
    FROM retail_transactions
    WHERE quantity > 0 AND customer_id IS NOT NULL
    GROUP BY customer_id
)
SELECT 
    DATE_TRUNC('month', t.invoice_date) AS month,
    COUNT(DISTINCT CASE WHEN DATE_TRUNC('month', t.invoice_date) = f.first_month THEN t.customer_id END) AS new_customers,
    COUNT(DISTINCT CASE WHEN DATE_TRUNC('month', t.invoice_date) != f.first_month THEN t.customer_id END) AS returning_customers
FROM retail_transactions t
JOIN first_purchase f ON t.customer_id = f.customer_id
WHERE t.quantity > 0
GROUP BY DATE_TRUNC('month', t.invoice_date)
ORDER BY month;