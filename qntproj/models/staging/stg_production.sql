with production as (
    select *
    from {{ source('raw', 'production') }}
)

select *
from production;