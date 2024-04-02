--  Top 5 bowlers based on past 3 years dot ball %.

Select bowlername,Sum(No_of_balls) as total_balls,Round(Cast(Sum("0s") as decimal)/Sum(No_of_balls) *100,2) as Dot_ball_percentage
From Bowling_Summary
Group By bowlername
order By total_balls DESC, Dot_ball_percentage DESC
Limit 5