Select 
    user_id,
    count(follower_id) as followers_count
From Followers
Group by 1
Order by 1;