-- Staging: Medical Conditions
SELECT
    condition_id,
    condition_name,
    CASE 
        WHEN LOWER(condition_name) IN ('diabetes', 'hypertension', 'arthritis', 'asthma') THEN TRUE
        ELSE FALSE
    END AS is_chronic
FROM "healthcare"."public"."medicalconditions"