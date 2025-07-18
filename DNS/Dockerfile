#Serveur DNS

#image basée sur le docker bind9
FROM ubuntu/bind9:latest

#création des dossiers de bind9
# RUN mkdir -p /var/cache/bind /var/lib/bind /etc/bind

# RUN mkdir -p /etc/bind

WORKDIR /etc/bind/

#permissions
# RUN chmod +x /etc/bind/

# RUN chown -R bind:bind /var/cache/bind /var/lib/bind /etc/bind

#copie des fichiers de configuration et de zone
COPY ./config/named.conf /etc/bind/
COPY ./config/named.conf.options /etc/bind/
COPY ./config/named.conf.local /etc/bind/
COPY ./zones/db.beesafe.co /etc/bind/

#permissions
# RUN chown -R bind:bind /var/cache/bind /var/lib/bind /etc/bind

#ouverture du port 53 
EXPOSE 53:53

#démarrage BIND9
# CMD ["/usr/sbin/named", "-g"]
CMD ["/usr/sbin/named", "-g", "-c", "/etc/bind/named.conf", "-u", "bind"]

# ENTRYPOINT ["tail", "-f", "/dev/null"]
