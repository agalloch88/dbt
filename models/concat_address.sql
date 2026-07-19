{{
    config(
        materialized = 'table'
    )
}}

SELECT {{ concat_macro('123', 'A Street') }} AS address