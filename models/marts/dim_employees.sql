with
    stg_employees as (select * from {{ ref("stg_employees") }}),
    dim_employees as (
        select * except (_airbyte_extracted_at, _airbyte_meta, _airbyte_raw_id)

        from stg_employees
    )

select *
from dim_employees