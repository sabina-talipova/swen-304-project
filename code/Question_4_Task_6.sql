-- Retrieve the Description of all skills together with RobberId and NickName of all robbers who possess this skill.
-- The answer should be ordered by skill description.

SELECT r.RobberId, r.Nickname, s.Description FROM Robbers AS r
LEFT JOIN hasskills AS hs ON r.RobberId = hs.RobberId
LEFT JOIN skills AS s ON hs.SkillId = s.SkillId
ORDER BY s.Description ASC;

-- robberid |     nickname      |  description   
-- ----------+-------------------+----------------
--        18 | Vito Genovese     | Cooking
--         5 | Mimmy The Mau Mau | Driving
--        17 | Bugsy Siegel      | Driving
--         7 | Dutch Schulz      | Driving
--        23 | Lepke Buchalter   | Driving
--        20 | Longy Zwillman    | Driving
--         3 | Lucky Luchiano    | Driving
--         6 | Tony Genovese     | Eating
--        18 | Vito Genovese     | Eating
--         2 | Bugsy Malone      | Explosives
--        24 | Sonny Genovese    | Explosives
--         4 | Anastazia         | Guarding
--        23 | Lepke Buchalter   | Guarding
--        17 | Bugsy Siegel      | Guarding
--        21 | Waxey Gordon      | Gun-Shooting
--         9 | Calamity Jane     | Gun-Shooting
--         7 | Dutch Schulz      | Lock-Picking
--         3 | Lucky Luchiano    | Lock-Picking
--        24 | Sonny Genovese    | Lock-Picking
--         8 | Clyde             | Lock-Picking
--        22 | Greasy Guzik      | Lock-Picking
--        14 | Kid Cann          | Money Counting
--        13 | Mickey Cohen      | Money Counting
--        19 | Mike Genovese     | Money Counting
--         5 | Mimmy The Mau Mau | Planning
--        15 | Boo Boo Hoff      | Planning
--         8 | Clyde             | Planning
--        16 | King Solomon      | Planning
--         1 | Al Capone         | Planning
--        10 | Bonnie            | Preaching
--        22 | Greasy Guzik      | Preaching
--         1 | Al Capone         | Preaching
--         1 | Al Capone         | Safe-Cracking
--        24 | Sonny Genovese    | Safe-Cracking
--        12 | Moe Dalitz        | Safe-Cracking
--        11 | Meyer Lansky      | Safe-Cracking
--         1 | Al Capone         | Safe-Cracking
--         8 | Clyde             | Scouting
--        18 | Vito Genovese     | Scouting
-- (39 rows)
 