WITH date_range AS (
    SELECT 
        generate_series(
            (SELECT MIN(date_of_admission) FROM {{ source('healthcare_oltp', 'admissions') }}),
            (SELECT MAX(discharge_date) FROM {{ source('healthcare_oltp', 'admissions') }}),
            '1 day'::interval
        )::date AS full_date
)

SELECT
    TO_CHAR(full_date, 'YYYYMMDD')::INTEGER AS date_key,
    full_date,
    TO_CHAR(full_date, 'Day') AS day_name,
    EXTRACT(MONTH FROM full_date)::INTEGER AS month,
    TO_CHAR(full_date, 'Month') AS month_name,
    EXTRACT(YEAR FROM full_date)::INTEGER AS year,
    CASE 
        WHEN EXTRACT(MONTH FROM full_date) IN (3, 4, 5) THEN 'Spring'
        WHEN EXTRACT(MONTH FROM full_date) IN (6, 7, 8) THEN 'Summer'
        WHEN EXTRACT(MONTH FROM full_date) IN (9, 10, 11) THEN 'Fall'
        ELSE 'Winter'
    END AS season
FROM date_range
