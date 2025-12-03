-- Staging: Insurance Providers
SELECT
    insurance_id,
    name AS provider_name
FROM {{ source('healthcare_oltp', 'insuranceproviders') }}
