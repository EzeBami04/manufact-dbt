with production as (
    select *
    from {{ source('staging', 'production') }}
)

select *
from production;