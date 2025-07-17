SELECT Manager.name
FROM Employee
INNER JOIN Employee AS Manager
    ON (Employee.managerId = Manager.id)
Group BY Manager.id
Having COunt(*) >=5;