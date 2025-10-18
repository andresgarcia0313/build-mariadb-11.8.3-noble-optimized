#!/usr/bin/env bash
DOCKERHUB_USERNAME="andresgarcia0313" 
IMAGE_NAME="mariadb-optimized"
TAG="11.8.3-noble-lts"
docker login
# Construir
FULL_IMAGE_NAME="${DOCKERHUB_USERNAME}/${IMAGE_NAME}:${TAG}"
docker build -t "${FULL_IMAGE_NAME}" .
# Subir la imagen a Docker Hub
docker push "${FULL_IMAGE_NAME}"
