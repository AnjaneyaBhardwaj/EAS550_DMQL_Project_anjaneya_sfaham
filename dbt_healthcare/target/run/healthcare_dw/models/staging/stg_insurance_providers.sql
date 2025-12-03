
  create view "healthcare"."public"."stg_insurance_providers__dbt_tmp"
    
    
  as (
    -- Staging: Insurance Providers
SELECT
    insurance_id,
    name AS provider_name
FROM "healthcare"."public"."insuranceproviders"
  );