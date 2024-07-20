#!/usr/bin/env bash
# this script performs the basic installation as root

set -eu -o pipefail

# check that this script is run by root
if [ "$( id -u )" -ne 0 ]; then
    echo "This script must be run by root" >&2
    exit 1
fi

# change directory to current script location
cd "$( dirname "${0}" )"

# install system packages
apt-get update
apt-get upgrade -y

# add application user
useradd --system --shell "/bin/bash" --home-dir "${APP_ROOT}" "${APP_USER}"

# ensure CAs installed
update-ca-certificates

# make empty app / user home directory
mkdir "${APP_ROOT}"
chown -R "${APP_USER}" "${APP_ROOT}"

# call user specific setup
su "${APP_USER}" "$( pwd )/userinstall.sh"

# perform installation cleanup
apt-get -y clean
apt-get -y autoclean
apt-get -y autoremove
rm -r /var/lib/apt/lists/*

# place entrypoint and bootup scripts
mv ./boot* /
mv ./entrypoint.sh /usr/local/bin/entrypoint

# clean up installation files
CURPATH="$( pwd )"
cd /
rm -rf "${CURPATH}"
