SELECT 
    DATE_FORMAT(rental_date, '%Y-%m') AS month, 
    COUNT(DISTINCT customer_id) AS active_customers
FROM rental
GROUP BY month
ORDER BY month;
-- Get the last month in the data
SELECT 
    DATE_FORMAT(MAX(rental_date), '%Y-%m') AS last_month 
FROM rental;

-- Substitute '2023-05' with the last month from the previous query result
SELECT 
    COUNT(DISTINCT customer_id) AS active_customers_previous_month 
FROM rental
WHERE DATE_FORMAT(rental_date, '%Y-%m') = '2023-05';
-- Get the last two months with active customers
WITH active_customers AS (
    SELECT 
        DATE_FORMAT(rental_date, '%Y-%m') AS month, 
        COUNT(DISTINCT customer_id) AS active_customers
    FROM rental
    GROUP BY month
    ORDER BY month DESC
    LIMIT 2
)

SELECT 
    month,
    active_customers,
    LAG(active_customers, 1) OVER (ORDER BY month) AS previous_month_customers,
    ((active_customers - LAG(active_customers, 1) OVER (ORDER BY month)) / LAG(active_customers, 1) OVER (ORDER BY month)) * 100 AS percentage_change
FROM active_customers;
WITH customer_months AS (
    SELECT 
        customer_id, 
        DATE_FORMAT(rental_date, '%Y-%m') AS month
    FROM rental
    GROUP BY customer_id, month
)

SELECT 
    cm1.month AS current_month,
    cm1.customer_id,
    COUNT(cm2.customer_id) AS retained_customers
FROM customer_months cm1
JOIN customer_months cm2 
    ON cm1.customer_id = cm2.customer_id
    AND DATE_ADD(cm2.month, INTERVAL 1 MONTH) = cm1.month
GROUP BY cm1.month, cm1.customer_id
ORDER BY cm1.month;
SELECT 
    DATE_FORMAT(rental_date, '%Y-%m') AS month, 
    COUNT(DISTINCT customer_id) AS active_customers
FROM rental
GROUP BY month
ORDER BY month;
-- Substitute '2023-05' with the last month from the query result
SELECT 
    COUNT(DISTINCT customer_id) AS active_customers_previous_month 
FROM rental
WHERE DATE_FORMAT(rental_date, '%Y-%m') = '2023-05';
WITH active_customers AS (
    SELECT 
        DATE_FORMAT(rental_date, '%Y-%m') AS month, 
        COUNT(DISTINCT customer_id) AS active_customers
    FROM rental
    GROUP BY month
    ORDER BY month DESC
    LIMIT 2
)

SELECT 
    month,
    active_customers,
    LAG(active_customers, 1) OVER (ORDER BY month) AS previous_month_customers,
    ((active_customers - LAG(active_customers, 1) OVER (ORDER BY month)) / LAG(active_customers, 1) OVER (ORDER BY month)) * 100 AS percentage_change
FROM active_customers;
WITH customer_months AS (
    SELECT 
        customer_id, 
        DATE_FORMAT(rental_date, '%Y-%m') AS month
    FROM rental
    GROUP BY customer_id, month
)

SELECT 
    cm1.month AS current_month,
    cm1.customer_id,
    COUNT(cm2.customer_id) AS retained_customers
FROM customer_months cm1
JOIN customer_months cm2 
    ON cm1.customer_id = cm2.customer_id
    AND DATE_ADD(cm2.month, INTERVAL 1 MONTH) = cm1.month
   GROUP BY cm1.month, cm1.customer_id
   ORDER BY cm1
