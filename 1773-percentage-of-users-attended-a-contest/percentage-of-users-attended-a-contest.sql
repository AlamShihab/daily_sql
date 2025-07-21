select 
    contest_id,
    ROUND(
        COUNT(user_id) * 100 / (
            Select count(*)
            From Users
        ),
        2
    ) As percentage

From Register 
Group by 1
Order by percentage DESC, contest_id;