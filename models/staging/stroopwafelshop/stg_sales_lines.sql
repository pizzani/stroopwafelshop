with
    raw_source as (select * from {{ source("stroopwafelshop", "sales_lines") }}),

    sales_lines as (

        select
            -- ids
            id as sales_line_id,
            sales_id,
            product_id,
            promotion_id,

            -- dates
            parse_date('%Y-%m-%d', date) sales_line_date,

            -- numerics
            cast(unit_price as numeric) unit_price,
            cast(total_price as numeric) total_price,
            cast(discount_rate as numeric) discount_rate,
            cast(quantity_sold as numeric) quantity_sold,
            cast(unit_discount as numeric) unit_discount,
            cast(total_discount as numeric) total_discount,

            -- meta
            _airbyte_extracted_at,
            _airbyte_meta,
            _airbyte_raw_id,

        from raw_source
    )

select *
from sales_lines