-- Top 10 batsmen based on past 3 years strike rate (min 60 balls faced in each season)

With Final_table as (
    with bat_avg as (
        Select batsmanname,sum(balls) as No_of_balls ,Extract('Year' FROM m.matchdate) as Season
        from match_summary m
        join bating_summary b on m.match_id = b.match_id
        group by batsmanname, Season
        having sum(balls) >=60 
        Order by batsmanname
    )
    Select bat_avg.batsmanname,count(bat_avg.batsmanname) as Season_played
    from bat_avg 
    group by bat_avg.batsmanname
    having count(bat_avg.batsmanname) =3
    order by bat_avg.batsmanname
)

Select F.batsmanname,Sum(runs) as total_runs, Round((Cast(Sum(runs) as decimal)/sum(balls)) *100,2) as Strike_Rate
from Final_table F
left join bating_summary b on F.batsmanname = b.batsmanname
group by F.batsmanName
Order by total_runs DESC,Strike_Rate Desc
limit 10