/*
================ Loading fact_production using the Upsert logic =========================
*/
{{config(materialized='table', 
    PARTITION BY={ "field": "production_date", "data_type": "date"})}}
with src as(
    select *
    from {{ref('stg_production')}}
    -- WHERE production_date BETWEEN '2025-01-01' AND '2026-08-31'
    -- {{% if is_incremental() %}}
    ),
    tgt as(
        SELECT *
        from {{ref( 'fact_production')}}
    ),
MERGE INTO tgt
 USING(
    select *
    from src
    ) as src
    ON tgt.production_id = src.production_id
    WHEN MATCHED THEN
        UPDATE SET
        tgt.production_id = src.production_id,
        tgt.product_id = src.product_id,
        tgt.batch_id = src.
        tgt.production_date = src.production_date
        tgt.machine_id = src.machine_id
        tgt.operator_id = src.operator_id,
        tgt.planned_qty = src.planned_qty,
        tgt.qty_produced = src.qty_produced,
        tgt.good_qty = src.good_qty,
        tgt.defective_qty = src.defective_qty,
        tgt.downtime_min = src.downtime_min,
        tgt.production_time_min = src.production_time_min,
        tgt.material_cost = src.material_cost,
        tgt.labor_cost = src.labor_cost,
        tgt.energy_cost = src.energy_cost
    WHEN NOT MATCHED THEN
        INSERT(
            production_id, product_id, batch_id, production_date, machine_id, operator_id, planned_qty, qty_produced,
            good_qty, defective_qty, downtime_min, production_time_min, material_cost, labor_cost,
            energy_cost
        )
        VALUES(
            tgt.production_id = src.production_id,
            tgt.product_id = src.product_id,
            tgt.batch_id = src.
            tgt.production_date = src.production_date
            tgt.machine_id = src.machine_id
            tgt.operator_id = src.operator_id,
            tgt.planned_qty = src.planned_qty,
            tgt.qty_produced = src.qty_produced,
            tgt.good_qty = src.good_qty,
            tgt.defective_qty = src.defective_qty,
            tgt.downtime_min = src.downtime_min,
            tgt.production_time_min = src.production_time_min,
            tgt.material_cost = src.material_cost,
            tgt.labor_cost = src.labor_cost,
            tgt.energy_cost = src.energy_cost
        )  