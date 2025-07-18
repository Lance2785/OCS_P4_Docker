#Base de données

#installation basée sur la version 8.1 de mysql
FROM mysql:8.1.0

#installation du client mysql
# RUN apt-get update && apt-get install -y default-mysql-client

#déclaration des variables du repo
ARG REPO_USER=OpenClassrooms-Student-Center
ARG REPO_NAME=ASR-P4-BeeSafe
ARG BRANCH_NAME=sql

ENV BEESAFE_MYSQL_USER=beesafe
ENV BEESAFE_MYSQL_PASSWORD=xxxxx

#clonage du repo github
ADD https://github.com/${REPO_USER}/${REPO_NAME}/archive/refs/heads/${BRANCH_NAME}.tar.gz /tmp/repo.tar.gz

#extraction de la branche sql du repo dans le dossier des scripts mysql
RUN tar -xzf /tmp/repo.tar.gz -C /tmp && \
    mv /tmp/ASR-P4-BeeSafe-${BRANCH_NAME}/sql/*.sql /docker-entrypoint-initdb.d/ && \
    rm -rf /tmp/repo.tar.gz /tmp/ASR-P4-BeeSafe-${BRANCH_NAME}

#renommage des scripts pour démarrer la création de la base de données en 1er
RUN mv /docker-entrypoint-initdb.d/schema.sql /docker-entrypoint-initdb.d/01schema.sql && \
    mv /docker-entrypoint-initdb.d/data.sql /docker-entrypoint-initdb.d/02data.sql

#copie et autorisations du script de démarrage
COPY ./docker-mysql-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-mysql-entrypoint.sh

#lancement du script de démarrage
ENTRYPOINT ["/usr/local/bin/docker-mysql-entrypoint.sh"]

# CMD ["mysqld"]

# ENTRYPOINT ["tail", "-f", "/dev/null"]