with products as (
    select *
    from {{ source('raw', 'products') }}
)

select *
from products;