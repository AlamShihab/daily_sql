Select
    sell_date,
    Count(distinct product) as num_sold,
    Group_concat(Distinct product order by product) as products
From Activities
Group by 1;