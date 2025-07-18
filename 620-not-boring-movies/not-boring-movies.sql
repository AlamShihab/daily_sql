select *
from Cinema
Where 
    MOD(id, 2) = 1 AND
    description != 'boring'
Order by rating DESC;
