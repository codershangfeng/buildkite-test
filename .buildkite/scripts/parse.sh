#!/bin/bash

set -euo pipefail

echo "CSV_FILE:"
echo -e ${CSV_FILE}


echo "Start"

jq -R 'split(",")' <<< ${CSV_FILE} | jq '{requestType: .[0], registerNumber: .[1], storeId: .[2], storeAddress: .[3]}' >> temp

echo "end"