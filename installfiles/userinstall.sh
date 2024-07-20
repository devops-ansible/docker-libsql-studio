#!/usr/bin/env bash
# this script performs the basic installation as application user

set -eu -o pipefail

# check if UID of ${APP_USER} is calling this script
if [ "$( id -u )" -ne "$( id -u "${APP_USER}" )" ]; then
    echo "This script must be run by ${APP_USER}" >&2
    exit 1
fi

# install pnpm
npm install -g pnpm

# install actual version of application
git clone https://github.com/invisal/libsql-studio.git "${APP_ROOT}"
cd "${APP_ROOT}"
git checkout "${APP_VERSION}"
pnpm install
npm install codemirror/view
pnpm build
