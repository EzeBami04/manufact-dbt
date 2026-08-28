with quality_check as (
    select *
    from {{ source('raw', 'quality_checks') }}
)

select *
from quality_check;