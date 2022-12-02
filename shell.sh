#!/usr/bin/env bash

set -e
shopt -s extglob
shopt -s inherit_errexit


docker buildx build\
    --target=dev-local -t josh-dev-local .\
    --build-arg USER_UID="$(id -u)" \
    --build-arg USER_GID="$(id -g)"

docker run -it --rm\
    --workdir "$(pwd)"\
    -p 3000:3000\
    --volume "$(pwd)":"$(pwd)"\
    --volume cache:/opt/cache\
    --user "$(id -u)":"$(id -g)"\
    josh-dev-local

