SELECT COUNT(*) AS Total_Customers
FROM Churn_data

SELECT Churn, COUNT(*) AS Customer_Count
FROM Churn_data
GROUP BY Churn

SELECT COUNT(*)
FROM Churn_data
WHERE TotalCharges IS NULL

SELECT customerID, tenure, TotalCharges
FROM Churn_data
WHERE TotalCharges IS NULL

UPDATE Churn_data
SET TotalCharges = 0
WHERE TotalCharges IS NULL

SELECT COUNT(*)
FROM Churn_data
WHERE TotalCharges IS NULL

SELECT customerID, COUNT(*)
FROM Churn_data
GROUP BY customerID
HAVING COUNT(*) > 1