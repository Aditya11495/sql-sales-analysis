-- Total revenue generated
SELECT SUM(quantity * price) AS total_revenue
FROM sales;
SELECT 
    DATE_TRUNC('month', order_date) AS month,
    SUM(quantity * price) AS monthly_revenue
FROM sales
GROUP BY month
ORDER BY month;
-- Top 5 customers by total revenue
SELECT 
    customer_id,
    SUM(quantity * price) AS total_revenue
FROM sales
GROUP BY customer_id
ORDER BY total_revenue DESC
LIMIT 5;
-- Top 5 products by revenue
SELECT 
    product_id,
    SUM(quantity * price) AS product_revenue
FROM sales
GROUP BY product_id
ORDER BY product_revenue DESC
LIMIT 5;
-- Average order value
SELECT 
    AVG(order_total) AS avg_order_value
FROM (
    SELECT 
        order_id,
        SUM(quantity * price) AS order_total
    FROM sales
    GROUP BY order_id
) t;
-- Revenue contribution percentage per customer
SELECT 
    customer_id,
    SUM(quantity * price) AS customer_revenue,
    ROUND(
        100.0 * SUM(quantity * price) 
        / SUM(SUM(quantity * price)) OVER (), 2
    ) AS revenue_percentage
FROM sales
GROUP BY customer_id
ORDER BY customer_revenue DESC;
-- Rank customers based on revenue
SELECT 
    customer_id,
    SUM(quantity * price) AS total_revenue,
    RANK() OVER (ORDER BY SUM(quantity * price) DESC) AS revenue_rank
FROM sales
GROUP BY customer_id;
-- Customers with revenue greater than average
SELECT 
    customer_id,
    SUM(quantity * price) AS total_revenue
FROM sales
GROUP BY customer_id
HAVING SUM(quantity * price) > (
    SELECT AVG(quantity * price) FROM sales
);
