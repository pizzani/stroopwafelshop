with
    raw_source as (select * from {{ source("stroopwafelshop", "shifts") }}),

    shifts as (

        select
            -- ids
            {{dbt_utils.generate_surrogate_key([
                "date",
                "employee_id",
                "role",
                "hours"
            ])}} as shift_id,

            employee_id,

            -- strings
            role,

            -- numerics


            -- dates
            parse_date('%Y-%m-%d', date) as shift_date,

            -- timestamps
            parse_timestamp('%Y-%m-%d %H:%M',concat(date||' '||split(hours,'-')[offset(0)])) as shift_start_at,
            parse_timestamp('%Y-%m-%d %H:%M',concat(date||' '||split(hours,'-')[offset(1)])) as shift_end_at,

            -- meta
            _airbyte_extracted_at,
            _airbyte_meta,
            _airbyte_raw_id,

        from raw_source
    )

select 
s.*,
extract(hour from (shift_end_at - shift_start_at)) as shift_duration_hours
from shifts s