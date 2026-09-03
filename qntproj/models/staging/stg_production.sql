{{config(materialized='view')}}
with production as (
    select try_convert(production_id, varchar(50)) as production_id,
        try_convert(production_date, Date) as production_date,
        try_convert(product_id, varchar(10)) as product_id, 
        try_convert(batch_id, varchar(5)) as batch_id, 
        try_convert(machine_id, varchar(45)) as machine_id,
        try_convert(operator_id, VARCHAR(9)) as operator_id,
        cast(planned_qty as int) planned_qty,
        cast(qty_produced as bigint) as qty_produced, 
        cast(good_quantity as bigint) as good_qty,
        cast(defective_qty as int) as defective_qty,
        round(cast(downtime_minutes as decimal(2)), 2) as downtime_min,
        round(cast(production_time_minutes as decimal(2)), 2) as production_time_min,
        round(cast(material_cost as decimal(2)), 2) as material_cost, 
       round(cast(labor_cost as decimal(2)), 2) as labor_cost,
        round(cast(energy_cast as decimal(2)), 2) as energy_cost
    from {{ source('staging', 'production') }}
    WHERE production_date BETWEEN '2025-01-01' AND '2026-08-31'
    )
select *
from production;