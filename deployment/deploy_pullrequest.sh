#!/usr/bin/env bash
BUILD_DIR=$(lektor project-info | grep -oP '^Output: \K.+$')

echo $STAGING_DEPLOY_KEY | base64 -d -i > keyfile
chmod 700 keyfile
echo uploading to tbp@${STAGING_HOST}:/var/www/${TRAVIS_PULL_REQUEST}
rsync -p --chmod=ug=rwX,o=rX -e "ssh -i keyfile" -a ${BUILD_DIR}/ tbp@${STAGING_HOST}:/var/www/${TRAVIS_PULL_REQUEST}

rm keyfile

curl -X POST -H "Content-Type: application/json" -H "Authorization: token ${GITHUB_TOKEN}" \
    --data "{\"body\": \"View this PR on https://${TRAVIS_PULL_REQUEST}.${STAGING_HOST}\"}" \
    "https://api.github.com/repos/${TRAVIS_REPO_SLUG}/issues/${TRAVIS_PULL_REQUEST}/comments"

