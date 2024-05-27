#!/bin/sh

cd "$(dirname "$0")"

if [ "$#" -ne 1 ]; then
    echo "Usage: ./release.sh tag" >&2
    exit 1
fi

tag=$1

set -e

docker image pull "boxboat/config-merge:$tag"
docker image tag "boxboat/config-merge:$tag" "boxboat/config-merge:latest"
docker image save -o "config-merge-$tag.tar" "boxboat/config-merge:$tag" "boxboat/config-merge:latest"
gzip "config-merge-$tag.tar"
