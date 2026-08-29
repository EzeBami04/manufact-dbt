with orders as (
    select *
    from {{ source('staging', 'orders') }}
)

select *
from orders;