#!/bin/bash

VERSION=$1

docker build --no-cache --pull -t cjmason8/jenkins:$VERSION .
docker push cjmason8/jenkins:$VERSION
