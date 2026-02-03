SELECT 
    SUM(Quantity * Amount) AS total_revenue         --Total Revenue (Amount × Quantity)
FROM sales; 


SELECT 
    SUM(Profit) AS total_profit                 --Total Profit
FROM sales;



SELECT 
    DATE_FORMAT(`Order Date`, '%Y-%m') AS month,     --Monthly Revenue
    SUM(Quantity * Amount) AS monthly_revenue                 
FROM sales
GROUP BY month
ORDER BY month;


SELECT 
    CustomerName,
    SUM(Quantity * Amount) AS total_revenue          --Top 5 Customers by Total Revenue
FROM sales
GROUP BY CustomerName
ORDER BY total_revenue DESC
LIMIT 5;



SELECT 
    `Sub-Category`,
    SUM(Quantity * Amount) AS subcategory_revenue       --. Top 5 Sub-Categories by Revenue
FROM sales
GROUP BY `Sub-Category`
ORDER BY subcategory_revenue DESC
LIMIT 5;




SELECT 
    AVG(order_total) AS avg_order_value
FROM (
    SELECT                                            --Average Order Value
        `Order ID`,
        SUM(Quantity * Amount) AS order_total
    FROM sales
    GROUP BY `Order ID`
) t;




SELECT 
    CustomerName,
    SUM(Quantity * Amount) AS customer_revenue,
    ROUND(                                                  --Revenue Contribution % per Customer
        100 * SUM(Quantity * Amount) 
        / SUM(SUM(Quantity * Amount)) OVER (), 2
    ) AS revenue_percentage
FROM sales
GROUP BY CustomerName
ORDER BY customer_revenue DESC;




SELECT 
    CustomerName,
    SUM(Quantity * Amount) AS total_revenue,
    RANK() OVER (ORDER BY SUM(Quantity * Amount) DESC) AS revenue_rank
FROM sales                                                                           --Rank Customers Based on Revenue
GROUP BY CustomerName;




SELECT 
    CustomerName,
    SUM(Quantity * Amount) AS total_revenue
FROM sales
GROUP BY CustomerName
HAVING SUM(Quantity * Amount) >                                 --Customers with Revenue Greater Than Average
(
    SELECT AVG(order_total)
    FROM (
        SELECT 
            `Order ID`,
            SUM(Quantity * Amount) AS order_total
        FROM sales
        GROUP BY `Order ID`
    ) x
);



