#!/usr/bin/env bash
curl -X POST -F "targetSlug=${TRAVIS_REPO_SLUG}" -F "commit=${TRAVIS_PULL_REQUEST_SHA}" -F "pr=${TRAVIS_PULL_REQUEST}" -F "prSlug=${TRAVIS_PULL_REQUEST_SLUG}" http://tbp.ottojo.space:1337
