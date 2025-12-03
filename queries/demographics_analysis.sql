-- Business Question: Is there a correlation between patient demographics 
-- (Age, Gender, Blood Type) and the prevalence of specific medical conditions?

-- Query 1: Age distribution by medical condition
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


-- Query 2: Gender distribution by medical condition
SELECT 
    Condition_Name,
    Gender,
    Patient_Count,
    ROUND(100.0 * Patient_Count / SUM(Patient_Count) OVER (PARTITION BY Condition_Name), 2) AS Percentage,
    RANK() OVER (PARTITION BY Condition_Name ORDER BY Patient_Count DESC) AS Gender_Rank
FROM (
    SELECT 
        mc.Condition_Name,
        p.Gender,
        COUNT(*) AS Patient_Count
    FROM Admissions a
    JOIN Patients p ON a.Patient_ID = p.Patient_ID
    JOIN MedicalConditions mc ON a.Condition_ID = mc.Condition_ID
    WHERE p.Gender IS NOT NULL
    GROUP BY mc.Condition_Name, p.Gender
) AS gender_stats
ORDER BY Condition_Name, Gender_Rank;


-- Query 3: Combined demographics
SELECT 
    mc.Condition_Name,
    COUNT(DISTINCT a.Patient_ID) AS Total_Patients,
    ROUND(AVG(p.Age), 1) AS Avg_Age,
    MODE() WITHIN GROUP (ORDER BY p.Gender) AS Most_Common_Gender
FROM Admissions a
JOIN Patients p ON a.Patient_ID = p.Patient_ID
JOIN MedicalConditions mc ON a.Condition_ID = mc.Condition_ID
GROUP BY mc.Condition_Name
ORDER BY Total_Patients DESC;
