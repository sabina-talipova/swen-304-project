-- Retrieve BankName and City of all banks that have never been robbed.

SELECT b.BankName, b.City
FROM Banks b
LEFT JOIN Robberies r ON b.BankName = r.BankName AND b.City = r.City
WHERE r.BankName IS NULL;


-- bankname     |   city    
-- -----------------+-----------
--  Bankrupt Bank   | Evanston
--  Loanshark Bank  | Deerfield
--  Inter-Gang Bank | Chicago
--  NXP Bank        | Evanston
--  Dollar Grabbers | Chicago
--  Gun Chase Bank  | Burbank
--  PickPocket Bank | Deerfield
--  Hidden Treasure | Chicago
--  Outside Bank    | Chicago
-- (9 rows)