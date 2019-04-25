#!/bin/bash

set -e

FULL_IMAGE_NAME="jenkins"

echo "Building version."
TAG_NAME=$1

docker build --no-cache --pull -t ${FULL_IMAGE_NAME}:${TAG_NAME} .

docker tag ${FULL_IMAGE_NAME}:${TAG_NAME} cjmason8/${FULL_IMAGE_NAME}:${TAG_NAME}
docker tag ${FULL_IMAGE_NAME}:${TAG_NAME} cjmason8/${FULL_IMAGE_NAME}:latest
docker push cjmason8/${FULL_IMAGE_NAME}:latest
docker push cjmason8/${FULL_IMAGE_NAME}:${TAG_NAME}
