#!/usr/bin/env bash

set -eu -o pipefail

###
## additional bootup things
###

bootDir="/boot.d/"
echo "Doing additional bootup things from \`${bootDir}\` ..."
cd "${bootDir}"

# find all (sub(sub(...))directories of the /boot.d/ folder to be
# checked for executable Shell (!) scripts.
#
# `\( ! -name . \)` would exclude current directory
# find . -type d \( ! -name . \) -exec bash -c "cd '{}' && pwd" \;

# shellcheck disable=SC2156
dirs=$( find . -type d -exec bash -c "cd '{}' && pwd" \; )
while IFS= read -r cur; do
    bootpath="${cur}/*.sh"
    # shellcheck disable=SC2012,SC2086
    count=$( ls -1 ${bootpath} 2>/dev/null | wc -l )
    if [ "$count" != 0 ]; then
        echo "\"boot.sh\": Handling files in directory ${cur}"
        echo
        # shellcheck disable=SC2086
        chmod a+x ${bootpath}
        for f in ${bootpath}; do
            echo "running ${f}"
            # shellcheck disable=SC1090
            source "${f}"
            echo "done with ${f}"
            echo
        done
    fi
done <<< "${dirs}"

echo '\"boot.sh\" finished - continue with container ENTRYPOINT / CMD.'
