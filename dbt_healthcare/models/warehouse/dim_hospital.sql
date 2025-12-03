-- Dimension: Hospital
SELECT
    ROW_NUMBER() OVER (ORDER BY hospital_id) AS hospital_key,
    hospital_id,
    hospital_name
FROM {{ ref('stg_hospitals') }}
