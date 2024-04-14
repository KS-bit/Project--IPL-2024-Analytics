Create Database IPL_db;

--Match Summary
CREATE TABLE Match_Summary (
    team1 TEXT,	
    team2 TEXT,	
    winner TEXT,	
    margin TEXT,
    matchDate Date ,
    match_id TEXT PRIMARY KEY
);
Copy Match_Summary (team1, team2, winner, margin, matchDate,match_id)
From 'C:\Users\kirti\OneDrive\Desktop\Project\datasets\dim_match_summary.csv'
DELIMITER ','
CSV HEADER


-- Players
CREATE TABLE Players (
    name text PRIMARY KEY,	
    team TEXT,	
    battingStyle TEXT,	
    bowlingStyle TEXT,	
    playingRole Text
)
Copy Players (name,team,battingStyle,bowlingStyle,playingRole)
From 'C:\Users\kirti\OneDrive\Desktop\Project\datasets\dim_players.csv'
DELIMITER ','
CSV HEADER


--Bating_Summary
CREATE TABLE Bating_Summary (
        match_id TEXT,	
        match TEXT,	
        teamInnings TEXT,	
        battingPos INT,	
        batsmanName Text,	
        outornot_out TEXT,	
        runs INT,	
        balls INT,	
        "4s" INT,	
        "6s" INT,	
        SR Text,
        FOREIGN Key(match_id) REFERENCES Match_Summary(match_id),
        FOREIGN Key(batsmanName) REFERENCES Players(name) 
)

Copy Bating_Summary (match_id,match,teamInnings,battingPos,batsmanName,outornot_out,runs,balls,"4s","6s",SR)
From 'C:\Users\kirti\OneDrive\Desktop\Project\datasets\fact_bating_summary.csv'
DELIMITER ','
CSV HEADER

--Bowling_Summary
CREATE TABLE Bowling_Summary(
    match_id TEXT,	
    match TEXT,	
    bowlingTeam TEXT,	
    bowlerName TEXT,	
    overs INT,	
    maiden INT,	
    runs INT,	
    wickets INT,	
    economy	NUMERIC,
    "0s" INT,	
    "4s" INT,	
    "6s" INT,	
    wides INT,	
    noBalls INT,
    FOREIGN Key(match_id) REFERENCES Match_Summary(match_id),
    FOREIGN Key(bowlerName) REFERENCES Players(name) 
) 
 

COPY Bowling_Summary(match_id,match,bowlingTeam,bowlerName,overs,maiden,runs,wickets,economy,"0s","4s","6s",wides,noBalls)
FROM 'C:\Users\kirti\OneDrive\Desktop\Project\datasets\fact_bowling_summary.csv'
DELIMITER ','
CSV HEADER

--Updating the datatype for overs 
ALTER Table Bowling_Summary ALTER COLUMN overs Type NUMERIC

--The regular expression [^0-9.] matches any character that is not a digit or a period. By applying the 'g' flag, the function replaces all occurrences of these characters with an empty string, effectively removing them from the column values.

UPDATE bating_summary
SET sr = regexp_replace(sr, '[^0-9.]', '', 'g');
ALTER TABLE bating_summary ALTER COLUMN sr TYPE numeric USING sr::numeric;

-- Add a new column "No_of_balls" to store the number of balls
ALTER TABLE Bowling_Summary ADD COLUMN No_of_balls INTEGER;

-- Update the "No_of_balls" column using the formula ((integer part of overs) * 6) + (fractional part of overs * 10)
UPDATE Bowling_Summary
SET No_of_balls = (floor(overs) * 6) + (overs % 1 * 10)::int;
