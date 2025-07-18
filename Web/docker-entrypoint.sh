#!/bin/bash
set -e

echo "Initialisation Apache..."

echo "Modification du fichier de configuration vars.php..."
VARS_PHP="/var/www/html/vars.php"

# Creation des variables php
# if [ ! -z "$SITE_DOMAIN" ]; then
cat > $VARS_PHP << EOF
<?php
\$servername = "$DB_SERVERNAME";
\$username = '$DB_USER';
\$password = '$DB_PASSWORD';
\$dbname = "$DB_NAME";
\$port = $DB_PORT;
?>
EOF
# fi

echo "Modification du fichier de configuration Apache..."

#Modification du ServerName dans httpd.conf
SERVER_NAME=${SITE_DOMAIN:-"localhost"}
echo "Modification du ServerName : $SERVER_NAME"

#Dossier du fichier httpd.conf
HTTPD_CONF="/etc/apache2/apache2.conf"

#Vérification du ServerName
if grep -q "^ServerName" $HTTPD_CONF; then
    #Si ServerName existant, mise à jour
    sed -i "s/^ServerName .*/ServerName $SERVER_NAME/" $HTTPD_CONF
else
    #Si ServerName non existant, ajout à la fin du fichier
    echo "ServerName $SERVER_NAME" >> $HTTPD_CONF
fi

# Création du Virtual Host Apache
# if [ ! -z "$SITE_DOMAIN" ]; then
    echo "Paramétrage de l'hôte virtuel pour $SITE_DOMAIN"
    cat > /etc/apache2/sites-available/000-default.conf << EOF
<VirtualHost *:80>
    ServerName $SITE_DOMAIN
    DocumentRoot /var/www/html
    
    <Directory /var/www/html>
        AllowOverride All
        Require all granted
    </Directory>
    
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF
# fi

echo "Initialisation Apache terminée !"

#CMD
echo "Démarrage du serveur web Apache..."
exec "$@"
# CMD ["apache2-foreground"]