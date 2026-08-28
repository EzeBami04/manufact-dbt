with maintenance as (
    select *
    from {{ source('raw', 'maintenance') }}
)

select *
from maintenance;