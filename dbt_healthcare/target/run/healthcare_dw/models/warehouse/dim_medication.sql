
  create view "healthcare"."public"."dim_medication__dbt_tmp"
    
    
  as (
    -- Dimension: Medication
SELECT
    ROW_NUMBER() OVER (ORDER BY medication_id) AS medication_key,
    medication_id,
    medication_name
FROM "healthcare"."public"."stg_medications"
  );