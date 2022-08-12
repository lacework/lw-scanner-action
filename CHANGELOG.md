# v1.1.1

## Bug Fixes
* fix: release script (#24) (Salim Afiune)([e0adb9c](https://github.com/lacework/lw-scanner-action/commit/e0adb9c68866d6ee48789bea1a11f963b9749a8d))
* fix: change debug to argument instead of variable (#20) (Andre Elizondo)([3393a74](https://github.com/lacework/lw-scanner-action/commit/3393a74db7bf16a93f604dbe6b4253e2e68eac4d))
## Other Changes
* ci: fix release script to fint latest version (#22) (Salim Afiune)([4027f36](https://github.com/lacework/lw-scanner-action/commit/4027f36074bb294f0b61d4ccf674feb6bf34fdb8))
* ci: fix bug that avoids automatic version bump (Salim Afiune Maya)([9eb8578](https://github.com/lacework/lw-scanner-action/commit/9eb85783118bea3bd4b35e3a7858d27e71685c0c))
* ci: version bump to v1.1.1 (Salim Afiune Maya)([0657580](https://github.com/lacework/lw-scanner-action/commit/0657580f91858b945652b6c1752f77d16746abe9))
---
# v1.1.0

## Features
* feat: add debug option to scanner definition (#17) (Andre Elizondo)([0362a01](https://github.com/lacework/lw-scanner-action/commit/0362a01f29d1941114ab915eccb296c1cd249c69))
## Refactor
* refactor(v1.0.0): Use native policies from the platform (#9) (Salim Afiune)([3fc0763](https://github.com/lacework/lw-scanner-action/commit/3fc076363453880f21ef59b0a7a2f83f124e0ab2))
## Other Changes
* chore: update scanner version to 0.7.0 (#15) (Tim Arenz)([3826818](https://github.com/lacework/lw-scanner-action/commit/382681814f446aa932ff4247ca0d871ea1e8cf4d))
* chore: update README.md (#12) (Salim Afiune)([4d3222d](https://github.com/lacework/lw-scanner-action/commit/4d3222d9895a5aca6412a2919c1b8d3a48467dd0))
* ci: fix test-action job (#13) (Salim Afiune)([315fc0b](https://github.com/lacework/lw-scanner-action/commit/315fc0bcbbdeac239783afe93fa44af4d3af54da))
* ci: version bump to v0.7.2-dev (Lacework)([32292e5](https://github.com/lacework/lw-scanner-action/commit/32292e503b37817e7e78a13ad1d66a5668c2446a))
---
# v1.0.1

## Other Changes
* chore: update scanner version to 0.7.0 (#15) (Tim Arenz)([3826818](https://github.com/lacework/lw-scanner-action/commit/382681814f446aa932ff4247ca0d871ea1e8cf4d))
* chore: update README.md (#12) (Salim Afiune)([4d3222d](https://github.com/lacework/lw-scanner-action/commit/4d3222d9895a5aca6412a2919c1b8d3a48467dd0))
* ci: fix test-action job (#13) (Salim Afiune)([315fc0b](https://github.com/lacework/lw-scanner-action/commit/315fc0bcbbdeac239783afe93fa44af4d3af54da))
---
# v1.0.0

## Refactor
* refactor(v1.0.0): Use native policies from the platform (#9) (Salim Afiune)([3fc0763](https://github.com/lacework/lw-scanner-action/commit/3fc076363453880f21ef59b0a7a2f83f124e0ab2))
## Other Changes
* ci: version bump to v0.7.2-dev (Lacework)([32292e5](https://github.com/lacework/lw-scanner-action/commit/32292e503b37817e7e78a13ad1d66a5668c2446a))
---
# v0.7.1

## Bug Fixes
* fix(jq): binary missing and logic corrections (#7) (Tim Arenz)([0c6d283](https://github.com/lacework/lw-scanner-action/commit/0c6d283089626713a4c86decae2793183fd84803))
## Other Changes
* ci: version bump to v0.7.1-dev (Lacework)([a49f3c8](https://github.com/lacework/lw-scanner-action/commit/a49f3c85912e285410771cbbb5fcfdd4552009bf))
---
# v0.7.0

## Refactor
* refactor: update lw-scanner docker image (Salim Afiune Maya)([44a662b](https://github.com/lacework/lw-scanner-action/commit/44a662bcc4af2069129ec00ea3a2f0852b666002))
## Other Changes
* chore: add release tooling to project (ipcrm)([ec203ad](https://github.com/lacework/lw-scanner-action/commit/ec203adfa2ec16b4768832ba6b3579b39b2721af))
* chore(docs): update documentation and reorg after org move (ipcrm)([8a11419](https://github.com/lacework/lw-scanner-action/commit/8a114198c7278d6f4f999ecdb4d0dd559c9e194c))
* ci: init RELEASE_NOTES.md (#6) (Salim Afiune)([6c01578](https://github.com/lacework/lw-scanner-action/commit/6c0157810ac82ab8a73890e7db96d645aa1169b2))
* ci: add nightly builds (Salim Afiune Maya)([e5b0c8d](https://github.com/lacework/lw-scanner-action/commit/e5b0c8d1f9ac0b5418ac23b53e49999bf6ff96f1))
---
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
