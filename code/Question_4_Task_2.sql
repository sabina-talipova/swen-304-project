-- Retrieve RobberId, Nickname and the Number of Years not spent in prison for all robbers who spent more than half of their life in prison.

SELECT 
  RobberId,
  Nickname,
  Age - NoYears AS YearsNotInPrison
FROM 
  Robbers
WHERE 
  NoYears > Age / 2;

-- robberid |   nickname    | yearsnotinprison 
-- ----------+---------------+------------------
--         6 | Tony Genovese |               12
--        16 | King Solomon  |               31
-- (2 rows)
 