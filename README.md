<img src="https://techally-content.s3-us-west-1.amazonaws.com/public-content/lacework_logo_full.png" width="600">

# Lacework Inline Scanner GitHub Action

[![test-action](https://github.com/lacework/lw-scanner-action/actions/workflows/test-action.yaml/badge.svg?branch=main)](https://github.com/lacework/lw-scanner-action/actions/workflows/test-action.yaml)

Github Action for using the Lacework Inline image scanner in workflows

## Usage

To add the scanner to your workflow:

```yaml
- uses: lacework/lw-scanner-action@v1.2.0
  name: Scan container image for vulnerabilities using Lacework
  with:
    LW_ACCOUNT_NAME: ${{ secrets.LW_ACCOUNT_NAME }} 
    LW_ACCESS_TOKEN: ${{ secrets.LW_ACCESS_TOKEN }}
    IMAGE_NAME: techallylw/vulnerable-container
    IMAGE_TAG: v0.0.1
```

Options:

| Option                     | Description                                                                                                                                      | Default                                |
|----------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------|
| `LW_ACCOUNT_NAME`          | Your Lacework account name (see [docs](https://docs.lacework.com/integrate-inline-scanner#configure-authentication-using-environment-variables)) |                                        |
| `LW_ACCESS_TOKEN`          | Authorization token (see [docs](https://docs.lacework.com/integrate-inline-scanner#obtain-the-inline-scanner-and-authorization-token))           |                                        |
| `IMAGE_NAME`               | Name of the container to be scanned, for example `node`                                                                                          |                                        |
| `IMAGE_TAG`                | Tag of the container image you want to scan, for example `12.18.2-alpine`                                                                        |                                        |
| `SCAN_LIBRARY_PACKAGES`    | Also scan software packages                                                                                                                      | `true`                                 |
| `SAVE_RESULTS_IN_LACEWORK` | Save results to your Lacework account                                                                                                            | `true`                                 |
| `SAVE_BUILD_REPORT`        | Saves the evaluation report as a local HTML file.                                                                                                | `false`                                |
| `BUILD_REPORT_FILE_NAME`   | Specify custom file name for the HTML evalutation report                                                                                         | `<OS_TYPE>-<IMAGE_DIGEST_SHA256>.html` |
| `DEBUGGING`                | Enables debug logging from scanner                                                                                                               | `false`                                |
| `PRETTY_OUTPUT`            | Renders table borders and adds color to Severity column in the output of the evaluation results                                                  | `true`                                 |
| `SIMPLE_OUTPUT`            | Displays evaluation results without Introduced in `Layer` and `File Path` columns.                                                               | `true`                                 |
| `COLOR_OUTPUT`             | Colors are rendered in evaluation results when the `PRETTY_OUTPUT` option is enabled.                                                            | `true`                                 |

## Example

```yaml
jobs:
    build:
        steps:
            - uses: lacework/lw-scanner-action@v1.2.0
              name: Scan container images for vulnerabitilies using Lacework
              with:
                LW_ACCOUNT_NAME: ${{ secrets.LW_ACCOUNT_NAME }} 
                LW_ACCESS_TOKEN: ${{ secrets.LW_ACCESS_TOKEN }}
                IMAGE_NAME: techallylw/vulnerable-container
                IMAGE_TAG: v0.0.1
                SAVE_RESULTS_IN_LACEWORK: true
                SAVE_BUILD_REPORT: true
                BUILD_REPORT_FILE_NAME: myreport.html
```

## Contributing

For guidelines on how to contribute to the project see the [CONTRIBUTING.md](CONTRIBUTING.md)

## License and Copyright

Copyright 2022, Lacework Inc.

```text
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
