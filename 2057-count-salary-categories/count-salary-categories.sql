Select 
    'Low Salary' AS Category,
    SUM(income < 20000) AS accounts_count
From Accounts
Union all
Select 
    'Average Salary' Category,
    SUM(income >= 20000 AND income <= 50000) AS accounts_count
From Accounts
UNION ALL
Select
    'High Salary' category,
    Sum(income > 50000) as accounts_count
From Accounts