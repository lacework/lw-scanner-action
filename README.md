# lw-scanner-action - Lacework Inline Scanner GitHub Action

This is an example on how the Lacework scanner can be used as GitHub action. This is provided as a technical demostration without any garantues. Also, this is not an official Lacework project.

## Example usage

```yaml
jobs:
    build:
        # ...
        steps:
            - name: Scan container images for vulnerabitilies using Lacework
              uses: timarenz/lw-scanner-action:v0.0.1
              env:
                LW_ACCOUNT_NAME: ${{ secrets.LW_ACCOUNT_NAME }} 
                LW_ACCESS_TOKEN: ${{ secrets.LW_ACCESS_TOKEN }}
              with:
                image_name: node
                image_tag: 12.18.2-alpine
                fail_if_critical_vulnerabilities_found: true
                fail_only_if_vulnerabilities_fixable: true

```