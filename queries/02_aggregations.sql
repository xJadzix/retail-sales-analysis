-- Revenue per country
SELECT
    "Country",
    ROUND(SUM("Quantity" * "UnitPrice")::numeric, 2) AS total_revenue,
    COUNT(*) AS transaction_count
FROM online_retail
WHERE "InvoiceNo" NOT LIKE 'C%'
GROUP BY "Country"
ORDER BY total_revenue DESC;

-- Top 10 countries by revenue
SELECT
    "Country",
    ROUND(SUM("Quantity" * "UnitPrice")::numeric, 2) AS total_revenue
FROM online_retail
WHERE "InvoiceNo" NOT LIKE 'C%'
GROUP BY "Country"
ORDER BY total_revenue DESC
LIMIT 10;

-- Top 10 best-selling products by quantity
SELECT
    "Description",
    SUM("Quantity") AS total_qty
FROM online_retail
WHERE "InvoiceNo" NOT LIKE 'C%'
    AND "Description" IS NOT NULL
GROUP BY "Description"
ORDER BY total_qty DESC
LIMIT 10;

-- Average transaction value per country
SELECT
    "Country",
    ROUND(AVG("Quantity" * "UnitPrice")::numeric, 2) AS avg_transaction_value,
    COUNT(*) AS transaction_count
FROM online_retail
WHERE "InvoiceNo" NOT LIKE 'C%'
GROUP BY "Country"
ORDER BY avg_transaction_value DESC
LIMIT 15;

-- Countries with more than 1000 transactions
SELECT
    "Country",
    COUNT(*) AS transaction_count,
    ROUND(SUM("Quantity" * "UnitPrice")::numeric, 2) AS total_revenue
FROM online_retail
WHERE "InvoiceNo" NOT LIKE 'C%'
GROUP BY "Country"
HAVING COUNT(*) > 1000
ORDER BY transaction_count DESC;

-- Products bought by more than 100 unique customers
SELECT
    "Description",
    COUNT(DISTINCT "CustomerID") AS unique_customers
FROM online_retail
WHERE "InvoiceNo" NOT LIKE 'C%'
    AND "CustomerID" IS NOT NULL
GROUP BY "Description"
HAVING COUNT(DISTINCT "CustomerID") > 100
ORDER BY unique_customers DESC;

-- Average revenue per invoice in Germany
SELECT ROUND(AVG(invoice_revenue)::numeric, 2) AS avg_invoice_revenue
FROM (
    SELECT
        "InvoiceNo",
        SUM("UnitPrice" * "Quantity") AS invoice_revenue
    FROM online_retail
    WHERE "Country" = 'Germany'
        AND "InvoiceNo" NOT LIKE 'C%'
    GROUP BY "InvoiceNo"
) AS subquery;
