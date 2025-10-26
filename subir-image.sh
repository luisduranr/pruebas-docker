#!/bin/bash
# PRIMERO DEBE LOGUEARSE EN LOCAL CON docker login
# docker login  -u luisfer34

imagenes=("ucb-backend-1"  "ucb-frontend-1")
url_registry=luisfer34

# Loop through the array
for imagen in "${imagenes[@]}"
do
   echo -e "############## ${imagen} #######################"
   # docker pull $imagen
   docker tag $imagen:latest luisfer34/$imagen:1.0.0
   docker push luisfer34/$imagen:1.0.0
done

# docker push luisfer34/ucb-backend-1:1.0.0

# docker tag nest-vue-newsletter-backend:latest luisfer34/ucb-backend-1:1.0.0


