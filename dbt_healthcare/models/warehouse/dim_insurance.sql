-- Dimension: Insurance
SELECT
    ROW_NUMBER() OVER (ORDER BY insurance_id) AS insurance_key,
    insurance_id,
    provider_name
FROM {{ ref('stg_insurance_providers') }}
