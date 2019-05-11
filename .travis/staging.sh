output=$(lektor project-info --output-path)
cp -r $output staging
cd staging

# remove files over 100mb because github can´t handle them (only happens on one video)
find -size +100M | xargs rm

# push to staging repository
git init
git add .
git commit -m "staging commit"
git remote add origin https://$LEKTOR_STAGING_KEY@github.com/maxbachmann-staging/website-staging$(($TRAVIS_PULL_REQUEST % 5)).git
git push --force origin master
curl -H "Authorization: token $LEKTOR_STAGING_KEY" -X POST \
-d "{\"body\": \"View this PR on https://staging$(($TRAVIS_PULL_REQUEST % 5)).maxbachmann.de\"}" \
"https://api.github.com/repos/${TRAVIS_REPO_SLUG}/issues/${TRAVIS_PULL_REQUEST}/comments"
