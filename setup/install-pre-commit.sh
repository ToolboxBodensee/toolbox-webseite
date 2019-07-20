
#!/bin/sh
# This script installs a pre-commit hook to enforce the correct use of spaces and tabs for this project

GIT_DIR=`git rev-parse --git-common-dir 2> /dev/null`

if [ "$GIT_DIR" == "" ]; then
  echo "This does not appear to be a git repo."
  exit 1
fi

if [ -f "$GIT_DIR/hooks/pre-commit" ]; then
  rm $GIT_DIR/hooks/pre-commit
fi

cp $GIT_DIR/../setup/pre-commit.hook $GIT_DIR/hooks/pre-commit

echo
echo "You're all set! Happy hacking!"

exit 0
