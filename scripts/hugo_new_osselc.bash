#!/bin/bash
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    # Bash Strict Mode
    set -eu -o pipefail

    SCRIPTDIR="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd -P)"
fi

hugo_new_talk(){
    cp -T -R \
        './content/talk/2020-oss-elc/template/' \
        "./content/talk/2020-oss-elc/${1?}/"
}

main(){
    cd "${SCRIPTDIR}/../"

    hugo_new_talk "${1?Please suplly slug}"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
