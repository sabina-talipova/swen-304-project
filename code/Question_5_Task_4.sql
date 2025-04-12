-- Retrieve RobberId and Nickname of all robbers who never robbed the banks at which they have an account.

-- CREATE VIEW RobbersWhoRobbedTheirBank AS
--   SELECT DISTINCT a.RobberId
--   FROM HasAccounts a
--   JOIN Accomplices b
--     ON a.RobberId = b.RobberId
--   AND a.BankName = b.BankName
--   AND a.City = b.City;


-- CREATE VIEW RobbersWhoDidNotRobTheirBank AS
--   SELECT r.RobberId, r.Nickname
--   FROM Robbers r
--   WHERE r.RobberId NOT IN (
--     SELECT RobberId FROM RobbersWhoRobbedTheirBank
--   );

-- SELECT * FROM RobbersWhoDidNotRobTheirBank;

SELECT r.RobberId, r.Nickname
FROM Robbers r
WHERE NOT EXISTS (
  SELECT 1
  FROM HasAccounts ha
  JOIN Accomplices a ON ha.RobberId = a.RobberId
                    AND ha.BankName = a.BankName
                    AND ha.City = a.City
  WHERE ha.RobberId = r.RobberId
);

-- robberid |    nickname     
-- ----------+-----------------
--         2 | Bugsy Malone
--         3 | Lucky Luchiano
--         4 | Anastazia
--         6 | Tony Genovese
--         7 | Dutch Schulz
--         9 | Calamity Jane
--        10 | Bonnie
--        12 | Moe Dalitz
--        13 | Mickey Cohen
--        14 | Kid Cann
--        15 | Boo Boo Hoff
--        16 | King Solomon
--        19 | Mike Genovese
--        21 | Waxey Gordon
--        23 | Lepke Buchalter
--        24 | Sonny Genovese
-- (16 rows)