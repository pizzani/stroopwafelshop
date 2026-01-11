with raw_source as (
    select * from {{source("stroopwafelshop","promotions")}}
),

promotions as (
    select 

    -- ids
    id as promotion_id,
    product_id,

    -- strings
    name as promotion_name,
    description,

    -- numerics
    cast(discount_rate as numeric) discount_rate,

    -- dates
    parse_date('%Y-%m-%d', start_date) promotion_start_date,
    parse_date('%Y-%m-%d', end_date) promotion_end_date,

    -- boolean
    case
        when is_holiday = 'FALSE' then FALSE
        when is_holiday = 'TRUE' then TRUE
    end as is_holiday,

    -- meta
    _airbyte_extracted_at,
    _airbyte_meta,
    _airbyte_raw_id

    from raw_source
)

select * from promotions