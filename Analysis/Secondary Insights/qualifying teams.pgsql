-- If two or more teams have the same number of points, the net run rate (NRR) is used to determine their positions.

Select Distinct winner, count(winner) *2 as points, Extract('Year' from matchdate) as Year
From match_summary
group by winner, Year
order by year

