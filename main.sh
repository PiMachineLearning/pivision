#!/usr/bin/env bash

docker build --build-arg VISION_VERSION=$1 -t pimachinelearning/pivision .
WHEEL=$(docker run pimachinelearning/pivision)
docker cp $(docker ps -aq -n 1):$WHEEL .
LOCAL_FILE=$(ls | grep whl)
touch empty
while true
do
    # ensure that Sharin is not currently rebuilding the static repo
    echo -e "get uploader/lock /dev/null" | sftp -b -  uploader@$VPS_HOST 
    if [ $? -ne 0 ]; then
        echo "safe to work" # not entirely due to data races, but risk is reduced
        break
    fi
    sleep 60
done
echo -e "put empty uploader/lock" | sftp -b - uploader@$VPS_HOST 
echo -e "cd uploader/wheels/torchvision\nput $LOCAL_FILE" | sftp -b - uploader@$VPS_HOST
echo -e "rm uploader/lock" | sftp uploader@$VPS_HOST
