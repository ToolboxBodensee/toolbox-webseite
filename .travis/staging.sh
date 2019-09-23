#!/bin/bash
output=$(lektor project-info --output-path)
cp -r $output staging
cd staging

# remove files over 100mb because github can´t handle them (only happens on one video)
find -size +100M | xargs rm

# push to staging repository
git init
git add --all
git commit -m "staging commit \#$TRAVIS_PULL_REQUEST"
git remote add origin https://$LEKTOR_STAGING_KEY@github.com/maxbachmann-staging/website-staging$(($TRAVIS_PULL_REQUEST % 5 + 1)).git
git push --force origin master
curl -H "Authorization: token $LEKTOR_STAGING_KEY" -X POST \
-d "{\"body\": \"**View this PR on https://staging$(($TRAVIS_PULL_REQUEST % 5 + 1)).maxbachmann.de** <br/> *The sources with scss compiled to minified css and minified js can be found at https://github.com/maxbachmann-staging/website-staging$(($TRAVIS_PULL_REQUEST % 5 + 1))* \"}" \
"https://api.github.com/repos/${TRAVIS_REPO_SLUG}/issues/${TRAVIS_PULL_REQUEST}/comments"
