\echo 'Before indexing'
EXPLAIN ANALYZE
SELECT 
    mc.Condition_Name,
    CASE 
        WHEN p.Age BETWEEN 0 AND 18 THEN '0-18 (Pediatric)'
        WHEN p.Age BETWEEN 19 AND 40 THEN '19-40 (Young Adult)'
        WHEN p.Age BETWEEN 41 AND 60 THEN '41-60 (Middle Age)'
        ELSE '61+ (Senior)'
    END AS Age_Group,
    COUNT(*) AS Patient_Count,
    ROUND(AVG(p.Age), 1) AS Avg_Age,
    MIN(p.Age) AS Min_Age,
    MAX(p.Age) AS Max_Age,
    RANK() OVER (PARTITION BY mc.Condition_Name ORDER BY COUNT(*) DESC) AS Age_Group_Rank
FROM Admissions a
JOIN Patients p ON a.Patient_ID = p.Patient_ID
JOIN MedicalConditions mc ON a.Condition_ID = mc.Condition_ID
GROUP BY mc.Condition_Name, 
    CASE 
        WHEN p.Age BETWEEN 0 AND 18 THEN '0-18 (Pediatric)'
        WHEN p.Age BETWEEN 19 AND 40 THEN '19-40 (Young Adult)'
        WHEN p.Age BETWEEN 41 AND 60 THEN '41-60 (Middle Age)'
        ELSE '61+ (Senior)'
    END
ORDER BY mc.Condition_Name, Age_Group_Rank;



CREATE INDEX IF NOT EXISTS idx_admissions_patient_id 
ON Admissions(Patient_ID);

CREATE INDEX IF NOT EXISTS idx_admissions_condition_id 
ON Admissions(Condition_ID);

CREATE INDEX IF NOT EXISTS idx_patients_age 
ON Patients(Age);

CREATE INDEX IF NOT EXISTS idx_admissions_patient_condition 
ON Admissions(Patient_ID, Condition_ID);


CREATE INDEX IF NOT EXISTS idx_conditions_name 
ON MedicalConditions(Condition_Name);

\echo ''
\echo 'After indexing'

ANALYZE Admissions;
ANALYZE Patients;
ANALYZE MedicalConditions;

EXPLAIN ANALYZE
SELECT 
    mc.Condition_Name,
    CASE 
        WHEN p.Age BETWEEN 0 AND 18 THEN '0-18 (Pediatric)'
        WHEN p.Age BETWEEN 19 AND 40 THEN '19-40 (Young Adult)'
        WHEN p.Age BETWEEN 41 AND 60 THEN '41-60 (Middle Age)'
        ELSE '61+ (Senior)'
    END AS Age_Group,
    COUNT(*) AS Patient_Count,
    ROUND(AVG(p.Age), 1) AS Avg_Age,
    MIN(p.Age) AS Min_Age,
    MAX(p.Age) AS Max_Age,
    RANK() OVER (PARTITION BY mc.Condition_Name ORDER BY COUNT(*) DESC) AS Age_Group_Rank
FROM Admissions a
JOIN Patients p ON a.Patient_ID = p.Patient_ID
JOIN MedicalConditions mc ON a.Condition_ID = mc.Condition_ID
GROUP BY mc.Condition_Name, 
    CASE 
        WHEN p.Age BETWEEN 0 AND 18 THEN '0-18 (Pediatric)'
        WHEN p.Age BETWEEN 19 AND 40 THEN '19-40 (Young Adult)'
        WHEN p.Age BETWEEN 41 AND 60 THEN '41-60 (Middle Age)'
        ELSE '61+ (Senior)'
    END
ORDER BY mc.Condition_Name, Age_Group_Rank;

