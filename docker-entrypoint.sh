#!/bundle/busybox sh
set -eu  # -o pipefail isn't supported by BusyBox sh, but -e + -u = good practice

# Provide safe defaults for environment variables
: "${INPUT_LW_ACCOUNT_NAME:=}"
: "${INPUT_LW_ACCESS_TOKEN:=}"
: "${INPUT_IMAGE_NAME:=}"
: "${INPUT_IMAGE_TAG:=}"
: "${INPUT_SCAN_LIBRARY_PACKAGES:=true}"
: "${INPUT_SAVE_RESULTS_IN_LACEWORK:=false}"
: "${INPUT_SAVE_BUILD_REPORT:=false}"
: "${INPUT_BUILD_REPORT_FILE_NAME:=}"
: "${INPUT_DEBUGGING:=false}"
: "${INPUT_PRETTY_OUTPUT:=true}"
: "${INPUT_SIMPLE_OUTPUT:=true}"
: "${INPUT_COLOR_OUTPUT:=true}"
: "${INPUT_RESULTS_IN_GITHUB_SUMMARY:=true}"
: "${INPUT_ADDITIONAL_PARAMETERS:=}"
: "${LW_SCANNER_DISABLE_UPDATES:=true}"

# Set Lacework credentials as inline scanner environment variable
export LW_ACCOUNT_NAME="${INPUT_LW_ACCOUNT_NAME}"
export LW_ACCESS_TOKEN="${INPUT_LW_ACCESS_TOKEN}"
export LW_SCANNER_DISABLE_UPDATES

# Add parameters based on arguments
SCANNER_PARAMETERS=""
if [ "$INPUT_SCAN_LIBRARY_PACKAGES" = "false" ]; then
    SCANNER_PARAMETERS="$SCANNER_PARAMETERS --disable-library-package-scanning"
fi
if [ "$INPUT_SAVE_RESULTS_IN_LACEWORK" = "true" ]; then
    SCANNER_PARAMETERS="$SCANNER_PARAMETERS --save"
fi
if [ "$INPUT_SAVE_BUILD_REPORT" = "true" ]; then
    SCANNER_PARAMETERS="$SCANNER_PARAMETERS --html"
fi
if [ -n "$INPUT_BUILD_REPORT_FILE_NAME" ]; then
    SCANNER_PARAMETERS="$SCANNER_PARAMETERS --html-file $INPUT_BUILD_REPORT_FILE_NAME"
fi
if [ "$INPUT_DEBUGGING" = "true" ]; then
    SCANNER_PARAMETERS="$SCANNER_PARAMETERS --debug"
fi
if [ "$INPUT_PRETTY_OUTPUT" = "true" ]; then
    SCANNER_PARAMETERS="$SCANNER_PARAMETERS --pretty"
fi
if [ "$INPUT_SIMPLE_OUTPUT" = "true" ]; then
    SCANNER_PARAMETERS="$SCANNER_PARAMETERS --simple"
fi
# If color is false or we want to print results in a GH summary, disable color
if [ "$INPUT_COLOR_OUTPUT" = "false" ] || [ "$INPUT_RESULTS_IN_GITHUB_SUMMARY" = "true" ]; then
    SCANNER_PARAMETERS="$SCANNER_PARAMETERS --no-color"
fi
if [ -n "$INPUT_ADDITIONAL_PARAMETERS" ]; then
    SCANNER_PARAMETERS="$SCANNER_PARAMETERS $INPUT_ADDITIONAL_PARAMETERS"
fi

# Remove old scanner evaluation files, if they exist
rm -f "${GITHUB_WORKSPACE}/evaluations/${INPUT_IMAGE_NAME}/${INPUT_IMAGE_TAG}/evaluation_"*.json || true

# Fix ownership so the non-root user can access the workspace
chown -R 10001:10001 "$GITHUB_WORKSPACE"

# Build the scanner command
SCANNER_CMD="/app/vulnerability/scanner/lacework/local-scanner/main/local-scanner.binary \
    image evaluate $INPUT_IMAGE_NAME $INPUT_IMAGE_TAG \
    --build-plan ${GITHUB_REPOSITORY:-unknown} \
    --build-id ${GITHUB_RUN_ID:-0} \
    --data-directory $GITHUB_WORKSPACE \
    --policy \
    --fail-on-violation-exit-code 1 $SCANNER_PARAMETERS"

# Run as non-root (via su-exec)
echo "Running as non-root user 'scanner'..."
su-exec scanner:scanner sh -c "$SCANNER_CMD" > results.stdout
SCANNER_EXIT_CODE=$?

# Print results in GH summary, if desired
if [ "$INPUT_RESULTS_IN_GITHUB_SUMMARY" = "true" ]; then
    echo "### Security Scan" >> "$GITHUB_STEP_SUMMARY"
    echo "<pre>" >> "$GITHUB_STEP_SUMMARY"
    cat results.stdout >> "$GITHUB_STEP_SUMMARY"
    echo "</pre>" >> "$GITHUB_STEP_SUMMARY"
fi

exit "$SCANNER_EXIT_CODE"

