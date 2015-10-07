#!/bin/bash -e

docker login -e $DOCKER_EMAIL -u $DOCKER_USER -p $DOCKER_PASSWORD
docker tag onbuild $DOCKER_TAG
docker push $DOCKER_TAG
