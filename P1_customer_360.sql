WITH
conv AS (
    SELECT cd.customer_id,
           cd.sk_customer,
           cd.first_name,
           cd.last_name,
           co.conversion_type,
           ROW_NUMBER() OVER (PARTITION BY cd.customer_id ORDER BY co.conversion_date) as recurrence,
           co.conversion_date,
           LEAD(co.conversion_date) OVER (PARTITION BY cd.customer_id ORDER BY co.conversion_date) as next_conversion_date,
           co.order_number as first_order_number,
           co.conversion_channel
    FROM fact_tables.conversions AS co
    INNER JOIN dimensions.customer_dimension AS cd ON co.fk_customer = cd.sk_customer
),
orders AS (
    SELECT cd.customer_id,
           ot.order_date,
           LEAD(ot.order_date) OVER (PARTITION BY cd.customer_id ORDER BY ot.order_date) as next_order_date,
           ot.order_number as first_order_number,
           pd.product_name,
           ot.price_paid,
           ot.order_id,
           ot.discount
    FROM fact_tables.orders AS ot
    INNER JOIN dimensions.customer_dimension AS cd ON ot.fk_customer = cd.sk_customer
    INNER JOIN dimensions.product_dimension  AS pd ON ot.fk_product = pd.sk_product
),
conv_with_orders AS (
    SELECT cs.*,
           o.order_date as first_order_date,
           o.product_name as first_product_name,
           o.price_paid as first_order_price,
           o.order_id,
           o.discount as first_order_discount
    FROM conv AS cs
    LEFT JOIN orders AS o ON cs.first_order_number = o.first_order_number
),
conv_with_dates AS (
    SELECT cs.*,
           dd.year_week as conversion_week
    FROM conv_with_orders AS cs
    LEFT JOIN dimensions.date_dimension AS dd ON cs.first_order_date = dd.date
),
next_conv AS (
    SELECT cs.*,
           dd.year_week as next_conversion_week
    FROM conv_with_dates AS cs
    LEFT JOIN dimensions.date_dimension AS dd ON cs.next_conversion_date = dd.date
),
weeks AS (
    SELECT DISTINCT year_week as delivery_week
    FROM dimensions.date_dimension
),
delivery_weeks AS (
    SELECT *
    FROM next_conv AS nc
    LEFT JOIN weeks ON (weeks.delivery_week >= nc.conversion_week AND weeks.delivery_week < nc.next_conversion_week) OR
    (weeks.delivery_week >= nc.conversion_week AND nc.next_conversion_week IS NULL)
    ORDER BY customer_id DESC, conversion_date, delivery_week ASC
),
ord AS (
    SELECT os.order_id,
           os.order_number,
           os.order_date,
           dd.year_week as order_week,
           os.fk_customer,
           pd.product_name,
           os.order_item_id,
           os.unit_price,
           os.discount,
           os.price_paid
    FROM fact_tables.orders AS os
    JOIN dimensions.product_dimension AS pd ON pd.sk_product = os.fk_product
    JOIN dimensions.date_dimension AS dd ON dd.date = os.order_date
    ORDER BY order_date
),
ord_upd AS (
    SELECT *
    FROM delivery_weeks
    LEFT JOIN ord ON delivery_weeks.sk_customer = ord.fk_customer AND
    delivery_weeks.delivery_week = ord.order_week AND
    ((delivery_weeks.delivery_week >= delivery_weeks.conversion_week AND delivery_weeks.delivery_week < delivery_weeks.next_conversion_week) OR
    (delivery_weeks.delivery_week >= delivery_weeks.conversion_week AND delivery_weeks.next_conversion_week IS NULL))
),
rev_upd AS (
    SELECT *,
           CASE WHEN price_paid IS NULL THEN 0 ELSE price_paid END as revenue,
           CASE WHEN order_date IS NULL THEN 0 ELSE 1 END as has_ordered
    FROM ord_upd
)
SELECT *,
       SUM(revenue) OVER (PARTITION BY customer_id, order_week ORDER BY delivery_week) as week_revenue,
       SUM(discount) OVER (PARTITION BY customer_id, order_week ORDER BY delivery_week) as week_discounts,
       SUM(revenue) OVER (PARTITION BY customer_id ORDER BY delivery_week) as cumulative_revenue,
       SUM(revenue) OVER (ORDER BY delivery_week) as cumulative_revenue_lifetime,
       SUM(has_ordered) OVER (PARTITION BY customer_id ORDER BY delivery_week) as loyalty,
       SUM(has_ordered) OVER (ORDER BY delivery_week) AS cum_loyalty_lifetime
FROM rev_upd
ORDER BY customer_id, delivery_week, revenue;




-- Conversion information  for each customer with the corresponding first order information
WITH c1 AS (
-- Create a conversion table that shows the conversion week and next conversion week for each customer
SELECT cs.conversion_id,
       cs.conversion_date,
       dd.year_week AS conversion_week,
       cd.sk_customer,
       cd.customer_id,
       cd.first_name,
       cd.last_name,
       cs.conversion_type,
       Row_number() OVER(
           PARTITION BY cs.fk_customer
           ORDER BY cs.conversion_date
           ) AS recurrence,
       LEAD(dd.year_week) OVER(
           PARTITION BY cd.customer_id
           ORDER BY dd.year_week
           ) AS next_conversion_week,
       LEAD(cs.conversion_date) OVER(
           PARTITION BY cd.customer_id
           ORDER BY cs.conversion_date
           ) AS next_conversion_date,
      cs.order_number as first_order_ID,
      cs.conversion_channel
FROM dimensions.customer_dimension AS cd
INNER JOIN fact_tables.conversions AS cs
    ON cd.sk_customer = cs.fk_customer
INNER JOIN dimensions.date_dimension AS dd
    ON dd.sk_date = cs.fk_conversion_date),

c2 AS (
-- Create a table that contains all of the order records for each customer
SELECT cd.customer_id,
       row_number() over (
           PARTITION BY cd.customer_id
           ORDER BY os.order_date
           ) as recurrence,
       os.order_date,
       LEAD(os.order_date, 1) OVER (
           PARTITION BY cd.customer_id
           ORDER BY os.order_date
           ) as next_order_date,
       os.order_number as first_order_ID,
       os.order_id,
       pd.product_name,
       os.fk_product,
       os.discount,
       os.price_paid
FROM dimensions.customer_dimension AS cd
INNER JOIN fact_tables.orders AS os
    ON os.fk_customer = cd.sk_customer
INNER JOIN dimensions.product_dimension  AS pd
    ON os.fk_product = pd.sk_product)

SELECT c1.*,
       c2.order_date as first_order_date,
       c1.conversion_week AS first_order_week,
       c1.first_order_ID,
       c2.product_name as first_order_product,
       c2.price_paid as first_order_total_paid,
       c2.discount as first_order_discount
FROM c1
LEFT JOIN c2
  ON c1.first_order_ID = c2.first_order_ID
LEFT JOIN dimensions.product_dimension AS pd
    ON c2.fk_product = pd.sk_product
ORDER BY c1.customer_id, c1.conversion_date;












