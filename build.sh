#!/bin/bash -e

# Build and squash baseimage
docker build -t docker-rails-base ./base
ID=$(docker run -d docker-rails-base true)
docker export $ID | docker import - docker-rails-base-squashed

# Create onbuild image
docker build -t docker-rails-onbuild ./onbuild
