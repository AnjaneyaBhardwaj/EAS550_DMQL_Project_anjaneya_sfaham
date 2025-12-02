-- Business Question: Which medical conditions generate the highest average billing revenue,
-- and how does this vary across different insurance providers?

-- Query 1: Overall average billing by medical condition
SELECT 
    mc.Condition_Name,
    ROUND(AVG(a.Billing_Amount), 2) AS Avg_Billing,
    COUNT(*) AS Admission_Count
FROM Admissions a
JOIN MedicalConditions mc ON a.Condition_ID = mc.Condition_ID
GROUP BY mc.Condition_Name
ORDER BY Avg_Billing DESC;

-- Query 2: Average billing by condition AND insurance provider with RANK
SELECT 
    Condition_Name,
    Insurance_Provider,
    Avg_Billing,
    Admission_Count,
    RANK() OVER (PARTITION BY Condition_Name ORDER BY Avg_Billing DESC) AS Insurance_Rank
FROM (
    SELECT 
        mc.Condition_Name,
        COALESCE(ip.Name, 'Uninsured') AS Insurance_Provider,
        ROUND(AVG(a.Billing_Amount), 2) AS Avg_Billing,
        COUNT(*) AS Admission_Count
    FROM Admissions a
    JOIN MedicalConditions mc ON a.Condition_ID = mc.Condition_ID
    LEFT JOIN InsuranceProviders ip ON a.Insurance_ID = ip.Insurance_ID
    GROUP BY mc.Condition_Name, ip.Name
) AS condition_insurance_stats
ORDER BY Condition_Name, Insurance_Rank;
