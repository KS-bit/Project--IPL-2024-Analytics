--
Select batsmanname,sum(runs) as runs_per_year,Extract('Year' FROM m.matchdate) as Season, Sum(balls) as No_of_balls
from match_summary m
join bating_summary b on m.match_id = b.match_id
group by batsmanname, Season
Order by runs_per_year desc,No_of_balls asc
