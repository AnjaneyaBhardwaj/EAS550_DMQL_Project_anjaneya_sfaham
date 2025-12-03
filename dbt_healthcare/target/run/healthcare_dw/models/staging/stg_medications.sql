
  create view "healthcare"."public"."stg_medications__dbt_tmp"
    
    
  as (
    -- Staging: Medications
SELECT
    medication_id,
    medication_name
FROM "healthcare"."public"."medications"
  );