with material_usage as (
    select *
    from {{ source('staging', 'material_usage') }}
)

select *
from material_usage;