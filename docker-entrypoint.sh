#!/bin/bash
set -o pipefail

# Set Lacework credentials as inline scanner environment variable
export LW_ACCOUNT_NAME=${INPUT_LW_ACCOUNT_NAME}
export LW_ACCESS_TOKEN=${INPUT_LW_ACCESS_TOKEN}

# Disable update prompt for lw-scanner if newer version is available unless explicitly set
export LW_SCANNER_DISABLE_UPDATES=${LW_SCANNER_DISABLE_UPDATES:-true}

# Add parameters based on arguments
export SCANNER_PARAMETERS=""
if [ ${INPUT_SCAN_LIBRARY_PACKAGES} = "false" ]; then
    export SCANNER_PARAMETERS="${SCANNER_PARAMETERS} --disable-library-package-scanning"
fi
if [ ${INPUT_SAVE_RESULTS_IN_LACEWORK} = "true" ]; then
    export SCANNER_PARAMETERS="${SCANNER_PARAMETERS} --save"
fi
if [ ${INPUT_SAVE_BUILD_REPORT} = "true" ]; then
    export SCANNER_PARAMETERS="${SCANNER_PARAMETERS} --html"
fi
if [ ! -z "${INPUT_BUILD_REPORT_FILE_NAME}" ]; then
    export SCANNER_PARAMETERS="${SCANNER_PARAMETERS} --html-file ${INPUT_BUILD_REPORT_FILE_NAME}"
fi
if [ ${INPUT_DEBUGGING} = "true" ]; then
    export SCANNER_PARAMETERS="${SCANNER_PARAMETERS} --debug"
fi
if [ ${INPUT_PRETTY_OUTPUT} = "true" ]; then
    export SCANNER_PARAMETERS="${SCANNER_PARAMETERS} --pretty"
fi
if [ ${INPUT_SIMPLE_OUTPUT} = "true" ]; then
    export SCANNER_PARAMETERS="${SCANNER_PARAMETERS} --simple"
fi
if [ ${INPUT_COLOR_OUTPUT} = "false" ] || [ "${INPUT_RESULTS_IN_GITHUB_SUMMARY}" = "true" ]; then
    export SCANNER_PARAMETERS="${SCANNER_PARAMETERS} --no-color"
fi
if [ ! -z "${INPUT_ADDITIONAL_PARAMETERS}" ]; then
    export SCANNER_PARAMETERS="${SCANNER_PARAMETERS} ${INPUT_ADDITIONAL_PARAMETERS}"
fi

# Remove old scanner evaluation, if cached somehow
rm ${GITHUB_WORKSPACE}/evaluations/${INPUT_IMAGE_NAME}/${INPUT_IMAGE_TAG}/evaluation_*.json &>/dev/null || true

/app/vulnerability/scanner/lacework/local-scanner/main/local-scanner.binary image evaluate ${INPUT_IMAGE_NAME} ${INPUT_IMAGE_TAG} \
    --build-plan ${GITHUB_REPOSITORY} \
    --build-id ${GITHUB_RUN_ID} \
    --data-directory ${GITHUB_WORKSPACE} \
    --policy \
    --fail-on-violation-exit-code 1 ${SCANNER_PARAMETERS} > results.stdout

export SCANNER_EXIT_CODE=$?

if [ "${INPUT_RESULTS_IN_GITHUB_SUMMARY}" = "true" ]; then
    echo "### Security Scan" >> $GITHUB_STEP_SUMMARY
    echo "<pre>" >> $GITHUB_STEP_SUMMARY
    printf '%s' "$(<results.stdout)" >> $GITHUB_STEP_SUMMARY
    echo "</pre>" >> $GITHUB_STEP_SUMMARY
fi

exit ${SCANNER_EXIT_CODE}
