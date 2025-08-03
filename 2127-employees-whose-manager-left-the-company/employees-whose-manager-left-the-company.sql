Select e.employee_id
From Employees e
Left join Employees m on e.manager_id = m.employee_id
Where 
    e.salary < 30000
    And m.employee_id IS NULL
    AND e.manager_id is not null
Order by 1;