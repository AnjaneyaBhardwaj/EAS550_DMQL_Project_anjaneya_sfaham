SELECT
    ROW_NUMBER() OVER (ORDER BY condition_id) AS condition_key,
    condition_id,
    condition_name,
    is_chronic
FROM {{ ref('stg_medical_conditions') }}
