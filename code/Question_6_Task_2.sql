-- write a query to retrieve the Security level, the total Number of robberies that occurred in bank branches of that security level,
-- and the average Amount of money that was stolen during these robberies.

-- CREATE VIEW SecurityStats AS
--   SELECT 
--     b.Security,
--     COUNT(r.BankName) AS TotalRobberies,
--     AVG(r.Amount) AS AverageAmountStolen
--   FROM Banks b
--   JOIN Robberies r ON b.BankName = r.BankName AND b.City = r.City
--   GROUP BY b.Security;

-- SELECT 
--   ss.Security,
--   ss.TotalRobberies,
--   ss.AverageAmountStolen
-- FROM SecurityStats ss
-- WHERE ss.TotalRobberies IN (
--   SELECT TotalRobberies FROM SecurityStats
-- );


SELECT 
  bs.Security,
  COUNT(*) AS TotalRobberies,
  AVG(bs.Amount) AS AverageAmountStolen
FROM (
  SELECT 
    b.Security,
    r.Amount
  FROM Banks b
  JOIN Robberies r ON b.BankName = r.BankName AND b.City = r.City
) AS bs
GROUP BY bs.Security;


-- security  | totalrobberies |  averageamountstolen  
-- -----------+----------------+-----------------------
--  weak      |              4 | 2299.5000000000000000
--  very good |              4 | 9469.3200000000000000
--  excellent |             12 |    39238.083333333333
--  good      |              2 | 3980.0000000000000000