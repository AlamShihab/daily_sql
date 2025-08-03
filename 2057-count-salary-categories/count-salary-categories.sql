/* Solution1: best one
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
*/

/* #Solution2: Only return non-null values. 
Select
    Case
        When income < 20000 Then 'Low Salary'
        When income BETWEEN 20000 AND 50000 THEN 'Average Salary'
        ELSE 'High Salary'
    END as category,
    Count(*) as accounts_count
From Accounts
Group by
    CASE 
        When income < 20000 THEN 'Low Salary'
        When income Between 20000 and 50000 Then 'Average Salary'
        Else 'High Salary'
    End;

*/

With Categories AS (
    Select 'Low Salary' As category
    UNION ALL
    Select 'Average Salary'
    Union all
    Select 'High Salary'
),
CategoryCOunts AS (
    Select
        Case
            When income < 20000 THEN 'Low Salary'
            When income Between 20000 and 50000 Then 'Average Salary'
            Else 'High Salary'
        END AS category,
        Count(*) AS accounts_count
    From Accounts
    Group By
        case
            when income < 20000 Then 'Low Salary'
            When income Between 20000 AND 50000 then 'Average Salary'
            ELSE 'High Salary'
        END
)
Select
    c.Category,
    Coalesce(cc.accounts_count, 0) as accounts_count
From Categories c
Left join CategoryCounts cc ON c.category = cc.category;