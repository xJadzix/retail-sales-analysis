WITH reference_date AS (
	SELECT MAX(TO_TIMESTAMP("InvoiceDate", 'MM/DD/YYYY HH24:MI')) AS max_date
	FROM online_retail 
),
metrics AS (
	SELECT 
		"CustomerID",
		MAX(TO_TIMESTAMP("InvoiceDate", 'MM/DD/YYYY HH24:MI')) AS last_purchase_date,
		COUNT(DISTINCT "InvoiceNo") AS frequency,
		ROUND(SUM("Quantity"*"UnitPrice")::NUMERIC, 2) AS monetary
	FROM online_retail
	WHERE "InvoiceNo" NOT LIKE 'C%' AND "CustomerID" IS NOT NULL
	GROUP BY "CustomerID" 
),
reference_metrics AS (
	SELECT
		m."CustomerID",
		EXTRACT(DAY FROM r.max_date - m.last_purchase_date) AS recency_days,
		m.frequency,
		m.monetary
	FROM metrics AS m, reference_date AS r
),
scores AS (
	SELECT
		"CustomerID",
		recency_days,
		frequency,
		monetary,
		NTILE(3) OVER (ORDER BY recency_days ASC) AS r_score,
		NTILE(3) OVER (ORDER BY frequency  DESC) AS f_score,
		NTILE(3) OVER (ORDER BY monetary DESC) AS m_score
	FROM reference_metrics 
),
segmented AS (
	SELECT 
		"CustomerID",
		r_score,
		f_score,
		m_score,
		CASE 
			WHEN r_score = 1 AND f_score = 1 AND m_score = 1 THEN 'VIP'
			WHEN r_score = 1 AND f_score = 1 THEN 'Loyal'
			WHEN r_score = 3 AND f_score = 1 THEN 'At Risk'
			WHEN r_score = 1 THEN 'Promising'
			ELSE 'Other'
		END AS segment	
	FROM scores
)
SELECT 
	segment,
	COUNT(*) AS customer_count,
	ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (), 1) AS pct_of_total
FROM segmented 
GROUP BY segment
ORDER BY customer_count DESC;
