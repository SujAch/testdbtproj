
{{ 
    config(materialized='incremental' )
}}
with health AS (
 SELECT * FROM {{ ref('seed_full_moon_dates') }}
)

select * From health
