#!/bin/bash

# Run scanner
/usr/local/bin/lw-scanner evaluate ${INPUT_IMAGE_NAME} ${INPUT_IMAGE_TAG} --build-plan ${GITHUB_REPOSITORY} --build-id ${GITHUB_RUN_ID} --data-directory ${GITHUB_WORKSPACE}
if [ $? != 0 ]; then
    echo "Vulnerability scan failed. Failing action as security can not be guaranteed."
    exit 1
fi

ls -alR ${GITHUB_WORKSPACE}

# Cecking results
if [ ${INPUT_FAIL_ONLY_IF_VULNERABILITIES_FIXABLE} ] && [ $(jq '.fixable_vulnerabilities' ${GITHUB_WORKSPACE}/evaluations/${INPUT_IMAGE_NAME}/${INPUT_IMAGE_TAG}/evaluation_*.json) -ge 1 ]; then
    echo "At least one fixable vulnerabilty found. Failing action."
    exit 1
elif [ ${INPUT_FAIL_IF_CRITICAL_VULNERABILITIES_FOUND} ] && [ $(jq '.critical_vulnerabilities' ${GITHUB_WORKSPACE}/evaluations/${INPUT_IMAGE_NAME}/${INPUT_IMAGE_TAG}/evaluation_*.json) -ge 1 ]; then
    echo "At least one critical vulnerabilty found. Failing action."
    exit 1
elif [ ${INPUT_FAIL_IF_HIGH_VULNERABILITIES_FOUND} ] && [ $(jq '.high_vulnerabilities' ${GITHUB_WORKSPACE}/evaluations/${INPUT_IMAGE_NAME}/${INPUT_IMAGE_TAG}/evaluation_*.json) -ge 1 ]; then
    echo "At least one high vulnerabilty found. Failing action."
    exit 1
elif [ ${INPUT_FAIL_IF_MEDIUM_VULNERABILITIES_FOUND} ] && [ $(jq '.medium_vulnerabilities' ${GITHUB_WORKSPACE}/evaluations/${INPUT_IMAGE_NAME}/${INPUT_IMAGE_TAG}/evaluation_*.json) -ge 1 ]; then
    echo "At least one medium vulnerabilty found. Failing action."
    exit 1
elif [ ${INPUT_FAIL_IF_LOW_VULNERABILITIES_FOUND} ] && [ $(jq '.low_vulnerabilities' ${GITHUB_WORKSPACE}/evaluations/${INPUT_IMAGE_NAME}/${INPUT_IMAGE_TAG}/evaluation_*.json) -ge 1 ]; then
    echo "At least one low vulnerabilty found. Failing action."
    exit 1
elif [ ${INPUT_FAIL_IF_INFO_VULNERABILITIES_FOUND} ] && [ $(jq '.info_vulnerabilities' ${GITHUB_WORKSPACE}/evaluations/${INPUT_IMAGE_NAME}/${INPUT_IMAGE_TAG}/evaluation_*.json) -ge 1 ]; then
    echo "At least one info vulnerabilty found. Failing action."
    exit 1
else
    exit 0
fi