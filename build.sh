#!/bin/sh
source config.sh
docker build -t $RPXC_IMAGE .
