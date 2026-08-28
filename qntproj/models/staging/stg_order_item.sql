with order_item as (
    select *
    from {{ source('raw', 'order_items') }}
)

select *
from order_item;