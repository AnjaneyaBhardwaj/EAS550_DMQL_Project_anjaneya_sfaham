-- Dimension: Doctor
SELECT
    ROW_NUMBER() OVER (ORDER BY doctor_id) AS doctor_key,
    doctor_id,
    doctor_name
FROM "healthcare"."public"."stg_doctors"