
  create view "healthcare"."public"."dim_insurance__dbt_tmp"
    
    
  as (
    -- Dimension: Insurance
SELECT
    ROW_NUMBER() OVER (ORDER BY insurance_id) AS insurance_key,
    insurance_id,
    provider_name
FROM "healthcare"."public"."stg_insurance_providers"
  );