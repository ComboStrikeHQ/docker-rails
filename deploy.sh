#!/bin/bash -e

. VERSION

docker login -u $DOCKER_USER -p $DOCKER_PASSWORD
docker tag docker-rails-onbuild $DOCKER_TAG:latest
docker push $DOCKER_TAG:latest
docker tag docker-rails-onbuild $DOCKER_TAG:ruby-2.5
docker push $DOCKER_TAG:ruby-2.5

if ! docker pull $DOCKER_TAG:$VERSION; then
  echo "Releasing new version: $VERSION"

  docker tag docker-rails-onbuild $DOCKER_TAG:$VERSION
  docker push $DOCKER_TAG:$VERSION
else
  echo "Not overwriting existing version: $VERSION"
fi
