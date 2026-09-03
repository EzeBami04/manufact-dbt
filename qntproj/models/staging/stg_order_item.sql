{{config(materialized='view')}}
with order_item as (
    select *
    from {{ source('staging', 'order_items') }}
)

select *
from order_item;