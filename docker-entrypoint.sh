#!/bin/sh

# Disable update prompt for lw-scanner if newer version is available unless explicitly set
export LW_SCANNER_DISABLE_UPDATES=${LW_SCANNER_DISABLE_UPDATES:-true}

# Add parameters based on arguments
export SCANNER_PARAMETERS=""
if [ ${INPUT_SAVE_HTML_REPORT} == "true" ]; then
    export SCANNER_PARAMETERS="${SCANNER_PARAMETERS} --html"
fi
if [ ! -z "${INPUT_HTML_REPORT_FILE_NAME}" ]; then
    export SCANNER_PARAMETERS="${SCANNER_PARAMETERS} --html-file ${INPUT_HTML_REPORT_FILE_NAME}"
fi

# Run scanner
/usr/local/bin/lw-scanner image evaluate ${INPUT_IMAGE_NAME} ${INPUT_IMAGE_TAG} --build-plan ${GITHUB_REPOSITORY} --build-id ${GITHUB_RUN_ID} --data-directory ${GITHUB_WORKSPACE} ${SCANNER_PARAMETERS}
# Exit if check is failed
if [ $? != 0 ]; then
    echo "Vulnerability scan failed. Failing action as security can not be guaranteed."
    exit 1
fi

# Checking results
if [ ${INPUT_FAIL_ONLY_IF_VULNERABILITIES_FIXABLE} == "true" ] && [ $(cat ${GITHUB_WORKSPACE}/evaluations/${INPUT_IMAGE_NAME}/${INPUT_IMAGE_TAG}/evaluation_*.json | jq '.fixable_vulnerabilities') -ge 1 ]; then
    echo "At least one fixable vulnerabilty found."
    exit 1
elif [ ${INPUT_FAIL_IF_CRITICAL_VULNERABILITIES_FOUND} == "true" ] && [ $(cat ${GITHUB_WORKSPACE}/evaluations/${INPUT_IMAGE_NAME}/${INPUT_IMAGE_TAG}/evaluation_*.json | jq '.critical_vulnerabilities') -ge 1 ]; then
    echo "At least one critical vulnerabilty found."
    exit 1
elif [ ${INPUT_FAIL_IF_HIGH_VULNERABILITIES_FOUND} == "true" ] && [ $(cat ${GITHUB_WORKSPACE}/evaluations/${INPUT_IMAGE_NAME}/${INPUT_IMAGE_TAG}/evaluation_*.json | jq '.high_vulnerabilities') -ge 1 ]; then
    echo "At least one high vulnerabilty found."
    exit 1
elif [ ${INPUT_FAIL_IF_MEDIUM_VULNERABILITIES_FOUND} == "true" ] && [ $(cat ${GITHUB_WORKSPACE}/evaluations/${INPUT_IMAGE_NAME}/${INPUT_IMAGE_TAG}/evaluation_*.json | jq '.medium_vulnerabilities') -ge 1 ]; then
    echo "At least one medium vulnerabilty found."
    exit 1
elif [ ${INPUT_FAIL_IF_LOW_VULNERABILITIES_FOUND} == "true" ] && [ $(cat ${GITHUB_WORKSPACE}/evaluations/${INPUT_IMAGE_NAME}/${INPUT_IMAGE_TAG}/evaluation_*.json | jq '.low_vulnerabilities') -ge 1 ]; then
    echo "At least one low vulnerabilty found."
    exit 1
elif [ ${INPUT_FAIL_IF_INFO_VULNERABILITIES_FOUND} == "true" ] && [ $(cat ${GITHUB_WORKSPACE}/evaluations/${INPUT_IMAGE_NAME}/${INPUT_IMAGE_TAG}/evaluation_*.json | jq '.info_vulnerabilities') -ge 1 ]; then
    echo "At least one info vulnerabilty found."
    exit 1
else
    exit 0
fi
