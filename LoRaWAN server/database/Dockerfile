FROM mysql:8.0.29

ENV MYSQL_USER mysql_user
ENV MYSQL_PASSWORD 1234
ENV MYSQL_ROOT_PASSWORD 1234
ENV MYSQL_DATABASE lorawan

COPY ./scripts/ /docker-entrypoint-initdb.d/
