With 
    AllIds as (
        Select requester_id as id from RequestAccepted
        Union all
        Select accepter_id from RequestAccepted
    )
Select
    id,
    Count(*) as num
From AllIds
Group by   1
Order by 2 desc
Limit 1;