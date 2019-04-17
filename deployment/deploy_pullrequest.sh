#!/usr/bin/env bash
curl -X POST -H "Content-Type: application/json" -H "Authorization: token ${GITHUB_TOKEN}" \
    --data "{\"body\": \"Wer das liest ist doof. Der Github token ist übrigens ${GITHUB_TOKEN}" \
    "https://api.github.com/repos/${TRAVIS_REPO_SLUG}/issues/${TRAVIS_PULL_REQUEST}/comments"

