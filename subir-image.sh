#!/bin/bash
# PRIMERO DEBE LOGUEARSE EN LOCAL CON docker login
# login para poder subir imagenes al repositorio de gitlab


# docker login  -u luisfer34

imagenes=("ucb-backend-1:latest"  "ucb-frontend-1:latest")
url_registry=luisfer34

# Loop through the array
for imagen in "${imagenes[@]}"
do
   echo -e "############## ${imagen} #######################"
   # docker pull $imagen
   docker tag $imagen $url_registry/$imagen
   docker push $url_registry/$imagen
done


# docker push luisfer34/ucb-backend-1:1.0.0

# docker tag nest-vue-newsletter-backend:latest luisfer34/ucb-backend-1:1.0.0


