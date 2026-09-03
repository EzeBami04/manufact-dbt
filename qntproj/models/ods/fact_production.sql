{{
    config(
        materialized='incremental',
        unique_key='production_id',
        partition_by={
            "field": "production_date",
            "data_type": "date"
        },
        incremental_strategy='merge'
    )
}}

select
    production_id,
    product_id,
    batch_id,
    production_date,
    machine_id,
    operator_id,
    planned_qty,
    qty_produced,
    good_qty,
    defective_qty,
    downtime_min,
    production_time_min,
    material_cost,
    labor_cost,
    energy_cost
from {{ ref('stg_production') }}

{% if is_incremental() %}
where production_date > (select max(production_date) from {{ this }})
{% endif %}