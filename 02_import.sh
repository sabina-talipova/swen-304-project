#!/bin/bash

echo "Waiting PostgreSQL..."
until pg_isready -U "$POSTGRES_USER" -d "$POSTGRES_DB"; do
  sleep 2
done

echo "Import files from /database"

for filepath in /database/*.data; do
  filename=$(basename "$filepath")
  tablename="${filename%.*}"

  echo "Import into the '$tablename' from file '$filename'"
  psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "\copy ${tablename} FROM '$filepath' WITH (FORMAT text, DELIMITER E'\t')"
done

echo "Import is finished"
