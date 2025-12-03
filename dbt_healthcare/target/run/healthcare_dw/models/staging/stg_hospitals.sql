
  create view "healthcare"."public"."stg_hospitals__dbt_tmp"
    
    
  as (
    -- Staging: Hospitals
SELECT
    hospital_id,
    name AS hospital_name
FROM "healthcare"."public"."hospitals"
  );