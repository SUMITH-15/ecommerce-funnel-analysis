-- =========================================
-- E-COMMERCE FUNNEL ANALYSIS - SQL QUERIES
-- =========================================

-- 1. View all data
SELECT * FROM ecommerce;


-- 2. Check distinct events (for data validation)
SELECT DISTINCT event FROM ecommerce;


-- 3. Count users at each funnel stage
SELECT 
    event,
    COUNT(DISTINCT user_id) AS users
FROM ecommerce
GROUP BY event;


-- 4. Full funnel count (Visit → Purchase)
SELECT 
  COUNT(DISTINCT CASE WHEN event='visit' THEN user_id END) AS visit,
  COUNT(DISTINCT CASE WHEN event='add_to_cart' THEN user_id END) AS add_to_cart,
  COUNT(DISTINCT CASE WHEN event='checkout' THEN user_id END) AS checkout,
  COUNT(DISTINCT CASE WHEN event='purchase' THEN user_id END) AS purchase
FROM ecommerce;


-- 5. Conversion Rate Calculation
SELECT 
  ROUND( 
    COUNT(DISTINCT CASE WHEN event='add_to_cart' THEN user_id END) * 100.0 /
    NULLIF(COUNT(DISTINCT CASE WHEN event='visit' THEN user_id END), 0)
  ,2) AS visit_to_cart,

  ROUND( 
    COUNT(DISTINCT CASE WHEN event='checkout' THEN user_id END) * 100.0 /
    NULLIF(COUNT(DISTINCT CASE WHEN event='add_to_cart' THEN user_id END), 0)
  ,2) AS cart_to_checkout,

  ROUND( 
    COUNT(DISTINCT CASE WHEN event='purchase' THEN user_id END) * 100.0 /
    NULLIF(COUNT(DISTINCT CASE WHEN event='checkout' THEN user_id END), 0)
  ,2) AS checkout_to_purchase

FROM ecommerce;


-- 6. Total Revenue
SELECT 
    SUM(price) AS total_revenue
FROM ecommerce
WHERE event = 'purchase';


-- 7. Average Order Value (AOV)
SELECT 
    AVG(price) AS avg_order_value
FROM ecommerce
WHERE event = 'purchase';
