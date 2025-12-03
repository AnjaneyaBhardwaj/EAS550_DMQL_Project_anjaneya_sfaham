
  create view "healthcare"."public"."stg_doctors__dbt_tmp"
    
    
  as (
    -- Staging: Doctors
SELECT
    doctor_id,
    name AS doctor_name
FROM "healthcare"."public"."doctors"
  );