{{
    config (
        materialized = 'table'
    )
}}

WITH session_src AS
(
    SELECT
        SESSION_ID,
        USER_ID,
        BROWSER,
        DEVICE_TYPE,
        b.country_name AS country_name,
        b.continent AS continent,
        b.currency AS currency,
        START_TIME,
        END_TIME,
        PAGES_VISITED,
        CURRENT_TIMESTAMP as INSERT_DTS
    FROM {{source('session','SESSION_SRC')}} a
    LEFT JOIN {{ref('country_code')}} b
    ON a.COUNTRY_CODE = b.COUNTRY_CODE
)
SELECT * FROM session_src
