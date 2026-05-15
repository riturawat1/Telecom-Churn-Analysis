SELECT 
    CAST(
        ROUND(
            SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
        2) 
    AS DECIMAL(5,2)) AS Churn_Rate_Percentage
FROM Churn_data


SELECT 
    Contract,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    CAST(
        ROUND(
            SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
        2) 
    AS DECIMAL(5,2)) AS Churn_Rate
FROM Churn_data
GROUP BY Contract
ORDER BY Churn_Rate DESC


-- Churn Analysis Based on Tenure Groups
SELECT 
    CASE 
        WHEN tenure <= 12 THEN 'New Customers (0-1 Yr)'
        WHEN tenure <= 36 THEN 'Mid-Term Customers (1-3 Yr)'
        ELSE 'Long-Term Customers (3+ Yr)'
    END AS Tenure_Category,
    
    COUNT(customerID) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(customerID), 
    2) AS Churn_Percentage
FROM Churn_data
GROUP BY 
    CASE 
        WHEN tenure <= 12 THEN 'New Customers (0-1 Yr)'
        WHEN tenure <= 36 THEN 'Mid-Term Customers (1-3 Yr)'
        ELSE 'Long-Term Customers (3+ Yr)'
    END
ORDER BY Churn_Percentage DESC


-- Churn based on Monthly Charges level
SELECT 
    CASE 
        WHEN MonthlyCharges < 35 THEN 'Low Charges'
        WHEN MonthlyCharges <= 70 THEN 'Medium Charges'
        ELSE 'High Charges'
    END AS Charge_Category,
    
    COUNT(customerID) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(customerID), 
    2) AS Churn_Percentage
FROM Churn_data
GROUP BY 
    CASE 
        WHEN MonthlyCharges < 35 THEN 'Low Charges'
        WHEN MonthlyCharges <= 70 THEN 'Medium Charges'
        ELSE 'High Charges'
    END
ORDER BY Churn_Percentage DESC


-- Churn based on Internet Service Type
SELECT 
    InternetService,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
    2) AS Churn_Percentage
FROM Churn_data
GROUP BY InternetService
ORDER BY Churn_Percentage DESC


-- Churn based on Payment Method
SELECT 
    PaymentMethod,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
    2) AS Churn_Percentage
FROM Churn_data
GROUP BY PaymentMethod
ORDER BY Churn_Percentage DESC


-- Revenue at Risk
SELECT 
    SUM(MonthlyCharges) AS Total_Monthly_Revenue,
    SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END) AS Revenue_Lost_From_Churn,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END) * 100.0 / SUM(MonthlyCharges), 
    2) AS Revenue_Loss_Percentage
FROM Churn_data