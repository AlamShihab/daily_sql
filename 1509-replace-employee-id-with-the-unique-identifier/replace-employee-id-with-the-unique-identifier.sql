select 
    Employees.name, 
    EmployeeUNI.unique_id
from Employees 
left join EmployeeUNI
    using(id);