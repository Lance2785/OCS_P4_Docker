#!/bin/bash
set -e

echo "Initialisation Base de données..."

# echo "Création compte d'exploitation..."
# mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<EOF
# CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
# GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
# FLUSH PRIVILEGES;
# EOF

echo "Création du fichier de script SQL..."
SQL_USERSCRIPT="/docker-entrypoint-initdb.d/00-user.sql"

cat > $SQL_USERSCRIPT << EOF
CREATE USER IF NOT EXISTS '${BEESAFE_MYSQL_USER}'@'%' IDENTIFIED BY '${BEESAFE_MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${BEESAFE_MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# cat << EOF > $SQL_USERSCRIPT
# CREATE USER IF NOT EXISTS '${BEESAFE_MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQBEESAFE_MYSQL_PASSWORDL_PASSWORD}';
# GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${BEESAFE_MYSQL_USER}'@'%';
# FLUSH PRIVILEGES;
# EOF

#CMD
echo "Lancement des scripts SQL..."
# exec "$@"

# Exécuter l'entrée par défaut de l'image MySQL
exec /usr/local/bin/docker-entrypoint.sh mysqld
# exec /usr/local/bin/docker-entrypoint.sh
# exec mysqld