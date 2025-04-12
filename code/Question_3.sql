INSERT INTO Skills (SkillId, Description) VALUES (21, 'Driving');

-- // Error in query (7): ERROR: cannot insert a non-DEFAULT value into column "skillid"
-- // DETAIL: Column "skillid" is an identity column defined as GENERATED ALWAYS.
-- // HINT: Use OVERRIDING SYSTEM VALUE to override.


INSERT INTO Banks (BankName, City, NoAccounts, Security) VALUES  ('Loanshark Bank', 'Evanston', 100, 'very good');

-- // Error in query (7): ERROR: duplicate key value violates unique constraint "banks_pkey"
-- // DETAIL: Key (bankname, city)=(Loanshark Bank, Evanston) already exists.

INSERT INTO Banks (BankName, City, NoAccounts, Security) VALUES ('EasyLoan Bank', 'Evanston', -5, 'excellent');

-- // Error in query (7): ERROR: new row for relation "banks" violates check constraint "banks_noaccounts_check"
-- // DETAIL: Failing row contains (EasyLoan Bank, Evanston, -5, excellent).

INSERT INTO Banks (BankName, City, NoAccounts, Security) VALUES ('EasyLoan Bank', 'Evanston', 100, 'poor');

-- // Query executed OK, 1 row affected


INSERT INTO Robberies (BankName, City, Date, Amount) VALUES ('NXP Bank', 'Chicago', '2019-01-08', 1000);

-- // Query executed OK, 1 row affected

DELETE FROM Skills WHERE SkillId = 1 AND Description = 'Driving';

-- // Query executed OK, 0 rows affected

-- Error in query (7): ERROR: update or delete on table "skills" violates foreign key constraint "hasskills_skillid_fkey" on table "hasskills"
-- DETAIL: Key (skillid)=(1) is still referenced from table "hasskills".


DELETE FROM Banks WHERE BankName = 'PickPocket Bank' AND City = 'Evanston' AND NoAccounts = 2000 AND Security = 'very good';

-- Error in query (7): ERROR: update or delete on table "banks" violates foreign key constraint "robberies_bankname_city_fkey" on table "robberies"
-- DETAIL: Key (bankname, city)=(PickPocket Bank, Evanston) is still referenced from table "robberies".

DELETE FROM Robberies WHERE BankName = 'Loanshark Bank' AND City = 'Chicago' AND Date = '' AND Amount = '';

-- Error in query (7): ERROR: invalid input syntax for type date: ""
-- LINE 1: ...= 'Loanshark Bank' AND City = 'Chicago' AND Date ='' AND Amo...

INSERT INTO Robbers (RobberId, Nickname, Age, NoYears) VALUES (1, 'Shotgun', 70, 0);

-- // Error in query (7): ERROR: cannot insert a non-DEFAULT value into column "robberid"
-- // DETAIL: Column "robberid" is an identity column defined as GENERATED ALWAYS.

INSERT INTO Robbers (RobberId, Nickname, Age, NoYears) VALUES (333, 'Jail Mouse', 25, 35);

-- // Error in query (7): ERROR: cannot insert a non-DEFAULT value into column "robberid"
-- // DETAIL: Column "robberid" is an identity column defined as GENERATED ALWAYS.

INSERT INTO HasSkills (RobberId, SkillId, Preference, Grade) VALUES (1, 7, 1, 'A+');

-- Query executed OK, 1 row affected.


INSERT INTO HasSkills (RobberId, SkillId, Preference, Grade) VALUES (1, 2, 0, 'A');

-- // Error in query (7): ERROR: new row for relation "hasskills" violates check constraint "hasskills_preference_check"
-- // DETAIL: Failing row contains (1, 2, 0, A).

INSERT INTO HasSkills (RobberId, SkillId, Preference, Grade) VALUES (333, 1, 1, 'B-');

-- // Error in query (7): ERROR: insert or update on table "hasskills" violates foreign key constraint "hasskills_robberid_fkey"
-- // DETAIL: Key (robberid)=(333) is not present in table "robbers".

INSERT INTO HasSkills (RobberId, SkillId, Preference, Grade) VALUES (3, 20, 3, 'B+');

-- Error in query (7): ERROR: insert or update on table "hasskills" violates foreign key constraint "hasskills_skillid_fkey"
-- DETAIL: Key (skillid)=(20) is not present in table "skills".


DELETE FROM Robbers WHERE RobberId = 1 AND  Nickname = 'Al Capone' AND Age = 31 AND NoYears = 2;

-- Error in query (7): ERROR: update or delete on table "robbers" violates foreign key constraint "hasskills_robberid_fkey" on table "hasskills"
-- DETAIL: Key (robberid)=(1) is still referenced from table "hasskills".

