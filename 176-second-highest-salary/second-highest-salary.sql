WITH 
    RankedEmployees AS (
        Select *, Dense_rank() over(order by salary desc) as `rank`
        From Employee
    )
Select Max(salary) as SecondHighestSalary
From RankedEmployees
Where  `rank` = 2;