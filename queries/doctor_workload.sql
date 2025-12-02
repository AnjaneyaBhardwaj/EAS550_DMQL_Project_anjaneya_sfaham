-- Business Question: What is the unique patient count per doctor, and do doctors with 
-- the highest patient volume show higher rates of 'Elective' vs 'Emergency' admissions?

-- Top 20 doctors with highest unique patient count and their Elective vs Emergency rates
WITH doctor_data AS (
    SELECT 
        d.Doctor_ID,
        d.Name AS Doctor_Name,
        COUNT(DISTINCT a.Patient_ID) AS Unique_Patient_Count,
        COUNT(*) AS Total_Admissions,
        COUNT(*) FILTER (WHERE a.Admission_Type = 'Elective') AS Elective_Count,
        COUNT(*) FILTER (WHERE a.Admission_Type = 'Emergency') AS Emergency_Count,
        RANK() OVER (ORDER BY COUNT(DISTINCT a.Patient_ID) DESC) AS Patient_Volume_Rank
    FROM Admissions a
    JOIN Doctors d ON a.Doctor_ID = d.Doctor_ID
    GROUP BY d.Doctor_ID, d.Name
)
SELECT 
    Doctor_ID,
    Doctor_Name,
    Unique_Patient_Count,
    Total_Admissions,
    Elective_Count,
    Emergency_Count,
    ROUND(100.0 * Elective_Count / Total_Admissions, 2) AS Elective_Percentage,
    ROUND(100.0 * Emergency_Count /Total_Admissions, 2) AS Emergency_Percentage,
    Patient_Volume_Rank
FROM doctor_data
WHERE Patient_Volume_Rank <= 20
ORDER BY Patient_Volume_Rank;
