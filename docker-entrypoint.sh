#!/bin/bash

# Run scanner
/usr/local/bin/lw-scanner evaluate ${INPUT_IMAGE_NAME} ${INPUT_IMAGE_TAG} --build-plan ${GITHUB_REPOSITORY} --build-id ${GITHUB_RUN_ID} --data-directory ${GITHUB_WORKSPACE}
if [ $? != 0 ]; then
    echo "Vulnerability scan failed. Failing action as security can not be guaranteed."
    exit 1
fi

# Cecking results
if [[ ${INPUT_FAIL_ONLY_IF_VULNERABILITIES_FIXABLE} ]] && [[ $(cat ${GITHUB_WORKSPACE}/evaluations/${INPUT_IMAGE_NAME}/${INPUT_IMAGE_TAG}/evaluation_*.json | jq '.fixable_vulnerabilities') -ge 1 ]]; then
    echo "At least one fixable vulnerabilty found."
    exit 1
elif [[ ${INPUT_FAIL_IF_CRITICAL_VULNERABILITIES_FOUND} ]] && [[ $(cat ${GITHUB_WORKSPACE}/evaluations/${INPUT_IMAGE_NAME}/${INPUT_IMAGE_TAG}/evaluation_*.json | jq '.critical_vulnerabilities') -ge 1 ]]; then
    echo "At least one critical vulnerabilty found."
    exit 1
elif [[ ${INPUT_FAIL_IF_HIGH_VULNERABILITIES_FOUND} ]] && [[ $(cat ${GITHUB_WORKSPACE}/evaluations/${INPUT_IMAGE_NAME}/${INPUT_IMAGE_TAG}/evaluation_*.json | jq '.high_vulnerabilities') -ge 1 ]]; then
    echo "At least one high vulnerabilty found."
    exit 1
elif [[ ${INPUT_FAIL_IF_MEDIUM_VULNERABILITIES_FOUND} ]] && [[ $(cat ${GITHUB_WORKSPACE}/evaluations/${INPUT_IMAGE_NAME}/${INPUT_IMAGE_TAG}/evaluation_*.json | jq '.medium_vulnerabilities') -ge 1 ]]; then
    echo "At least one medium vulnerabilty found."
    exit 1
elif [[ ${INPUT_FAIL_IF_LOW_VULNERABILITIES_FOUND} ]] && [[ $(cat ${GITHUB_WORKSPACE}/evaluations/${INPUT_IMAGE_NAME}/${INPUT_IMAGE_TAG}/evaluation_*.json | jq '.low_vulnerabilities') -ge 1 ]]; then
    echo "At least one low vulnerabilty found."
    exit 1
elif [[ ${INPUT_FAIL_IF_INFO_VULNERABILITIES_FOUND} ]] && [[ $(cat ${GITHUB_WORKSPACE}/evaluations/${INPUT_IMAGE_NAME}/${INPUT_IMAGE_TAG}/evaluation_*.json | jq '.info_vulnerabilities') -ge 1 ]]; then
    echo "At least one info vulnerabilty found."
    exit 1
else
    exit 0
fi