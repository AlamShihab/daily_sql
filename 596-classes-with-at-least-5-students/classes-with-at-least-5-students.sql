select class
From courses
Group by 1
Having count(*) >= 5;