-- Staging: Doctors
SELECT
    doctor_id,
    name AS doctor_name
FROM {{ source('healthcare_oltp', 'doctors') }}
