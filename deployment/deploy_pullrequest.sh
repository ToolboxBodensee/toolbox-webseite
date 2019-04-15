#!/usr/bin/env bash
BUILD_DIR=$(lektor project-info | grep -oP '^Output: \K.+$')

echo $STAGING_DEPLOY_KEY | base64 -d -i > keyfile
chmod 700 keyfile
echo '|1|eFadWImHcM27D5kzrnNFqd7V44o=|s3KVjtYPKCvKOfFizEZaoi30GKA= ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBHehoCvGn4kphiEQlymFJXj1RL4YPYJE8N60lZaASOw81Bp7YLUJORY4KpSxPycR78qRVFi/2ekjdbl4lWyitCY=' >> $HOME/.ssh/known_hosts
echo uploading to tbp@${STAGING_HOST}:/var/www/${TRAVIS_PULL_REQUEST}
rsync -p --chmod=ug=rwX,o=rX --delete -e "ssh -i keyfile" -a ${BUILD_DIR}/ tbp@${STAGING_HOST}:/var/www/${TRAVIS_PULL_REQUEST}

rm keyfile

curl -X POST -H "Content-Type: application/json" -H "Authorization: token ${GITHUB_TOKEN}" \
    --data "{\"body\": \"View this PR on https://${TRAVIS_PULL_REQUEST}.${STAGING_HOST}\"}" \
    "https://api.github.com/repos/${TRAVIS_REPO_SLUG}/issues/${TRAVIS_PULL_REQUEST}/comments"

