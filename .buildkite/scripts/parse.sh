#!/bin/bash

set -euo pipefail

#Color constants
readonly var RED='\033[0;31m'
readonly var GREEN='\033[0;32m'
readonly var YELLOW='\033[0;33m'
readonly var NC='\033[0m'

echo "************** Start Parsing and Sending ***************"
echo "Start parsing and sending message to SQS"
caids=`jq -R 'split("\t")' <<< "${MERCHANTS_INFO}"  \
 | jq '{requestType: .[0], registerNumber: .[1], storeId: .[2], storeAddress: .[3]}'`

caids_size=`echo ${caids} | jq -s '. | length'`
printf "${YELLOW}Caids count: ${caids_size}${NC}\n"

jq -c '.' <<< "${caids}" | while read caid; do
    # send to SQS
    echo "${caid} sent"
done
echo "************** Finished Parsing and Sending ***************"

printf "${GREEN}Done.${NC}\n"
