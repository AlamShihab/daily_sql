Select
    Signups.user_id,
    IFNULL(ROUND(AVG(Confirmations.action = 'confirmed'),2),0) AS confirmation_rate
From Signups
Left join Confirmations
    using(user_id)
Group by 1;