USE cc_transaction;

SELECT * FROM transactions;


-- Query for Top 10 States by their Expenditure

SELECT State, Sum(Amount) as `Total Expenditure`
FROM 
transactions Group by State 
ORDER BY `Total Expenditure` desc limit 10;



-- Query for Top 10 Cities by their Expenditure

SELECT City, sum(amount) as `Total Expenditure` 
FROM 
transactions GROUP BY City 
ORDER BY `Total Expenditure` DESC LIMIT 10;



-- Query to find out total expenditure of category seprately

SELECT 
    `exp type`,
    CASE 
        WHEN sum(amount) >= 1000000000 THEN CONCAT(ROUND(sum(amount) / 1000000000, 2), ' B')
        WHEN sum(amount) >= 1000000 THEN CONCAT(ROUND(sum(amount) / 1000000, 2), ' M')
        ELSE sum(amount)
    END AS `Total expenditure`
FROM transactions
GROUP BY `exp type`
ORDER BY sum(amount) DESC;



-- Query for expense by male and female in each category

WITH ExpenseTotals AS (
    SELECT 
        `exp type`,
        gender,
        SUM(amount) AS total_expense
    FROM transactions
    GROUP BY `exp type`, gender
),
ExpenseGenderPercentages AS (
    SELECT 
        `exp type`,
        gender,
        total_expense,
        total_expense / SUM(total_expense) OVER (PARTITION BY `exp type`) * 100 AS percentage
    FROM ExpenseTotals
)
SELECT 
    `exp type`,
    gender,
    CONCAT(ROUND(total_expense / 1000000, 2), ' M') AS total_expense,
    ROUND(percentage, 2) AS percentage
FROM ExpenseGenderPercentages
ORDER BY `exp type`, gender;


-- TOP City by CC Expenditure

SELECT City, CONCAT(ROUND(sum(amount)/1000000, 2), ' M') AS total_expense 
FROM 
transactions GROUP BY CITY 
ORDER BY total_expense DESC 
LIMIT 1;

-- TOP Expense type by users in the particular category

SELECT `exp type` as Category, CONCAT(ROUND(SUM(amount)/1000000, 2), ' M') AS total_expense
FROM
transactions GROUP BY Category
ORDER BY total_expense DESC
LIMIT 1;


-- TOP Card type by max expenditure 

SELECT `Card Type`, sum(amount) AS total_expense
FROM
transactions GROUP BY `Card type`
ORDER BY total_expense DESC
LIMIT 1;


select * from transactions;