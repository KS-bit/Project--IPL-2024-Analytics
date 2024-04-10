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
Select F.bowlername,
    Round(Cast(Sum(B.runs) as decimal)/(Sum(B.No_of_balls)/6),2) as Economy_rate,
    Round(Cast(Sum(runs) as decimal)/Sum(wickets),2) as bowling_avg,
    Round(Cast(Sum("0s") as decimal)/Sum(No_of_balls) *100,2) as Dot_ball_percentage,
    Sum(B.runs) as total_runs_given
From Final_table F
Left Join Bowling_Summary B ON F.bowlername = B.bowlername
Group By F.bowlername