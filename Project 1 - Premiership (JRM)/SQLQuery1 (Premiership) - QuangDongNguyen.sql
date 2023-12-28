
SELECT * FROM team;
SELECT * FROM player;
SELECT * FROM team_manager;
SELECT * FROM manager;
SELECT * FROM nation;
SELECT * FROM match;
SELECT * FROM goal;


----------------------------------------------
/*
Task 1: Query the names of teams with the most own goals
*/
----------------------------------------------
SELECT TOP(1) WITH ties -- TOP(1) only returns 1 records while WITH ties shows the result returns more than one with ties values 
	t.team_name,
	SUM(g.own_goal) AS total_goal
FROM 
	((goal g LEFT JOIN player p ON g.player_id = p.player_id)
	LEFT JOIN team t ON p.team_id = t.team_id)
GROUP BY
	t.team_name
ORDER BY
	SUM(g.own_goal) DESC;



----------------------------------------------
/*
Task 2: Query for the name of the Golden Boot winner (player who scored the most goals)
*/
----------------------------------------------
SELECT TOP(1) WITH ties
	p.player_id,
	p.player_name,
	COUNT(g.goal_order) AS total_goal
FROM
	(goal g LEFT JOIN player p ON g.player_id = p.player_id)
GROUP BY
	p.player_id,
	p.player_name
ORDER BY
	total_goal DESC;




----------------------------------------------
/*
Task 3: Query for the number of drawn matches with goals
*/
----------------------------------------------
SELECT
	COUNT(m.home_score) AS total_home_score
FROM match m
WHERE m.home_score = m.away_score AND home_score = 0;





----------------------------------------------
/*
Task 4: Query for the name of the team that scored the fewest goals away from home
*/
----------------------------------------------
SELECT TOP(1) WITH ties
	m.away_team_id,
	t.team_name,
	SUM(away_score) AS Total_score
FROM match m LEFT JOIN team t ON m.away_team_id = t.team_id
GROUP BY
	m.away_team_id,
	t.team_name
ORDER BY
	SUM(away_score) ASC;




----------------------------------------------
/*
Task 5: Query for the name of the team that conceded the most goals
*/
----------------------------------------------
With as_away_team AS (
	SELECT
		away_team_id,
		SUM(home_score) AS total_home_score
	FROM match
	GROUP BY away_team_id),
	as_home_team AS (
	SELECT
		home_team_id,
		SUM(away_score) AS total_away_score
	FROM match
	GROUP BY home_team_id)
SELECT TOP(1) WITH ties
	t.team_name,
	h.home_team_id,
	a.total_home_score + h.total_away_score AS conceded_goals
FROM 
	(as_away_team a JOIN as_home_team h ON a.away_team_id = h.home_team_id)
	JOIN team t ON t.team_id = h.home_team_id
ORDER BY
	a.total_home_score + h.total_away_score DESC;



----------------------------------------------
/*
Task 6: Query for the average number of goals scored
*/
----------------------------------------------
SELECT
	COUNT(goal_order) / COUNT(DISTINCT(match_id)) AS average_goals
FROM goal;



----------------------------------------------
/*
Task 7: Query for the name of the country with the most players competing in the top league
*/
----------------------------------------------
SELECT TOP(1) WITH ties
	n.nation_name,
	COUNT(n.nation_name) AS Count_nation
FROM player p LEFT JOIN nation n ON p.nation_id = n.nation_id
GROUP BY
	n.nation_name
ORDER BY
	Count_nation DESC;



----------------------------------------------
/*
Task 8: Query for the name of the teams with the most number of replaced managers.
*/
----------------------------------------------
SELECT TOP(10) WITH ties
	t.team_name,
	COUNT(DISTINCT(manager_id)) AS number_of_replaced_managers
FROM team_manager tm LEFT JOIN team t ON tm.team_id = t.team_id
GROUP BY
	t.team_name
ORDER BY
	number_of_replaced_managers DESC;




----------------------------------------------
/*
Task 9: Query for the name of the dearest manager and the time leading
*/
----------------------------------------------
SELECT
	m.manager_name AS Longest_Tenure_Manager,
	DATEDIFF(DAY, tm.start_date, COALESCE(tm.end_date, (SELECT MAX(end_date) FROM team_manager))) AS Tenure_Days --COALESCE replaces the null value in value1 by value2. 
FROM team_manager tm JOIN manager m ON tm.manager_id = m.manager_id
WHERE tm.start_date = (SELECT MIN(start_date) FROM team_manager);


----------------------------------------------
/*
Task 10: Query for the names of matches with the most goals and their corresponding goal counts. 
Note: Match names are recorded in the format of home team vs. away team, for example, Chelsea vs. Arsenal
*/
----------------------------------------------
SELECT TOP(1)
    CONCAT(t1.team_name, ' vs ', t2.team_name) AS Match_Name,
    (m.home_score + m.away_score) AS Goals_Scored
FROM 
	((match m INNER JOIN team t1 ON m.home_team_id = t1.team_id) 
	INNER JOIN team t2 ON m.away_team_id = t2.team_id)
ORDER BY
    Goals_Scored DESC;