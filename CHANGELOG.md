# v0.6.0
## Features
## Other Changes
* Update lw-scanner to version 0.2.5
* Change logic around scanning non-os packages by default
---

# v0.5.1
## Bug Fixes
* Reintroduce fail only if fixable vulnerabilities found
## Other Changes
* Update to action description
---

# v0.5.0
## Features
* Changed variables and how this action works to make the user expirence consitent across differnt CI platforms like Bitbucket, GitHub Actions, CircleCI, etc.
* Changed exit codes, action will fail with exit code 1 regardles of the severity of the vulnerability / policy.
* Fix evalution of found vulnerabilites as json schema changed.
* Remove option to only fail if fixable, as of today it is not mapped to specific severity. If this functionality is required it can be archived using the new policy feature.
---

# v0.4.0
## Features
* Add support for Lacework policy management feature (beta). To enable set `use_policy` parameter to `true`. As a result all `fail_...` parameters will be ignored.
* Added overview of exit codes
## Other Changes
* Updated Lacework Scanner to version [0.2.2](https://github.com/lacework/lacework-vulnerability-scanner/releases/tag/v0.2.2)
---

# v0.3.1
## Other Changes
* Updated Lacework Scanner to version [0.2.1](https://github.com/lacework/lacework-vulnerability-scanner/releases/tag/v0.2.1)
---

# v0.3.0
## Features
* Added option to change HTML report file name: `html_report_file_name`
## Breaking changes
* arguments `scan_library_packages` and `save_results_in_lacework` are deprecated and have been replaced with the offical environment variables  `LW_SCANNER_SCAN_LIBRARY_PACKAGES` and `LW_SCANNER_SAVE_RESULTS`: <https://support.lacework.com/hc/en-us/articles/4403780976275-Integrate-the-Lacework-Inline-Scanner-with-CI-Pipelines#configuration-options-for-image-evaluate>
* `save_build_report` arugment name changed to `save_html_report`
---
