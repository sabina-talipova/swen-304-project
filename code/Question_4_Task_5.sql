-- Retrieve RobberId, Nickname and individual total “earnings” of those robbers who have earned at least $50,000 by robbing banks.
-- The answer should be sorted in decreasing order of the total earnings.

SELECT 
  r.RobberId,
  r.Nickname,
  SUM(a.Share) as earnings
FROM 
  Accomplices AS a
LEFT JOIN Robbers AS r ON r.RobberId = a.RobberId
GROUP BY r.RobberId
HAVING SUM(a.Share) >= 50000
ORDER BY earnings DESC;

-- robberid |     nickname      | earnings 
-- ----------+-------------------+----------
--         5 | Mimmy The Mau Mau | 70000.00
--        15 | Boo Boo Hoff      | 61447.61
--        16 | King Solomon      | 59725.80
--        17 | Bugsy Siegel      | 52601.10
-- (4 rows)
 