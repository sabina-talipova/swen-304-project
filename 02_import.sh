#!/bin/bash

ordered_files=(
  "robbers_25.data"
  "banks_25.data"
  "plans_25.data"
  "robberies_25.data"
  "hasaccounts_25.data"
  "hasskills_25.data"
  "accomplices_25.data"
)

declare -A file_to_table=(
  ["robbers_25.data"]="Robbers"
  ["banks_25.data"]="Banks"
  ["plans_25.data"]="Plans"
  ["robberies_25.data"]="Robberies"
  ["hasaccounts_25.data"]="HasAccounts"
  ["hasskills_25.data"]="HasSkills"
  ["accomplices_25.data"]="Accomplices"
)

declare -A table_fields=(
  ["Accomplices"]="RobberId, BankName, City, Date, Share"
  ["Banks"]="BankName, City, NoAccounts, Security"
  ["Robbers"]="Nickname, Age, NoYears"
  ["HasAccounts"]="RobberId, BankName, City"
  ["HasSkills"]="RobberId, SkillId, Preference, Grade"
  ["Plans"]="BankName, City, PlannedDate, NoRobbers"
  ["Robberies"]="BankName, City, Date, Amount"
)

echo "Waiting PostgreSQL..."
until pg_isready -U "$POSTGRES_USER" -d "$POSTGRES_DB"; do
  sleep 2
done

echo "Import files from /data"

for filename in "${ordered_files[@]}"; do
  table="${file_to_table[$filename]}"
  fields="${table_fields[$table]}"
  filepath="/data/$filename"

  echo "Import $filename → Table $table"

if [[ "$table" == "HasSkills" ]]; then
  psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" <<EOF
DROP TABLE IF EXISTS temp_${table};
CREATE TEMP TABLE temp_${table} (
  Nickname TEXT,
  Skill TEXT,
  Preference INT,
  Grade TEXT
);

\copy temp_${table}(Nickname, Skill, Preference, Grade) FROM '${filepath}' WITH (FORMAT text, DELIMITER E'\t');

CREATE TABLE IF NOT EXISTS Skills (
  SkillId INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  Description TEXT UNIQUE
);

INSERT INTO Skills(Description)
SELECT DISTINCT t.Skill
FROM temp_${table} t
WHERE NOT EXISTS (
  SELECT 1 FROM Skills s WHERE s.Description = t.Skill
);

INSERT INTO ${table}(RobberId, SkillId, Preference, Grade)
SELECT r.RobberId, s.SkillId, t.Preference, t.Grade
FROM temp_${table} t
INNER JOIN Robbers r ON r.Nickname = t.Nickname
INNER JOIN Skills s ON s.Description = t.Skill;
EOF

  elif [[ "$table" == "HasAccounts" ]]; then
    psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" <<EOF
DROP TABLE IF EXISTS temp_${table};
CREATE TEMP TABLE temp_${table} (
  Nickname TEXT,
  BankName TEXT,
  City TEXT
);

\copy temp_${table}(Nickname, BankName, City) FROM '${filepath}' WITH (FORMAT text, DELIMITER E'\t');

INSERT INTO ${table}(RobberId, BankName, City)
SELECT r.RobberId, t.BankName, t.City
FROM temp_${table} t
JOIN Robbers r ON r.Nickname = t.Nickname;
EOF

  elif [[ "$table" == "Accomplices" ]]; then
    psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" <<EOF
DROP TABLE IF EXISTS temp_${table};
CREATE TEMP TABLE temp_${table} (
  Nickname TEXT,
  BankName TEXT,
  City TEXT,
  Date DATE,
  Share DECIMAL(10,2)
);

\copy temp_${table}(Nickname, BankName, City, Date, Share) FROM '${filepath}' WITH (FORMAT text, DELIMITER E'\t');

INSERT INTO ${table}(RobberId, BankName, City, Date, Share)
SELECT r.RobberId, t.BankName, t.City, t.Date, t.Share
FROM temp_${table} t
JOIN Robbers r ON r.Nickname = t.Nickname;
EOF

  else
    psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" <<EOF
\copy ${table}(${fields}) FROM '${filepath}' WITH (FORMAT text, DELIMITER E'\t')
EOF
  fi
done

echo "Import is finished"
