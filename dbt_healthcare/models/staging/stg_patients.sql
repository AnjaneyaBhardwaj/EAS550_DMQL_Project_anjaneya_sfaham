-- Staging: Patients
SELECT
    patient_id,
    name AS patient_name,
    age,
    gender,
    blood_type,
    CASE 
        WHEN age BETWEEN 0 AND 18 THEN 'Pediatric'
        WHEN age BETWEEN 19 AND 40 THEN 'Young Adult'
        WHEN age BETWEEN 41 AND 60 THEN 'Middle Age'
        ELSE 'Senior'
    END AS age_group
FROM {{ source('healthcare_oltp', 'patients') }}
