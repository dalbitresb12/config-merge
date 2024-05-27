#!/bin/sh

image="${1:-boxboat/config-merge}"

set -e

echo "JSON:"
docker run --rm \
    -v "$(pwd)/test/mix/:/home/node/" \
    "$image" \
    -f json "*"
echo ""

echo "TOML:"
docker run --rm \
    -v "$(pwd)/test/mix/:/home/node/" \
    "$image" \
    -f toml "*"
echo ""

echo "YAML array merge:"
docker run --rm \
    -v "$(pwd)/test/mix/:/home/node/" \
    "$image" \
    "*"
echo ""

echo "YAML array overwrite:"
docker run --rm \
    -v "$(pwd)/test/mix/:/home/node/" \
    "$image" \
    -a overwrite "*"
echo ""

echo "YAML array concat:"
docker run --rm \
    -v "$(pwd)/test/mix/:/home/node/" \
    "$image" \
    -a concat "*"
echo ""

echo "Docker Compose"
docker run --rm \
    -v "$(pwd)/test/docker-compose/:/home/node/" \
    "$image" \
    local.env docker-compose.yml docker-compose-local.patch.yml docker-compose-local.yml
echo ""

echo "Docker Compose no envsubst"
docker run --rm \
    -v "$(pwd)/test/docker-compose/:/home/node/" \
    "$image" \
    --no-envsubst local.env docker-compose.yml docker-compose-local.patch.yml docker-compose-local.yml
