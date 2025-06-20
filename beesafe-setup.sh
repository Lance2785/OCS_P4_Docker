#script d'installation du site beesafe.co avec les conteneurs Docker
#!/bin/bash
set -e

echo "Démarrage du script..."

#construction des images de chaque conteneur
echo "Construction des images..."
docker build -t beesafe-web Web/ && docker build -t beesafe-db Database/ && docker build -t beesafe-dns DNS/

#tag des imags
echo "Tag des images..."
docker tag beesafe-web lance2785/beesafe-web:latest && docker tag beesafe-db lance2785/beesafe-db:latest && docker tag beesafe-dns lance2785/beesafe-dns:latest

#connexion au compte des repo Docker
echo "Connexion à Docker Hub..."
docker login -u lance2785

#dépôt des images dans les repo Docker Hub
echo "Dépôt des images..."
docker push lance2785/beesafe-web:latest && docker push lance2785/beesafe-db:latest && docker push lance2785/beesafe-dns:latest

#création des conteneurs basés sur les images des repo
echo "Création des containers..."
docker compose up -d

echo "Fin du script !"