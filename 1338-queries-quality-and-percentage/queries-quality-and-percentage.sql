Select
    query_name,
    round(avg(rating/position), 2) as quality,
    round(avg(rating < 3)* 100, 2) as poor_query_percentage
From Queries
Group by 1;