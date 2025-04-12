FROM postgres:latest

COPY 01_init.sql /docker-entrypoint-initdb.d/

COPY 02_import.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/02_import.sh
