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

    # https://ossna2020.sched.com/event/c3VM/cip-kernel-team-activities-to-accomplish-super-long-term-support-masashi-kudo-cybertrust-japan-co-ltd-sz-lin-moxa-inc
    hugo_new_talk 'cip-kernel-team-activities-to-accomplish-super-long-term-support-masashi-kudo-cybertrust-japan-co-ltd-sz-lin-moxa-inc'

}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"

fi
