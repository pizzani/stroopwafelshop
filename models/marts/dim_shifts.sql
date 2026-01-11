with stg_shifts as (select * from {{ref("stg_shifts")}}),
dim_shifts as (
    select * except (_airbyte_extracted_at, _airbyte_meta, _airbyte_raw_id)
    from stg_shifts
)
select *
from dim_shifts