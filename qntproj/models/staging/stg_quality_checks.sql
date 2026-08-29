with quality_check as (
    select *
    from {{ source('staging', 'quality_checks') }}
)

select *
from quality_check;