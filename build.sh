#!/bin/bash

docker build --no-cache --pull -t cjmason8/jenkins:3 .
docker push cjmason8/jenkins:3
