Select
    employee_id,
    department_id
From Employee
where primary_flag = "Y"
Union Distinct
Select
    employee_id,
    department_id
From Employee
Group by 1
Having count(*) = 1;