#!/usr/bin/env bash

# clean up output directory
rm -rf ./lib
mkdir lib

# compile code
cd ./src || exit 1
GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o ../lib/

# copy files to output directory
cd ../
cp src/get-secrets-layer lib/

# create zip for lambda layer
cd lib || exit 1
chmod +x get-secrets-layer
zip get-secrets-layer.zip get-secrets-layer go-retrieve-secret
