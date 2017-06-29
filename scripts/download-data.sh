#!/bin/bash

# 1. Setup your .envrc file:
# export AWS_REGION=us-west-1
# export AWS_ACCESS_KEY_ID=ACCESSKEYHERE
# export AWS_SECRET_ACCESS_KEY=SECRETKEYHERE

# 2. Run:
#    ./scripts/download-data.sh     Downloads stratified sampled JSON file
#    ./scripts/download-data.sh  "s3://newsclustering/stratified-sample"    Downloads all JSON gzipped data

ARG1=${1:-'s3://newsclustering/stratified-sample'}

# Download the data from S3
mkdir -p ./data/source
aws s3 sync ${ARG1} ./data/source