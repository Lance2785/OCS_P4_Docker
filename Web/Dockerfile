#Serveur WEB

#'image basée sur le docker php:8.2-apache'
FROM php:8.2-apache

#descriptif de l'image
#LABEL org.opencontainers.image.authors="Lance2785"
#LABEL version="1.0"
#LABEL description="Ce docker contient le site www.besafe.co basé sur un repo github"

#installation des applications et dépendances nécessaires
# RUN apt-get install mysqli && apt-get configure mysqli --with-mysqli=mysqlnd
RUN docker-php-ext-install mysqli && docker-php-ext-configure mysqli --with-mysqli=mysqlnd

#'initialisation des variables'
ENV SITE_DOMAIN=www.beesafe.co
ENV DB_SERVERNAME=DATABASE
ENV DB_NAME=""
ENV DB_USER=""
ENV DB_PASSWORD=""
ENV DB_PORT=3306

#'initialisation du dossier de travail'
WORKDIR /var/www/html/

#'clonage du repo github'
#RUN git clone https://github.com/Lance2785/OCS_P4_Applications
# ADD https://github.com/OpenClassrooms-Student-Center/ASR-P4-BeeSafe.git /var/www/html/
ADD https://github.com/OpenClassrooms-Student-Center/ASR-P4-BeeSafe.git .

#'copie et autorisations du script de démarrage'
COPY ./docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

#'lancement du script de démarrage'
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

#'démarrage du serveur apache'
CMD ["apache2-foreground"]

#'ouverture du port 80'
EXPOSE 80
