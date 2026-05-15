-- How many rows in the table?
SELECT COUNT(*) FROM online_retail;

-- How do the rows look like?
SELECT * FROM online_retail LIMIT 10;

-- How many unique countries?
SELECT COUNT(DISTINCT "Country") FROM online_retail;

-- What countries do we have?
SELECT DISTINCT "Country" FROM online_retail ORDER BY "Country";

-- How many unique clients?
SELECT COUNT(DISTINCT "CustomerID") FROM online_retail;

-- Are there any null values in CustomerID?
SELECT COUNT(*) FROM online_retail WHERE "CustomerID" IS NULL;

-- Transactions with price = 0 - suspicious cases
SELECT * FROM online_retail WHERE "UnitPrice" = 0;

-- How many returns (InvoiceNo starting with C)?
SELECT COUNT(*) AS num_returns
FROM online_retail
WHERE "InvoiceNo" LIKE 'C%';
