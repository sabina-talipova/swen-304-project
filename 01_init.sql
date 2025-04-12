CREATE TABLE Banks (
  BankName VARCHAR(255) NOT NULL,
  City VARCHAR(255) NOT NULL,
  NoAccounts INT CHECK (NoAccounts >= 0),
  Security TEXT DEFAULT 'unknown',
  PRIMARY KEY (BankName, City)
);

CREATE TABLE Robberies (
  BankName VARCHAR(255) NOT NULL,
  City VARCHAR(255) NOT NULL,
  Date DATE,
  Amount DECIMAL(10,2),
  FOREIGN KEY (BankName, City) REFERENCES Banks(BankName, City) ON DELETE CASCADE
);

CREATE TABLE Plans (
  BankName VARCHAR(255) NOT NULL,
  City VARCHAR(255) NOT NULL,
  PlannedDate DATE,
  NoRobbers INT CHECK (NoRobbers > 0),
  FOREIGN KEY (BankName, City) REFERENCES Banks(BankName, City) ON DELETE CASCADE
);

CREATE TABLE Robbers (
  RobberId INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  Nickname VARCHAR(255) NOT NULL,
  Age INT CHECK (Age >= 0),
  NoYears INT CHECK (NoYears >= 0),
  CHECK (NoYears <= Age)
);

CREATE TABLE Skills (
  SkillId INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  Description TEXT NOT NULL
);

CREATE TABLE HasSkills (
  RobberId INT,
  SkillId INT,
  Preference INT CHECK (Preference > 0),
  Grade VARCHAR(5),
  FOREIGN KEY (RobberId) REFERENCES Robbers(RobberId) ON DELETE CASCADE,
  FOREIGN KEY (SkillId) REFERENCES Skills(SkillId) ON DELETE CASCADE
);

CREATE TABLE HasAccounts (
  RobberId INT,
  BankName VARCHAR(255) NOT NULL,
  City VARCHAR(255) NOT NULL,
  FOREIGN KEY (RobberId) REFERENCES Robbers(RobberId) ON DELETE CASCADE,
  FOREIGN KEY (BankName, City) REFERENCES Banks(BankName, City) ON DELETE CASCADE
);

CREATE TABLE Accomplices (
  RobberId INT NOT NULL,
  BankName VARCHAR(255) NOT NULL,
  City VARCHAR(255) NOT NULL,
  Date DATE,
  Share DECIMAL(10,2),
  FOREIGN KEY (RobberId) REFERENCES Robbers(RobberId) ON DELETE CASCADE,
  FOREIGN KEY (BankName, City) REFERENCES Banks(BankName, City) ON DELETE CASCADE
);
