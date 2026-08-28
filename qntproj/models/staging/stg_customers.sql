with customers as (
    select *
    from {{ source('raw', 'customers') }}
)

select *
from customers;