-- write a query that finds the average share of all robberies in Chicago,
-- and also the average share of all robberies in the other city (i.e., not Chicago) with the largest average share.
-- Note that the average share of a bank robbery can be determined based on the number of participating robbers.

-- DROP VIEW AvgSharePerCity;
-- DROP VIEW AvgSharePerRobbery;

-- CREATE VIEW AvgSharePerRobbery AS
--   SELECT BankName, City, Date, AVG(Share) AS AvgShare
--   FROM Accomplices
--   GROUP BY BankName, City, Date
--   ORDER BY AvgShare;

-- CREATE VIEW AvgSharePerCity AS
--   SELECT City, AVG(AvgShare) AS CityAvgShare
--   FROM AvgSharePerRobbery
--   GROUP BY City;


-- SELECT 
--   (SELECT CityAvgShare FROM AvgSharePerCity WHERE City = 'Chicago') AS ChicagoAvg,
--   (SELECT MAX(CityAvgShare) 
--    FROM AvgSharePerCity 
--    WHERE City <> 'Chicago') AS MaxNonChicagoAvg;


SELECT
  (SELECT AVG(AvgShare) 
   FROM (
     SELECT AVG(Share) AS AvgShare
     FROM Accomplices
     WHERE City = 'Chicago'
     GROUP BY BankName, City, Date
   ) AS ChicagoAvg) AS ChicagoAvg,
  (SELECT AVG(AvgShare)
   FROM (
     SELECT AVG(Share) AS AvgShare
     FROM Accomplices
     WHERE City <> 'Chicago'
     GROUP BY BankName, City, Date
   ) AS OtherCitiesAvg) AS MaxNonChicagoAvg;

-- chicagoavg       |   maxnonchicagoavg    
-- -----------------------+-----------------------
--  3197.4602857142857143 | 7106.3821428571427857
-- (1 row)