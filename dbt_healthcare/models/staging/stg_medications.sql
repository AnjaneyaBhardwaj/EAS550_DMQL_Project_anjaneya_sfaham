SELECT
    medication_id,
    medication_name
FROM {{ source('healthcare_oltp', 'medications') }}
