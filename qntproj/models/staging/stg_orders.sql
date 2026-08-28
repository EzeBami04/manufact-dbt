with orders as (
    select *
    from {{ source('raw', 'orders') }}
)

select *
from orders;