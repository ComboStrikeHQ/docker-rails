#!/usr/bin/env bash
set -e

ENV_FILE='/home/app/.app_env'

aws ssm get-parameters-by-path \
    --path / \
    --with-decryption \
    --output text \
    | awk -F "\t" "{print \"export \" \$2 \"='\" \$4 \"'\"}" \
    > $ENV_FILE

echo "source $ENV_FILE" >> /home/app/.profile
