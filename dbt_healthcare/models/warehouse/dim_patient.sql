-- Dimension: Patient
SELECT
    ROW_NUMBER() OVER (ORDER BY patient_id) AS patient_key,
    patient_id,
    patient_name,
    age,
    age_group,
    gender,
    blood_type
FROM {{ ref('stg_patients') }}
