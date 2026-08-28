with material_usage as (
    select *
    from {{ source('raw', 'material_usage') }}
)

select *
from material_usage;