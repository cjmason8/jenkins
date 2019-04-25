#!/bin/bash

<<<<<<< HEAD
set -e

FULL_IMAGE_NAME="jenkins"

echo "Building version."
TAG_NAME=$1

docker build --no-cache --pull -t ${FULL_IMAGE_NAME}:${TAG_NAME} .

docker tag ${FULL_IMAGE_NAME}:${TAG_NAME} cjmason8/${FULL_IMAGE_NAME}:${TAG_NAME}
docker tag ${FULL_IMAGE_NAME}:${TAG_NAME} cjmason8/${FULL_IMAGE_NAME}:latest
docker push cjmason8/${FULL_IMAGE_NAME}:latest
docker push cjmason8/${FULL_IMAGE_NAME}:${TAG_NAME}
=======
VERSION=$1

docker build --no-cache --pull -t cjmason8/jenkins:$VERSION .
docker push cjmason8/jenkins:$VERSION
>>>>>>> b8e3b1ce3686074e6baa5db4b4ef3c8cb49e2290
