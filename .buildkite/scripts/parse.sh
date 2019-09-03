#!/bin/bash

set -euo pipefail


#Color constants
readonly var RED='\033[0;31m'
readonly var GREEN='\033[0;32m'
readonly var YELLOW='\033[0;33m'
readonly var NC='\033[0m'

# Set the URL of csv file.
CSV_FILE_URL="CSV_FILE.csv"

echo "Retrieve CSV file from S3: ${CSV_FILE_URL}"
# aws s3 ....  CSV_FILE_URL
printf "${GREEN}Retrieved successfully${NC}\n"

CSV_DATA=`cat ${CSV_FILE_URL} | sed -e 's/^"//' -e 's/"$//'`

echo "************** Start Parsing and Sending ***************"
echo "Start parsing and sending message to SQS"
caids=`jq -R 'split("\t")' <<< "${CSV_DATA}"  \
 | jq '[inputs | {requestType: .[0], registerNumber: .[1], storeId: .[2], storeAddress: .[3]}]'`


caids_size=`echo ${caids} | jq '. | length'`
printf "${YELLOW}Caids count: ${caids_size}${NC}\n"

jq -c '.[]' <<< "${caids}" | while read caid; do
    echo "caid: "${caid}

    # send to SQS

done
echo "************** Finished Parsing and Sending ***************"

printf "${GREEN}Finished parsing and sending message to SQS successfully.${NC}\n"
