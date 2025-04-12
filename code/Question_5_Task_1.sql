-- Retrieve RobberId, Nickname and individual total “earnings” of those robbers who participated in the robbery with the highest amount.
-- The answer should be sorted in decreasing order of the total earnings.

-- CREATE VIEW MaxRobberyAmount AS
--   SELECT MAX(Amount) AS MaxAmount
--   FROM Robberies;

-- CREATE VIEW MaxRobberies AS
--   SELECT *
--   FROM Robberies
--   WHERE Amount = (SELECT MaxAmount FROM MaxRobberyAmount);

-- CREATE VIEW MaxRobberyAccomplices AS
--   SELECT a.RobberId, a.BankName, a.City, a.Date, a.Share
--   FROM Accomplices a
--   JOIN MaxRobberies mr
--     ON a.BankName = mr.BankName AND a.City = mr.City AND a.Date = mr.Date;

-- SELECT a.RobberId, r.Nickname, SUM(a.Share) AS TotalEarnings
--   FROM MaxRobberyAccomplices a
--   JOIN Robbers r ON a.RobberId = r.RobberId
--   GROUP BY a.RobberId, r.Nickname
--   ORDER BY TotalEarnings DESC;



SELECT a.RobberId, r.Nickname, SUM(a.Share) AS TotalEarnings
FROM Accomplices a
JOIN Robbers r ON a.RobberId = r.RobberId
JOIN Robberies ro ON a.BankName = ro.BankName AND a.City = ro.City AND a.Date = ro.Date
WHERE ro.Amount = (
  SELECT MAX(Amount) FROM Robberies
)
GROUP BY a.RobberId, r.Nickname
ORDER BY TotalEarnings DESC;

-- robberid |    nickname    | totalearnings 
-- ----------+----------------+---------------
--        16 | King Solomon   |      16500.80
--         3 | Lucky Luchiano |      16500.00
--         4 | Anastazia      |      16500.00
--         8 | Clyde          |      16500.00
--        10 | Bonnie         |      16500.00
--        17 | Bugsy Siegel   |      16500.00
-- (6 rows)