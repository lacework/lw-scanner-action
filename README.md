# lw-scanner-action - Lacework Inline Scanner GitHub Action

This is an example on how the Lacework scanner can be used as GitHub action. This is provided as a technical demostration without any guarantees. Also, this is not an official Lacework project.

## What's new

### v0.5.1
* Reintroduce fail only if fixable vulnerabilities found
* Update to action description

### v0.5.0
* Changed variables and how this action works to make the user expirence consitent across differnt CI platforms like Bitbucket, GitHub Actions, CircleCI, etc.
* Changed exit codes, action will fail with exit code 1 regardles of the severity of the vulnerability / policy.
* Fix evalution of found vulnerabilites as json schema changed.
* Remove option to only fail if fixable, as of today it is not mapped to specific severity. If this functionality is required it can be archived using the new policy feature.

### v0.4.0
* Updated Lacework Scanner to version [0.2.2](https://github.com/lacework/lacework-vulnerability-scanner/releases/tag/v0.2.2)
* Add support for Lacework policy management feature (beta). To enable set `use_policy` parameter to `true`. As a result all `fail_...` parameters will be ignored.
* Added overview of exit codes

### v0.3.1
* Updated Lacework Scanner to version [0.2.1](https://github.com/lacework/lacework-vulnerability-scanner/releases/tag/v0.2.1)

### v0.3.0

* Breaking changes
  * arguments `scan_library_packages` and `save_results_in_lacework` are deprecated and have been replaced with the offical environment variables  `LW_SCANNER_SCAN_LIBRARY_PACKAGES` and `LW_SCANNER_SAVE_RESULTS`: <https://support.lacework.com/hc/en-us/articles/4403780976275-Integrate-the-Lacework-Inline-Scanner-with-CI-Pipelines#configuration-options-for-image-evaluate>
  * `save_build_report` arugment name changed to `save_html_report`
* Added option to change HTML report file name: `html_report_file_name`

## Usage

```yaml
jobs:
    build:
        # ...
        steps:
            - uses: timarenz/lw-scanner-action:v0.5.1
              name: Scan container images for vulnerabitilies using Lacework
              with:
                # Your Lacework account name. For example, if your login URL is mycompany.lacework.net, the account name is mycompany.
                LW_ACCOUNT_NAME: ${{ secrets.LW_ACCOUNT_NAME }} 
                # Authorization token. Copy and paste the token from the inline scanner integration created in the Lacework console.
                LW_ACCESS_TOKEN: ${{ secrets.LW_ACCESS_TOKEN }}
                # Name of the container image you want to scan, for example, `node`.
                IMAGE_NAME: ghcr.io/timarenz/vulnerable-container
                # Tag of the container image you want to scan, for example, `12.18.2-alpine`.
                IMAGE_TAG: v0.0.1
                # Also scan software packages. (Default: true)
                SCAN_LIBRARY_PACKAGES: true
                # Save results to Lacework. (Default: false)
                SAVE_RESULTS_IN_LACEWORK: false
                # Saves the evaluation report as a local HTML file. (Default: false)
                SAVE_BUILD_REPORT: true
                # Specify custom file name for the HTML evalutation report, by default the name is OS_TYPE-IMAGE_DIGEST_SHA256.html.
                BUILD_REPORT_FILE_NAME: myreport.html
                # Fail the build of vulnerabilities are discovered according to the threshold. (Default: true)
                FAIL_BUILD: true
                # Severity threshold that will fail the build: info, low, medium, high, critical, fixable. (Default: medium)
                SEVERITY_THRESHOLD: medium
                # Use the Lacework policy managed feature (beta). If enabled this overwrites `FAIL_BUILD`and `SEVERITY_THRESHOLD`. (Default: false)
                USE_POLICY: false
```

## Exit codes

With version `0.5.0` the only exit code used is `1` regardless of the severity of the vulnerability / violation.

The following exit codes are introduced with version 0.4.0. Prior version all fail with exit code `1` on violations.
Exit codes `11-16` are used if `use_policy` is enabled. If not, error codes `21-22` are used.

| Exit code | Description                        |
|----------:|------------------------------------|
| 0         | Scan successful, no violations     |
| 1         | General error, scan not succesful  |
| 11        | General policy violation           |
| 12        | Critical severity policy violation |
| 13        | High severity policy violation     |
| 14        | Medium severity policy violation   |
| 15        | Low severity policy violation      |
| 16        | Info severity policy violation     |
| 21        | Fixable vulnerability found        |
| 22        | Critical vulnerability found       |
| 23        | High vulnerability found           |
| 24        | Medium vulnerability found         |
| 25        | Low vulnerability found            |
| 26        | Info vulnerability found           |
