#!/bin/bash

RANCHER_ACCESS_KEY=$1
RANCHER_SECRET_KEY=$2
<<<<<<< HEAD
RANCHER_URL=$3
=======
RANCHER_URL=http://80.241.221.122:8080/v2-beta/projects/1a5
>>>>>>> b8e3b1ce3686074e6baa5db4b4ef3c8cb49e2290
BASE_DIR=${PWD}

echo "Force pulling..."
rancher-compose --url ${RANCHER_URL} --access-key ${RANCHER_ACCESS_KEY} --secret-key ${RANCHER_SECRET_KEY} -p jenkins -f ${BASE_DIR}/docker-compose.yml pull

echo "Starting deployment..."
rancher-compose --url ${RANCHER_URL} --access-key ${RANCHER_ACCESS_KEY} --secret-key ${RANCHER_SECRET_KEY} -r ${BASE_DIR}/rancher-compose..yml -p jenkins -f ${BASE_DIR}/docker-compose.yml up --upgrade -d --pull --batch-size 1

if [ $? -eq 0 ]; then
  echo "Deploy success! Confirming..."
  rancher-compose --url ${RANCHER_URL} --access-key ${RANCHER_ACCESS_KEY} --secret-key ${RANCHER_SECRET_KEY} -p jenkins -f ${BASE_DIR}/docker-compose.yml up --confirm-upgrade -d --batch-size 1
else
  echo "Deploy failed :( rolling back..."
  rancher-compose --url ${RANCHER_URL} --access-key ${RANCHER_ACCESS_KEY} --secret-key ${RANCHER_SECRET_KEY} -p jenkins -f ${BASE_DIR}/docker-compose.yml up --rollback -d --batch-size 1
fi
