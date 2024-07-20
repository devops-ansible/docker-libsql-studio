#!/usr/bin/env bash
set -eu -o pipefail

# do startup things
/boot.sh

# run container command
exec "$@"
