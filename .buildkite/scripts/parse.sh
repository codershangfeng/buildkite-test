#!/bin/bash

set -euo pipefail



echo "Start"

echo ${CSV_FILE} | jq -R 'split(",")' | jq '{requestType: .[0], registerNumber: .[1], storeId: .[2], storeAddress: .[3]}' >> temp

echo "end"