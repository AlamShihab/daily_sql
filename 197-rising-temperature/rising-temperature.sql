Select today.id
from Weather as today
inner join Weather as yesterday
ON (DATE_SUB(today.recordDate, INTERVAL 1 DAY ) = yesterday.recordDate)
where today.temperature > yesterday.temperature;