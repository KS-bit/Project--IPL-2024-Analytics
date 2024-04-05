With Final_table as(
    With year_wise as(
        Select B.bowlername ,Sum(wickets) as No_of_wicket,Sum(B.No_of_balls) as total_balls_peryear, Extract('Year' from M.matchdate)
        From Bowling_Summary B
        Left Join match_summary M on M.match_id = B.match_id
        group by bowlername,Extract('Year' from M.matchdate)
        Having Sum(B.No_of_balls) >=60
        order by No_of_wicket desc, total_balls_peryear ASC
    )
    Select bowlername
    from year_wise
    group by bowlername 
)