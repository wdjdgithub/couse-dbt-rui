# Week one project

1. How many users do we have?

SELECT
COUNT(user_id) as ct 
FROM users;

Answer:
130

2. On average, how many orders do we receive per hour?

WITH orders_by_hour AS (
SELECT 
DATE_TRUNC('hour', created_at) AS created_at_hour
,COUNT(DISTINCT order_id) AS  orders_ct
 FROM orders
 GROUP BY 1
)
SELECT ROUND(AVG(orders_ct), 2) as avg_order
FROM orders_by_hour;

Answer:
8.16

3. On average, how long does an order take from being placed to being delivered?

WITH days_by_order AS (
SELECT 
order_id, 
created_at,
delivered_at,
extract(days from delivered_at - created_at) as days_diff
FROM orders
WHERE status = 'delivered'
)
SELECT AVG(days_diff) FROM days_by_order;

Answer:
3.9258160237388724

4. How many users have only made one purchase? Two purchases? Three+ purchases?

WITH purchases_by_user AS (
SELECT 
user_id
,COUNT(DISTINCT order_id) AS purchases_ct
FROM orders
GROUP BY 1
)
SELECT 
purchases_ct
,COUNT(user_id) AS users_ct
FROM purchases_by_user
 GROUP BY 1 
 ORDER BY 1;

Answer:
purchases_ct | users_ct 
--------------+----------
            1 |       25
            2 |       22
            3 |       32
            4 |       25
            5 |       15
            6 |        4
            7 |        4
            8 |        1

5. On average, how many unique sessions do we have per hour?

WITH sessions_by_hour AS (
SELECT 
DATE_TRUNC('hour', created_at) AS created_at_hour,
COUNT(DISTINCT session_id) AS sessions_ct
FROM events
GROUP BY 1
)
SELECT ROUND(AVG(sessions_ct),2)
FROM sessions_by_hour;

Answer:
7.39
