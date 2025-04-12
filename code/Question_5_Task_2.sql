-- Retrieve RobberId, Nickname, and Description of the first preferred skill of all robbers who have two or more skills.

-- CREATE VIEW RobbersWithMultipleSkills AS
--   SELECT RobberId
--   FROM HasSkills
--   GROUP BY RobberId
--   HAVING COUNT(*) >= 2;

-- CREATE VIEW FirstPreferredSkills AS
--   SELECT hs.RobberId, s.Description
--   FROM HasSkills hs
--   JOIN Skills s ON hs.SkillId = s.SkillId
--   WHERE hs.Preference = 1
--     AND hs.RobberId IN (SELECT RobberId FROM RobbersWithMultipleSkills);

-- SELECT r.RobberId, r.Nickname, fps.Description
-- FROM Robbers r
-- JOIN FirstPreferredSkills fps ON r.RobberId = fps.RobberId;


SELECT r.RobberId, r.Nickname, s.Description
FROM Robbers r
JOIN HasSkills hs ON r.RobberId = hs.RobberId
JOIN Skills s ON hs.SkillId = s.SkillId
WHERE hs.Preference = 1
  AND r.RobberId IN (
    SELECT RobberId
    FROM HasSkills
    GROUP BY RobberId
    HAVING COUNT(*) >= 2
);

-- robberid |     nickname      |  description  
-- ----------+-------------------+---------------
--        24 | Sonny Genovese    | Explosives
--         5 | Mimmy The Mau Mau | Planning
--         1 | Al Capone         | Planning
--         3 | Lucky Luchiano    | Lock-Picking
--         7 | Dutch Schulz      | Lock-Picking
--         8 | Clyde             | Lock-Picking
--        22 | Greasy Guzik      | Preaching
--        23 | Lepke Buchalter   | Driving
--        17 | Bugsy Siegel      | Driving
--        18 | Vito Genovese     | Scouting
--         1 | Al Capone         | Safe-Cracking
-- (11 rows)