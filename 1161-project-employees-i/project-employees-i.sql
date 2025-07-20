Select 
    p.project_id,
    round(
        avg(
            e.experience_years
            ),
            2
        ) 
        as average_years
From Project as p
inner join Employee as e
using(employee_id)
group by 1;