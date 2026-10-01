-- Connect to database


-- PART I: SCHOOL ANALYSIS

-- TASK 1: View the schools and school details tables
SELECT * FROM schools;
SELECT * FROM school_details;

-- TASK 2: In each decade, how many schools were there that produced players? [Numeric Functions]



-- TASK 3: What are the names of the top 5 schools that produced the most players? [Joins]



-- TASK 4: For each decade, what were the names of the top 3 schools that produced the most players? [Window Functions]



-- PART II: SALARY ANALYSIS

-- TASK 1: View the salaries table
SELECT * FROM salaries;

-- TASK 2: Return the top 20% of teams in terms of average annual spending [Window Functions]



-- TASK 3: For each team, show the cumulative sum of spending over the years [Rolling Calculations]



-- TASK 4: Return the first year that each team's cumulative spending surpassed 1 billion [Min / Max Value Filtering]



-- PART III: PLAYER CAREER ANALYSIS

-- TASK 1: View the players table and find the number of players in the table
SELECT * FROM players;
SELECT COUNT(*) FROM players;

-- TASK 2: For each player, calculate their age at their first (debut) game, their last game,
-- and their career length (all in years). Sort from longest career to shortest career. [Datetime Functions]



-- TASK 3: What team did each player play on for their starting and ending years? [Joins]



-- TASK 4: How many players started and ended on the same team and also played for over a decade? [Basics]



-- PART IV: PLAYER COMPARISON ANALYSIS

-- TASK 1: View the players table
SELECT * FROM players;

-- TASK 2: Which players have the same birthday? Hint: Look into GROUP_CONCAT / LISTAGG / STRING_AGG [String Functions]



-- TASK 3: Create a summary table that shows for each team, what percent of players bat right, left and both [Pivoting]



-- TASK 4: How have average height and weight at debut game changed over the years, and what's the decade-over-decade difference? [Window Functions]


