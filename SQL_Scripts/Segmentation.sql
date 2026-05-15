-- Define risk categories to check churn distribution
WITH Risk_Table AS (
    SELECT 
        customerID,
        tenure,
        Contract,
        PaymentMethod,
        MonthlyCharges,
        Churn,
        CASE 
            WHEN tenure <= 12 
                 AND Contract = 'Month-to-month' 
                 AND PaymentMethod = 'Electronic check' THEN 'High Risk'
                 
            WHEN tenure <= 12 
                 AND Contract = 'Month-to-month' THEN 'Medium Risk'
                 
            ELSE 'Low Risk'
        END AS Risk_Category
    FROM Churn_data
)

-- Check churn distribution across the risk categories we just created
SELECT 
    Risk_Category,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Actual_Churned,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
    2) AS Actual_Churn_Percentage
FROM Risk_Table
GROUP BY Risk_Category
ORDER BY Actual_Churn_Percentage DESC