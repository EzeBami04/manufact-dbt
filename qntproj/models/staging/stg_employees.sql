with employees as (
    select *
    from {{ source('raw', 'employees') }}
)

select *
from employees;