#!/bin/sh

# Variables rerquired to configure the scan
export LW_IMAGE_NAME=${1}
export LW_IMAGE_TAG=${2}
export GHA_REPO=${3}
export GHA_RUNID=${4}
export LW_FAIL_CRITICAL=${5}
export LW_FAIL_HIGH_=${6}
export LW_FAIL_MEDIUM=${7}
export LW_FAIL_LOW=${8}
export LW_FAIL_INFO=${9}
export LW_FAIL_FIXABLE=${10}

# Run scanner
lw-scanner evaluate ${LW_IMAGE_NAME} ${LW_IMAGE_TAG} --build-plan ${GHA_REPO} --build-id ${GHA_RUNID} --data-directory /root

# Cecking results
if [ ${LW_FAIL_FIXABLE} ] && [ $(jq '.fixable_vulnerabilities' /root/evaluations/${LW_IMAGE_NAME}/${LW_IMAGE_TAG}/evaluation_*.json) -ge 1 ]; then
    echo "At least one fixable vulnerabilty found. Failing action."
    exit 1
elif [ ${LW_FAIL_CRITICAL} ] && [ $(jq '.critical_vulnerabilities' /root/evaluations/${LW_IMAGE_NAME}/${LW_IMAGE_TAG}/evaluation_*.json) -ge 1 ]; then
    echo "At least one critical vulnerabilty found. Failing action."
    exit 1
elif [ ${LW_FAIL_HIGH} ] && [ $(jq '.high_vulnerabilities' /root/evaluations/${LW_IMAGE_NAME}/${LW_IMAGE_TAG}/evaluation_*.json) -ge 1 ]; then
    echo "At least one high vulnerabilty found. Failing action."
    exit 1
elif [ ${LW_FAIL_MEDIUM} ] && [ $(jq '.medium_vulnerabilities' /root/evaluations/${LW_IMAGE_NAME}/${LW_IMAGE_TAG}/evaluation_*.json) -ge 1 ]; then
    echo "At least one medium vulnerabilty found. Failing action."
    exit 1
elif [ ${LW_FAIL_LOW} ] && [ $(jq '.low_vulnerabilities' /root/evaluations/${LW_IMAGE_NAME}/${LW_IMAGE_TAG}/evaluation_*.json) -ge 1 ]; then
    echo "At least one low vulnerabilty found. Failing action."
    exit 1
elif [ ${LW_FAIL_INFO} ] && [ $(jq '.info_vulnerabilities' /root/evaluations/${LW_IMAGE_NAME}/${LW_IMAGE_TAG}/evaluation_*.json) -ge 1 ]; then
    echo "At least one info vulnerabilty found. Failing action."
    exit 1
else
    exit 0
fi