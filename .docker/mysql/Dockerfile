FROM mariadb:latest

COPY initdb.d /docker-entrypoint-initdb.d
RUN chmod +x -R /docker-entrypoint-initdb.d
