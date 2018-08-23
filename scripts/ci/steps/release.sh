#!/usr/bin/env bash

[ -n "$DEBUG" ] && set -x
set -e
set -o pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$( cd "$SCRIPT_DIR/../../.." && pwd )"

cd "$PROJECT_DIR"

if [[ $(git log -1 --pretty=%B) == *Bump to* ]]; then
  echo "Last commit was a release commit, ignoring."
  exit
fi

set +e
openssl aes-256-cbc \
    -d \
    -in ./.circleci/gpg.private.enc -k "${ENCRYPTION_PASSPHRASE}" | gpg --import -
set -e

git crypt unlock

git config --global user.email "circleci@infrablocks.io"
git config --global user.name "Circle CI"

mkdir -p ~/.gem
cp config/secrets/rubygems/credentials ~/.gem/credentials
chmod 0600 ~/.gem/credentials

./go publish:release

git push