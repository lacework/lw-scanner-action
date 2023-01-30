#!/bin/bash
#
# Name::        version-bump.sh
# Description:: Use this script to bump the version of the lw-scanner
#               after a new release of the docker image
# Author::      Salim Afiune Maya (<afiune@lacework.net>)
#
set -eou pipefail

readonly project_name=lw-scanner-action
readonly org_name=lacework
readonly git_user="Lacework Inc."
readonly git_email="tech-ally@lacework.net"

if [[ "${1:-}" == "" ]]; then
  echo "ERROR: Unable to update version. Please provide the new version to update."
elif [[ "${1:-}" == "undefined" ]]; then
  echo "ERROR: SCANNER_VERSION variable not passed to codefresh job. Please check the pipeline."
  exit 1
fi

_scanner_version=$1

# Update Dockerfile
echo "--> Updating lw-scanner version to ${_scanner_version}"
sed -i 's/:.*$/:'${_scanner_version}'/' Dockerfile

# Configure Git if running in CI
if [ "${CI:-}" != "" ]; then
  git config --global user.email $git_email
  git config --global user.name $git_user
  git config --global user.signingkey $GPG_SIGNING_KEY
fi

# Create a branch and commit changes
git checkout -B version-bump
git commit -sS -am "chore(deps): lw-scanner to version ${_scanner_version}"
git push origin version-bump -f

# Open Pull Request
_body="/tmp/pr.json"
_pr="/tmp/pr.out"
cat <<EOF > $_body
{
  "base": "main",
  "head": "version-bump",
  "title": "chore(deps): lw-scanner to version ${_scanner_version}",
  "body": "Automated update, merge if pipeline is green."
}
EOF
curl -XPOST -H "Authorization: token $GITHUB_TOKEN" --data  "@$_body" \
        https://api.github.com/repos/${org_name}/${project_name}/pulls > $_pr
_pr_url=$(jq .html_url $_pr)
echo ""
echo "--> It is time to for review!"
echo "    $_pr_url"
