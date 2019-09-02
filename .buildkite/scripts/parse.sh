#!/bin/bash

set -euo pipefail


#Color constants
readonly var RED='\033[0;31m'
readonly var GREEN='\033[0;32m'
readonly var NC='\033[0m'

# Set the URL of csv file.
CSV_FILE_NAME="CSV_FILE.csv"

echo "Retrieve CSV file from S3:"
# aws s3 ....  CSV_FILE_URL
printf "${GREEN}Retrieve successfully${NC}\n"

echo "Start parsing and sending message to SQS.... (Refactor the file name with variable)"
caids_data=`jq -R 'split(",")' "${CSV_FILE_NAME}"  \
 | jq '[inputs | {requestType: .[0], registerNumber: .[1], storeId: .[2], storeAddress: .[3]}]'`

echo "caids_data:"
echo ${caids_data}

echo "length:"
caids_size=`echo ${caids_data} | jq '. | length'`

printf "${RED}Sending message to SQS queue.${NC}\n"
jq -c '.[]' <<< "${caids_data}" | while read caid; do
    echo "caid: "${caid}

    # send to SQS

done

printf "${GREEN}Finished parsing and sending message to SQS successfully.${NC}\n"
