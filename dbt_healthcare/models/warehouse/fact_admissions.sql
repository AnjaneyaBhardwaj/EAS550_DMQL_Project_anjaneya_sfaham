-- Fact Table: Admissions
-- Grain: One row per hospital admission

SELECT
    ROW_NUMBER() OVER (ORDER BY a.admission_id) AS admission_key,
    
    -- Foreign keys to dimensions
    p.patient_key,
    d.doctor_key,
    h.hospital_key,
    i.insurance_key,
    c.condition_key,
    m.medication_key,
    
    -- Degenerate dimensions (no separate table needed)
    a.admission_type,
    a.room_number,
    a.test_results,
    
    -- Measures
    a.billing_amount,
    a.length_of_stay,
    
    -- Dates for reference
    a.date_of_admission,
    a.discharge_date

FROM {{ ref('stg_admissions') }} a
LEFT JOIN {{ ref('dim_patient') }} p ON a.patient_id = p.patient_id
LEFT JOIN {{ ref('dim_doctor') }} d ON a.doctor_id = d.doctor_id
LEFT JOIN {{ ref('dim_hospital') }} h ON a.hospital_id = h.hospital_id
LEFT JOIN {{ ref('dim_insurance') }} i ON a.insurance_id = i.insurance_id
LEFT JOIN {{ ref('dim_condition') }} c ON a.condition_id = c.condition_id
LEFT JOIN {{ ref('dim_medication') }} m ON a.medication_id = m.medication_id
