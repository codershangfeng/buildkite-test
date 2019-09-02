#!/bin/bash

set -euo pipefail

echo "CSV_FILE:"
echo "${CSV_FILE}"


echo "Start"

jq -R 'split(",")' <<< "${CSV_FILE}" | jq 'inputs | {requestType: .[0], registerNumber: .[1], storeId: .[2], storeAddress: .[3]}' >> temp

echo "end"

echo "Cat temp"
cat temp