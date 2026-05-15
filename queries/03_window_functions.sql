-- Total quantity across all rows (no partitioning)
SELECT
    "Country",
    "InvoiceNo",
    "Quantity",
    SUM("Quantity") OVER () AS total_quantity_all
FROM online_retail
LIMIT 20;

-- Total quantity partitioned by country
SELECT
    "Country",
    "InvoiceNo",
    "Quantity",
    SUM("Quantity") OVER (PARTITION BY "Country") AS total_quantity_per_country
FROM online_retail
LIMIT 20;

-- Row number ordered by quantity descending
SELECT
    "Country",
    "InvoiceNo",
    "Quantity",
    ROW_NUMBER() OVER (ORDER BY "Quantity" DESC) AS row_num
FROM online_retail
LIMIT 20;

-- Row number partitioned by country, ordered by quantity descending
SELECT
    "Country",
    "InvoiceNo",
    "Quantity",
    ROW_NUMBER() OVER (PARTITION BY "Country" ORDER BY "Quantity" DESC) AS row_num
FROM online_retail
ORDER BY "Country", row_num
LIMIT 30;

-- Top 3 invoices by quantity per country
SELECT *
FROM (
    SELECT
        "Country",
        "InvoiceNo",
        "Quantity",
        ROW_NUMBER() OVER (PARTITION BY "Country" ORDER BY "Quantity" DESC) AS row_num
    FROM online_retail
) AS numbered
WHERE row_num <= 3
ORDER BY "Country", row_num;

-- Country revenue ranking
WITH country_revenue AS (
    SELECT
        "Country",
        ROUND(SUM("Quantity" * "UnitPrice")::numeric, 2) AS total_revenue
    FROM online_retail
    WHERE "InvoiceNo" NOT LIKE 'C%'
    GROUP BY "Cou
