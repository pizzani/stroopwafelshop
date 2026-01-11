with stg_products as (select * from {{ref("stg_products")}}),
dim_products as (
    select * except (_airbyte_extracted_at, _airbyte_meta, _airbyte_raw_id)
    from stg_products
)
select * from dim_products