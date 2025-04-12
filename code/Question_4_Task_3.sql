-- Retrieve RobberId, Nickname, Age, and all skill descriptions of all robbers who are not younger than 35 years.

SELECT 
  r.RobberId,
  r.Nickname,
  r.Age,
  s.Description
FROM 
  Robbers AS r
LEFT JOIN hasskills AS hs ON r.RobberId = hs.RobberId
LEFT JOIN skills AS s ON hs.SkillId = s.SkillId
WHERE r.Age >= 35;

-- robberid |    nickname    | age |  description   
-- ----------+----------------+-----+----------------
--        24 | Sonny Genovese |  39 | Explosives
--         2 | Bugsy Malone   |  42 | Explosives
--        17 | Bugsy Siegel   |  48 | Guarding
--         4 | Anastazia      |  48 | Guarding
--        16 | King Solomon   |  74 | Planning
--        15 | Boo Boo Hoff   |  54 | Planning
--        18 | Vito Genovese  |  66 | Cooking
--         9 | Calamity Jane  |  44 | Gun-Shooting
--        24 | Sonny Genovese |  39 | Lock-Picking
--         3 | Lucky Luchiano |  42 | Lock-Picking
--         7 | Dutch Schulz   |  64 | Lock-Picking
--        24 | Sonny Genovese |  39 | Safe-Cracking
--        12 | Moe Dalitz     |  41 | Safe-Cracking
--         3 | Lucky Luchiano |  42 | Driving
--        20 | Longy Zwillman |  35 | Driving
--         7 | Dutch Schulz   |  64 | Driving
--        17 | Bugsy Siegel   |  48 | Driving
--        18 | Vito Genovese  |  66 | Eating
--        18 | Vito Genovese  |  66 | Scouting
--        19 | Mike Genovese  |  35 | Money Counting
-- (20 rows)
 