#!/bin/bash

# Bash Strict Mode # For scripts that already depend on Bash.
set -eu -o pipefail
IFS=$'\n\t'

D_SCRIPT="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd -P)"

cd "${D_SCRIPT}/../"
CSVFILE="${1?}"

datalad addurls \
    --ifexists 'overwrite' \
    "${CSVFILE}" \
    "{url}" \
    "annex/by-date/$(date --iso-8601)/{_url_basename}"

