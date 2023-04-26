#!/bin/bash

set -x -e
docker build -t byconity/byconity-base -f Dockerfile.base 
