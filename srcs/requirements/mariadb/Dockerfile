FROM debian:latest

RUN apt update && apt upgrade && apt install -y mariadb-server

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/.
COPY tools/init.sql /etc/mysql/init.sql
COPY tools/.env /etc/mysql/.env
RUN  mkdir -p /home/richard/data/mariadb

COPY tools/script.sh .

RUN mkdir /run/mysqld && chmod +x script.sh

CMD [ "mysqld" ]
