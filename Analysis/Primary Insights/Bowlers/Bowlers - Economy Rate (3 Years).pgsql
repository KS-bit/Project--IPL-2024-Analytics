-- Top 10 bowlers based on past 3 years economy rate. (min 60 balls bowled in each season)

With Final_table as(
    With year_wise as(
        Select B.bowlername ,Sum(B.No_of_balls) as total_balls_peryear, Extract('Year' from M.matchdate)
        From Bowling_Summary B
        Left Join match_summary M on M.match_id = B.match_id
        group by bowlername,Extract('Year' from M.matchdate)
        Having Sum(B.No_of_balls) >=60
        order by bowlername
    )
    Select bowlername
    from year_wise
    group by bowlername 
    Having count(bowlername) =3
)
Select F.bowlername,Round(Cast(Sum(B.runs) as decimal)/(Sum(B.No_of_balls)/6),2) as Economy_rate,Sum(B.runs) as total_runs_given
From Final_table F
Left Join Bowling_Summary B ON F.bowlername = B.bowlername
Group By F.bowlername
Order by Economy_rate DESC, total_runs_given Asc
Limit 10 