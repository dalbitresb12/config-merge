#!/usr/bin/env pwsh

param([string]$image = "boxboat/config-merge") 

$location = "$(Get-Location)".Replace("\", "/")

Write-Output "JSON:"
docker run --rm `
  -v "$location/test/mix/:/home/node/" `
  "$image" `
  -f json "*"
Write-Output ""

Write-Output "TOML:"
docker run --rm `
  -v "$location/test/mix/:/home/node/" `
  "$image" `
  -f toml "*"
Write-Output ""

Write-Output "YAML array merge:"
docker run --rm `
  -v "$location/test/mix/:/home/node/" `
  "$image" `
  "*"
Write-Output ""

Write-Output "YAML array overwrite:"
docker run --rm `
  -v "$location/test/mix/:/home/node/" `
  "$image" `
  -a overwrite "*"
Write-Output ""

Write-Output "YAML array concat:"
docker run --rm `
  -v "$location/test/mix/:/home/node/" `
  "$image" `
  -a concat "*"
Write-Output ""

Write-Output "Docker Compose"
docker run --rm `
  -v "$location/test/docker-compose/:/home/node/" `
  "$image" `
  local.env docker-compose.yml docker-compose-local.patch.yml docker-compose-local.yml
Write-Output ""

Write-Output "Docker Compose no envsubst"
docker run --rm `
  -v "$location/test/docker-compose/:/home/node/" `
  "$image" `
  --no-envsubst local.env docker-compose.yml docker-compose-local.patch.yml docker-compose-local.yml
