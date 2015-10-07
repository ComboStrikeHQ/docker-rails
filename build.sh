#!/bin/bash -e

# Build and squash baseimage
docker build -t base ./base
ID=$(docker run -d base true)
docker export $ID | docker import - base-squashed

# Create onbuild image
docker build -t onbuild ./onbuild
