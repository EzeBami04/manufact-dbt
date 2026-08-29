with products as (
    select *
    from {{ source('staging', 'products') }}
)

select *
from products;