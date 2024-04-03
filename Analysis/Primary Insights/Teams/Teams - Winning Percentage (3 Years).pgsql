-- Top 4 teams based on past 3 years winning %.
       
With Teams_first_col as
        (    
            Select Distinct team1 as Teams,Count(match_id) as sum_1, 
                Sum(Case when team1 = winner then 1
                else 0
                end) as winning_no_1
            from match_summary
            group by Teams
        )

Select T.Teams, 
       Round(Cast((T.winning_no_1+winning_no_2) as decimal)/(T.sum_1 + sum_2)* 100,2) as Winning_percentage,
       (T.winning_no_1+winning_no_2) as total_wins,
       (T.sum_1 + sum_2) AS total_match_played
from
        (
            Select Distinct team2 as Teams_2,
                Count(match_id) as sum_2,
                Sum(Case when team2 = winner then 1
                else 0
                end) as winning_no_2
            from match_summary
            group by Teams_2
        ) T2
Join Teams_first_col T on T.Teams = T2.Teams_2

order by Winning_percentage Desc
Limit 4