with inventory as (
    select *
    from {{ source('raw', 'inventory') }}
)

select *
from inventory;