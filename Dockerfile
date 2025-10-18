FROM mariadb:11.8.3-noble
LABEL maintainer="andresgarcia0313@gmail.com"
COPY custom-my.cnf /etc/mysql/my.cnf
COPY docker-entrypoint-initdb.d/ /docker-entrypoint-initdb.d/
RUN chown mysql:mysql /etc/mysql/my.cnf && chmod 0444 /etc/mysql/my.cnf
