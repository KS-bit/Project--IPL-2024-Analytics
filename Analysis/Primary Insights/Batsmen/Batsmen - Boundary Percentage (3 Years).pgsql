-- Top 5 batsmen based on past 3 years boundary % (fours and sixes).

With boundary_runs_table as (
    Select batsmanname, Cast((Sum("4s" * 4) + Sum("6s" * 6)) as decimal) boundary_runs,
    Sum(runs) total_runs
    FROM bating_summary
    GROUP BY batsmanname
)

Select batsmanname, 
        Case 
        when total_runs <> 0 then Round((boundary_runs/total_runs),2)*100
        When total_runs = 0 then 0
        End As Boundary_Percentage,
        total_runs,boundary_runs
FROM boundary_runs_table 
Order By boundary_runs DESC,Boundary_Percentage Desc
Limit 5

