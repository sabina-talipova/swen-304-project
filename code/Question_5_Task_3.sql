-- Retrieve BankName and City of all banks that were not robbed in the year, in which there were robbery plans for that bank.

-- CREATE VIEW RobberyYears AS
-- SELECT DISTINCT BankName, City, EXTRACT(YEAR FROM Date) AS RobberyYear
-- FROM Robberies;

-- CREATE VIEW PlanYears AS
-- SELECT DISTINCT BankName, City, EXTRACT(YEAR FROM PlannedDate) AS PlanYear
-- FROM Plans;

-- CREATE VIEW NotRobbedBank AS
-- SELECT p.BankName, p.City
-- FROM PlanYears p
-- LEFT JOIN RobberyYears r
--   ON p.BankName = r.BankName
--   AND p.City = r.City
--   AND p.PlanYear = r.RobberyYear
-- WHERE r.RobberyYear IS NULL;

-- SELECT * FROM NotRobbedBank;

SELECT DISTINCT p.BankName, p.City
FROM Plans p
WHERE EXTRACT(YEAR FROM p.PlannedDate) NOT IN (
  SELECT EXTRACT(YEAR FROM r.Date)
  FROM Robberies r
  WHERE r.BankName = p.BankName AND r.City = p.City
);

-- bankname     |   city    
-- -----------------+-----------
--  Bad Bank        | Chicago
--  Dollar Grabbers | Chicago
--  Gun Chase Bank  | Evanston
--  Hidden Treasure | Chicago
--  Inter-Gang Bank | Evanston
--  Loanshark Bank  | Deerfield
--  PickPocket Bank | Chicago
--  PickPocket Bank | Deerfield
-- (8 rows)