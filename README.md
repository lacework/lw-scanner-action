# lw-scanner-action - Lacework Inline Scanner GitHub Action

This is an example on how the Lacework scanner can be used as GitHub action. This is provided as a technical demostration without any guarantees. Also, this is not an official Lacework project.

## What's new

### v0.3.0

* Breaking changes
  * arguments `scan_library_packages` and `save_results_in_lacework` are deprecated and have been repleaced with the offical environment variables  `LW_SCANNER_SCAN_LIBRARY_PACKAGES` and `LW_SCANNER_SAVE_RESULTS`: <https://support.lacework.com/hc/en-us/articles/4403780976275-Integrate-the-Lacework-Inline-Scanner-with-CI-Pipelines#configuration-options-for-image-evaluate>
  * `save_build_report` arugment name changed to `save_html_report``
* Added option to change HTML report file name: `html_report_file_name`

## Usage

```yaml
jobs:
    build:
        # ...
        steps:
            - uses: timarenz/lw-scanner-action:v0.3.0
              name: Scan container images for vulnerabitilies using Lacework
              env:
                # Set Lacework account name and access token as environment variable. This can also be done on the job level.
                # More information about those variables can be found in the documentation: https://support.lacework.com/hc/en-us/articles/1500001777821-Integrate-Inline-Scanner#configuration-commands
                LW_ACCOUNT_NAME: ${{ secrets.LW_ACCOUNT_NAME }} 
                LW_ACCESS_TOKEN: ${{ secrets.LW_ACCESS_TOKEN }}
                # When set to true, this will save evaluation results to the Lacework Console (default is false).
                LW_SCANNER_SAVE_RESULTS: false
                # When set to true, this will evaluate the image for non-OS library packages (default is false).
                LW_SCANNER_SCAN_LIBRARY_PACKAGES: false
                # When set to true, this will disable the update prompt at the end of the output if there is a new version of the Lacework scanner available (default is true).
                LW_SCANNER_DISABLE_UPDATES: true
              with:
                # Name of the image you want to scan, examples: nginx, ghcr.io/timarenz/lw-scanner, codercom/code-server, node
                image_name: node
                # Tag of the image you want to scan, for example, latest, v2.0.1, 3.11.1, 12.18.2-alpine
                image_tag: 12.18.2-alpine
                # Fail this action if critical vulnerabilities found (default is true).
                fail_if_critical_vulnerabilities_found: true
                # Fail this action if high vulnerabilities found (default is true).
                fail_if_high_vulnerabilities_found: true
                # Fail this action if medium vulnerabilities found (default is true).
                fail_if_medium_vulnerabilities_found: true
                # Fail this action if low vulnerabilities found (default is false).
                fail_if_low_vulnerabilities_found: false
                # Fail this action if info vulnerabilities found (default is false).
                fail_if_info_vulnerabilities_found: false
                # Fail this action only if fixable vulnerabilities found (default is false).
                fail_only_if_vulnerabilities_fixable: true
                # Save HTML report of the vulnerability scan as artifact (default is false).
                save_html_report: false
                # Customize file name of the HTML report (default is OS_TYPE-IMAGE_DIGEST_SHA256.html)
                html_report_file_name: myreport.html
```