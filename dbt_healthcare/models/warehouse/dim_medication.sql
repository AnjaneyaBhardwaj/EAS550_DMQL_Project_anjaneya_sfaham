SELECT
    ROW_NUMBER() OVER (ORDER BY medication_id) AS medication_key,
    medication_id,
    medication_name
FROM {{ ref('stg_medications') }}
