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

    # # https://ossna2020.sched.com/event/c3VM/cip-kernel-team-activities-to-accomplish-super-long-term-support-masashi-kudo-cybertrust-japan-co-ltd-sz-lin-moxa-inc
    # hugo_new_talk 'cip-kernel-team-activities-to-accomplish-super-long-term-support-masashi-kudo-cybertrust-japan-co-ltd-sz-lin-moxa-inc'

    # # https://ossna2020.sched.com/event/c413/keynote-linus-torvalds-creator-of-linux-git-in-conversation-with-dirk-hohndel-vice-president-chief-open-source-officer-vmware
    # hugo_new_talk 'keynote-linus-torvalds-creator-of-linux-git-in-conversation-with-dirk-hohndel-vice-president-chief-open-source-officer-vmware'

    # # https://ossna2020.sched.com/event/c3SS/yocto-project-lts-releases-nicolas-dechesne-linaro-david-reyna-wind-river
    # hugo_new_talk 'yocto-project-lts-releases-nicolas-dechesne-linaro-david-reyna-wind-river'

    # # https://ossna2020.sched.com/event/c3TK/linux-gpio-evolution-and-current-state-of-the-user-api-bartosz-golaszewski-baylibre
    # hugo_new_talk 'linux-gpio-evolution-and-current-state-of-the-user-api-bartosz-golaszewski-baylibre'

    # # https://ossna2020.sched.com/event/c47M/tutorial-introduction-to-the-embedded-boot-loader-u-boot-behan-webster-converse-in-code
    # hugo_new_talk 'tutorial-introduction-to-the-embedded-boot-loader-u-boot-behan-webster-converse-in-code'

    # # https://ossna2020.sched.com/event/c3RU/become-a-data-driven-organization-through-unified-metadata-using-odpi-egeria-mandy-chessell-ibm
    # hugo_new_talk 'become-a-data-driven-organization-through-unified-metadata-using-odpi-egeria-mandy-chessell-ibm'

    # # https://ossna2020.sched.com/event/c3Ry/opkg-debians-little-cousin-alejandro-del-castillo-national-instruments
    # hugo_new_talk 'opkg-debians-little-cousin-alejandro-del-castillo-national-instruments'

    # # https://ossna2020.sched.com/event/c3Pq/bof-the-yocto-project-and-openembedded-philip-balister-consultant-opensdr-nicolas-dechesne-linaro
    # hugo_new_talk 'bof-the-yocto-project-and-openembedded-philip-balister-consultant-opensdr-nicolas-dechesne-linaro'

    # # https://ossna2020.sched.com/event/c3Q2/sandboxing-in-linux-with-zero-lines-of-code-ignat-korchagin-cloudflare
    # hugo_new_talk 'sandboxing-in-linux-with-zero-lines-of-code-ignat-korchagin-cloudflare'

    # # https://ossna2020.sched.com/event/chs2/tutorial-debugging-embedded-devices-using-gdb-a-review-of-some-lessons-learned-mike-anderson-the-ptr-group
    # hugo_new_talk 'tutorial-debugging-embedded-devices-using-gdb-a-review-of-some-lessons-learned-mike-anderson-the-ptr-group'

    # # https://ossna2020.sched.com/event/cj67/a-new-home-for-data-and-storage-collaboration-kei-kusunoki-ntt-communications-vivian-zhu-intel-corporation-yuji-yazawa-toyota-motor-corporation-yu-zou-china-unicom-cloud-data-company
    # hugo_new_talk 'a-new-home-for-data-and-storage-collaboration-kei-kusunoki-ntt-communications-vivian-zhu-intel-corporation-yuji-yazawa-toyota-motor-corporation-yu-zou-china-unicom-cloud-data-company'

    # # https://ossna2020.sched.com/event/c3W8/the-definitive-deep-dive-into-the-git-folder-rob-richardson-independent
    # hugo_new_talk 'the-definitive-deep-dive-into-the-git-folder-rob-richardson-independent'

    # # https://ossna2020.sched.com/event/c3U6/tutorial-device-tree-dts-linux-board-bring-up-and-kernel-version-changing-a-review-of-some-lessons-learned-schuyler-patton-texas-instruments
    # hugo_new_talk 'tutorial-device-tree-dts-linux-board-bring-up-and-kernel-version-changing-a-review-of-some-lessons-learned-schuyler-patton-texas-instruments'

    # # https://ossna2020.sched.com/event/c3Ua/building-bare-metal-toolchains-crosstool-ng-and-yocto-project-mark-hatle-xilinx
    # hugo_new_talk 'building-bare-metal-toolchains-crosstool-ng-and-yocto-project-mark-hatle-xilinx'

    # # https://ossna2020.sched.com/event/c4O5/tutorial-introduction-to-i2c-and-spi-both-in-kernel-and-in-userspace-michael-welling-qwerty-embedded-design-llc
    # hugo_new_talk 'tutorial-introduction-to-i2c-and-spi-both-in-kernel-and-in-userspace-michael-welling-qwerty-embedded-design-llc'

    # # https://ossna2020.sched.com/event/c3R6/developing-building-and-testing-your-baremetal-applications-using-the-yocto-project-and-openembedded-infrastructure-alejandro-hernandez-samaniego-microsoft
    # hugo_new_talk 'developing-building-and-testing-your-baremetal-applications-using-the-yocto-project-and-openembedded-infrastructure-alejandro-hernandez-samaniego-microsoft'

    # # https://ossna2020.sched.com/event/c4OB/tutorial-spelunking-for-hardware-data-matt-porter-konsulko-group
    # hugo_new_talk 'tutorial-spelunking-for-hardware-data-matt-porter-konsulko-group'

    # # https://ossna2020.sched.com/event/cZJ9/automotive-grade-linux-on-raspberry-pi-how-does-it-work-leon-anavi-konsulko-group
    # hugo_new_talk 'automotive-grade-linux-on-raspberry-pi-how-does-it-work-leon-anavi-konsulko-group'

    # # https://ossna2020.sched.com/event/c3R9/reproducible-builds-and-hash-equivalence-in-the-yocto-project-joshua-watt-garmin
    # hugo_new_talk 'reproducible-builds-and-hash-equivalence-in-the-yocto-project-joshua-watt-garmin'

    # # https://ossna2020.sched.com/event/c3Ve/when-linux-on-the-desktop-is-a-second-class-corporate-citizen-mike-jang-gitlab
    # hugo_new_talk 'when-linux-on-the-desktop-is-a-second-class-corporate-citizen-mike-jang-gitlab'

    # # https://ossna2020.sched.com/event/cNS8/soda-one-data-framework-infinite-possibilities
    # hugo_new_talk 'soda-one-data-framework-infinite-possibilities'

    # https://ossna2020.sched.com/event/c3TN/pipewire-the-new-multimedia-service-now-ready-for-automotive-julian-bouzas-collabora
    # hugo_new_talk 'pipewire-the-new-multimedia-service-now-ready-for-automotive-julian-bouzas-collabora'

    # https://ossna2020.sched.com/event/c3UL/a-disciplined-approach-to-debugging-lev-iserovich-d-e-shaw-research
    hugo_new_talk 'a-disciplined-approach-to-debugging-lev-iserovich-d-e-shaw-research'
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"

fi
