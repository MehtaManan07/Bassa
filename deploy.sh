#! /bin/bash

# Build production and development use docker images
# Build these images with two build args for better commit history 
# shows only logs pushed to stderr
docker build --build-arg VCS_REF=`git rev-parse --short HEAD`   --build-arg BUILD_DATE=`date -u +”%Y-%m-%dT%H:%M:%SZ”` -t scoreucsc/bassa-prod-ui ui >/dev/null
docker build -f ui/Dockerfile.dev --build-arg VCS_REF=`git rev-parse --short HEAD`   --build-arg BUILD_DATE=`date -u +”%Y-%m-%dT%H:%M:%SZ”` -t scoreucsc/bassa-dev-ui ui >/dev/null
docker build -f components/core/Dockerfile.prod --build-arg VCS_REF=`git rev-parse --short HEAD`   --build-arg BUILD_DATE=`date -u +”%Y-%m-%dT%H:%M:%SZ”` -t scoreucsc/bassa-prod-server components/core >/dev/null
docker build --build-arg VCS_REF=`git rev-parse --short HEAD`   --build-arg BUILD_DATE=`date -u +”%Y-%m-%dT%H:%M:%SZ”` -t scoreucsc/bassa-dev-server components/core >/dev/null
docker build --build-arg VCS_REF=`git rev-parse --short HEAD`   --build-arg BUILD_DATE=`date -u +”%Y-%m-%dT%H:%M:%SZ”` -t scoreucsc/bassa-aria2c components/aria2c >/dev/null

# push both production and development use docker images to dockerhub
docker login -u "$DOCKER_USERNAME" -p "$DOCKER_PASSWORD"
docker push scoreucsc/bassa-prod-ui
docker push scoreucsc/bassa-dev-ui
docker push scoreucsc/bassa-prod-server
docker push scoreucsc/bassa-dev-server
docker push scoreucsc/bassa-aria2c