# Utilisez une image légère d'nginx comme base
FROM nginx:alpine

# Copiez tous les fichiers et répertoires à la racine de votre projet dans le répertoire de travail de l'image nginx
COPY ./* /usr/share/nginx/html/

# Exposez le port 80 pour permettre à Nginx de servir le contenu web
EXPOSE 80

# Commande par défaut pour démarrer Nginx une fois que le conteneur est démarré
CMD ["nginx", "-g", "daemon off;"]
