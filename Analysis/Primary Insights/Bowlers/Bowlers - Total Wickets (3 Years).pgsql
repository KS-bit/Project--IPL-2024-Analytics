--Top 10 bowlers based on past 3 years total wickets taken.

Select bowlerName, Sum(wickets) as Total_Wickets_Taken
FROM Bowling_Summary
GROUP BY bowlerName
order by Sum(wickets) Desc

Limit 10