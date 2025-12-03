-- Staging: Hospitals
SELECT
    hospital_id,
    name AS hospital_name
FROM {{ source('healthcare_oltp', 'hospitals') }}
