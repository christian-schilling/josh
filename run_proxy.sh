#!/usr/bin/env bash

# this script can be used to run tests in the container used for deployement.
# usage:
#  Run all tests: ./tester.sh
#  Run specific test: ./tester.sh path/to/test.t

set -e
shopt -s extglob
shopt -s inherit_errexit


#-e JOSH_META_REPO=/shadow-config.git\

docker buildx build\
    --target=dev-local -t josh-dev-local .\
    --build-arg USER_UID="$(id -u)" \
    --build-arg USER_GID="$(id -g)"

docker run -it --rm\
    --workdir "$(pwd)"\
    -p 8000:8000\
    --volume "$(pwd)":"$(pwd)"\
    --volume cache:/opt/cache\
    --user "$(id -u)":"$(id -g)"\
    josh-dev-local\
    bash -c "cargo run -p josh-proxy --release -- --local /opt/cache/josh_gh --gc --remote https://github.com --require-auth --cache-duration 0 --static-resource-proxy-target='http://host.docker.internal:3000'"
    #bash -c "cargo run -p josh-proxy --release -- --local /opt/cache/josh_gh --gc --remote https://github.com --require-auth --cache-duration 0"
    #bash -c "cargo run -p josh-proxy --release -- --local /opt/cache/josh --gc --remote https://github.cds.internal.unity3d.com --require-auth --cache-duration 300 --static-resource-proxy-target='http://host.docker.internal:3000'"
    #bash -c "cargo run -p josh-proxy --release -- --local /opt/cache/josh --remote https://github.com --require-auth --cache-duration 0"
    #bash -c "cargo run -p josh-proxy --release -- --local /opt/cache/josh_local --remote http://host.docker.internal:8001 --cache-duration 0"
    #bash -c "cargo run -p josh-proxy --release -- --local /opt/cache/josh --gc --remote https://github.cds.internal.unity3d.com --require-auth --cache-duration 1"




