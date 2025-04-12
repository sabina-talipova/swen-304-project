-- Retrieve BankName and city of all banks where Al Capone has an account. The answer should list every bank at most once.

SELECT 
  ha.BankName,
  ha.City
FROM 
  HasAccounts AS ha
LEFT JOIN Robbers AS r ON r.RobberId = ha.RobberId
WHERE r.Nickname = 'Al Capone';

-- bankname     |   city   
-- -----------------+----------
--  NXP Bank        | Chicago
--  Inter-Gang Bank | Evanston
--  Bad Bank        | Chicago
-- (3 rows)
 