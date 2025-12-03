-- Dimension: Medical Condition
SELECT
    ROW_NUMBER() OVER (ORDER BY condition_id) AS condition_key,
    condition_id,
    condition_name,
    is_chronic
FROM "healthcare"."public"."stg_medical_conditions"