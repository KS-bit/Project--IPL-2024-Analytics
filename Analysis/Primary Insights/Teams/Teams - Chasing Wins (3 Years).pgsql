-- Top 2 teams with the highest number of wins achieved by chasing targets over the past 3 years.


With Teams_first_col as
        (    
            Select Distinct team1 as Teams,Count(match_id) as sum_1, 
                Sum(Case when team1 = winner then 1
                else 0
                end) as winning_no_1
            from match_summary
            where margin ILIKE '%wicket%'
            group by Teams
        )

Select T.Teams, 
       (T.winning_no_1+winning_no_2) as wins_achieved_by_chasing_targets
from
        (
            Select Distinct team2 as Teams_2,
                Count(match_id) as sum_2,
                Sum(Case when team2 = winner then 1
                else 0
                end) as winning_no_2
            from match_summary
            where margin ILIKE '%wicket%'
            group by Teams_2
        ) T2
Join Teams_first_col T on T.Teams = T2.Teams_2

order by wins_achieved_by_chasing_targets Desc
Limit 2