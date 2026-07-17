{{
    config (
        materialized = 'ephemeral'
    )
}}

WITH base_orders AS (
    SELECT
        ORDER_ID,
        ORDER_DATE,
        CUSTOMER_ID,
        CASE 
            WHEN CUSTOMER_NAME IS NULL THEN 'NA' 
            ELSE upper(CUSTOMER_NAME) 
        END AS CUSTOMER_NAME,
        CREATED_AT
    FROM {{source('orders','BASE_ORDERS')}}
    WHERE ORDER_DATE IS NOT NULL
)
SELECT * FROM BASE_ORDERS