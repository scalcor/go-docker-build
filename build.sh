#!/bin/bash

[ "$1" != "" ] && APP=$1
if [ "$APP" == "" ]
then
    echo "app name must be given by command parameter or APP environment variable."
    exit 99
fi

[ "$KEY_FILE" == "" ] && KEY_FILE="./id_github"

arg="--build-arg APP=$APP"
[ "$GIT_SERVER" != "" ] && arg="$arg --build-arg GIT_SERVER=$GIT_SERVER"
[ "$GIT_USER" != "" ] && arg="$arg --build-arg GIT_USER=$GIT_USER"
[ "$KEY_PASSPHRASE" != "" ] && arg="$arg --build-arg KEY_PASSPHRASE=\"$KEY_PASSPHRASE\""

docker build --network=host $arg --build-arg SSH_KEY="$(cat $KEY_FILE)" -t $APP .
