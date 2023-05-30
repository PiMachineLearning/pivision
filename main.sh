#!/usr/bin/env bash

docker build -t pimachinelearning/pivision .
WHEEL=$(docker run pimachinelearning/pivision)
git clone https://__token__:$GITHUB_TOKEN@github.com/piMachineLearning/pimachinelearning.github.io/
cd pimachinelearning.github.io/ || exit 1
cd wheels || exit 1
[[ -d torchvision ]] || mkdir torchvision
cd torchvision || exit 1
docker cp $(docker ps -aq -n 1):$WHEEL .
git add .
git commit -m "Automated commit: build torchvision"
git push -u origin main
