#!/usr/bin/env bash

docker build --build-arg -t VISION_VERSION=$1 pimachinelearning/pivision .
WHEEL=$(docker run pimachinelearning/pivision)
[[ -d pimachinelearning.github.io ]] && rm -rf pimachinelearning.github.io
git clone https://__token__:$GITHUB_TOKEN@github.com/piMachineLearning/pimachinelearning.github.io/
cd pimachinelearning.github.io/ || exit 1
git config commit.gpgsign false
git config user.name 'Automated Committer'
git config user.email 'bot@malwarefight.wip.la'
cd wheels || exit 1
[[ -d torchvision ]] || mkdir torchvision
cd torchvision || exit 1
docker cp $(docker ps -aq -n 1):$WHEEL .
git add .
git commit -m "Automated commit: build torchvision"
git push -u origin main
