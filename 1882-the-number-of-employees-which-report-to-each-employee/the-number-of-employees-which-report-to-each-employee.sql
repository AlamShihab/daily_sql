Select
    Manager.employee_id,
    Manager.name,
    count(Employee.employee_id) AS reports_count,
    Round(avg(Employee.age)) AS average_age
From Employees As Manager
Inner join Employees as Employee
    ON (Employee.reports_to = Manager.employee_id)
Group by 1
Order by 1;