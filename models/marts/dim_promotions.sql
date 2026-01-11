with stg_promotions as (select * from {{ref("stg_promotions")}}),
dim_promotions as (
    select * except (_airbyte_extracted_at, _airbyte_meta, _airbyte_raw_id)
    from stg_promotions
)
select *
from dim_promotions