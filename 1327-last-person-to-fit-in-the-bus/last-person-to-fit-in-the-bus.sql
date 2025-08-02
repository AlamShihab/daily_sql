With 
    AccumulatedQueue AS (
        Select
            person_name,
            SUM(weight) Over(order by turn) as accumulated_weight
            From Queue
    )
Select person_name
From AccumulatedQueue
Where accumulated_weight <= 1000
Order by accumulated_weight DESC
Limit 1;