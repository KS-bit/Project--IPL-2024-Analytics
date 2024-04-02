-- Top 10 batsmen based on past 3 years total runs scored.
Select batsmanname,Sum(runs) as Total_runs
From bating_summary
group by batsmanname
Order By Total_runs DESC
Limit 10