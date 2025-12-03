
  create view "healthcare"."public"."stg_admissions__dbt_tmp"
    
    
  as (
    -- Staging: Admissions
SELECT
    admission_id,
    patient_id,
    doctor_id,
    hospital_id,
    insurance_id,
    condition_id,
    medication_id,
    date_of_admission,
    discharge_date,
    admission_type,
    billing_amount,
    room_number,
    test_results,
    (discharge_date - date_of_admission) AS length_of_stay
FROM "healthcare"."public"."admissions"
  );