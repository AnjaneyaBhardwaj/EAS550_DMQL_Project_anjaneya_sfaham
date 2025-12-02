-- PART 1: Before indexing
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



-- Index 1: Admissions.Patient_ID (Foreign Key used in JOIN)
CREATE INDEX IF NOT EXISTS idx_admissions_patient_id 
ON Admissions(Patient_ID);

-- Index 2: Admissions.Condition_ID (Foreign Key used in JOIN)
CREATE INDEX IF NOT EXISTS idx_admissions_condition_id 
ON Admissions(Condition_ID);

-- Index 3: Patients.Age (Used in CASE WHEN and aggregations)
CREATE INDEX IF NOT EXISTS idx_patients_age 
ON Patients(Age);

-- Index 4: Composite index on Admissions (Patient_ID, Condition_ID)
CREATE INDEX IF NOT EXISTS idx_admissions_patient_condition 
ON Admissions(Patient_ID, Condition_ID);

-- Index 5: MedicalConditions.Condition_Name (Used in GROUP BY and ORDER BY)
CREATE INDEX IF NOT EXISTS idx_conditions_name 
ON MedicalConditions(Condition_Name);

-- Part 3: After indexing 
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


\echo ''
\echo 'INDEXES CREATED ON TABLES'


SELECT 
    tablename,
    indexname,
    indexdef
FROM pg_indexes
WHERE tablename IN ('admissions', 'patients', 'medicalconditions')
  AND indexname LIKE 'idx_%'
ORDER BY tablename, indexname;
