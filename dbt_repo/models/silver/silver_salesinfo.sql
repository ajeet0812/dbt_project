WITH  sales AS 
(
    SELECT
        sales_id,
        product_sk,
        customer_sk,
        gross_amount,
        {{ multiply('unit_price', 'quantity') }} as net_gross_amount,
        payment_method
    FROM
        {{ ref('bronze_sales') }}
),

products AS
(
    SELECT
        product_sk,
        category
    FROM
        {{ ref('bronze_product') }}
),

customers AS
(
    SELECT
        customer_sk,
        gender
    FROM
        {{ ref('bronze_customer') }}
),

joined_data AS
(
    SELECT
        s.sales_id,
        s.gross_amount,
        s.net_gross_amount,
        s.payment_method,
        p.category,
    c.gender
FROM
    sales s
JOIN
    products p
ON
    s.product_sk = p.product_sk
JOIN
    customers c
ON
    s.customer_sk = c.customer_sk   
)

SELECT
    category,
    gender,
    SUM(gross_amount) AS total_gross_amount,
    SUM(net_gross_amount) AS total_net_gross_amount,
    COUNT(sales_id) AS total_sales
FROM
    joined_data
GROUP BY
    category,
    gender
ORDER BY
    total_gross_amount DESC


