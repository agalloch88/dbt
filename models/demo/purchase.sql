{{
    config (
        materialized = 'incremental',
        incremental_strategy = 'merge',
        unique_key = 'PURCHASE_ID',
        merge_exclude_columns = ['INSERT_DTS']
    )
}}

WITH purchase_src AS (
    SELECT
        PURCHASE_ID, 
        PURCHASE_DATE, 
        PURCHASE_STATUS, 
        CREATED_AT,
        CURRENT_TIMESTAMP AS INSERT_DTS,
        CURRENT_TIMESTAMP AS UPDATE_DTS
    FROM {{ source('purchase', 'PURCHASE_SRC') }}

    {% if is_incremental() %}
    WHERE CREATED_AT > (SELECT MAX(UPDATE_DTS) FROM {{this}})
    {% endif %}
)

SELECT * FROM purchase_src