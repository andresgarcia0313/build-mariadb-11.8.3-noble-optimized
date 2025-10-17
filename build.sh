#!/usr/bin/env bash
set -euo pipefail

# build.sh - Construye y (opcional) sube la imagen
# Variables editables:
IMAGE_NAME="mariadb-optimized"
TAG="11.8.3-noble-lts"
# Si quieres subir a un registry, define REGISTRY (por ejemplo: myregistry.example.com)
REGISTRY="${REGISTRY:-}"  # dejar vacío por defecto para no pushear

# Construir imagen local
echo "Construyendo imagen ${IMAGE_NAME}:${TAG}..."
docker build -t "${IMAGE_NAME}:${TAG}" .

# Tag para registry si REGISTRY está definido
if [[ -n "${REGISTRY}" ]]; then
  FULL_IMAGE="${REGISTRY}/${IMAGE_NAME}:${TAG}"
  echo "Taggeando imagen como ${FULL_IMAGE}..."
  docker tag "${IMAGE_NAME}:${TAG}" "${FULL_IMAGE}"

  echo "Haciendo push a ${FULL_IMAGE}..."
  docker push "${FULL_IMAGE}"
  echo "Push completado."
else
  echo "REGISTRY no definido: la imagen se queda local: ${IMAGE_NAME}:${TAG}"
fi

echo "Hecho."
