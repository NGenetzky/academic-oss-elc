---
title: "2020 OSS ELC"

# subtitle: ""
# summary: ""
# tags: []
categories: [ "2020-oss-elc" ]
date: 2020-06-29
featured: false
draft: true

# event: "2020 OSS ELC"
# event_url: ""
# location: ""
# summary: ""
# abstract: ""
date: 2020-06-29
date_end: 2020-06-29
publishDate: "2020-06-29"

links:
- name: Event
  url: https://ossna2020.sched.com/event/

# image:
#   caption: ""
#   focal_point: ""
#   preview_only: false
projects: [ "2020-oss-elc" ]
---

## Release update

> This BoF provides an open forum for the embedded Linux community to ask questions and discuss issues with Yocto Project and OpenEmbedded principals. We open with a Yocto Project summary and OpenEmbedded State of the Union.

- Platinum: Microsoft, Cisco, Xilinx,
- Gold: AGL

Other updates

- hash equivalence and reproducibilit5y now enabled tby default
- documentation migration to splinx
- https://wiki.yoctoproject.org/wiki/Newcomers
- oe-workship-2020/schedule

## Meetings

Tuesday
- 10:30 BUilding bare metal toolchains
- 3:15 

Wed
- Hash equivalency
- ANtoher one

BOF

- meta-spdxscanner is a tool for analyzing licenses.
- copyright tool in fossology
- https://github.com/garmin/pyrex
- https://github.com/conan-io/meta-conan
- https://docs.conan.io/en/latest/integrations/cross_platform/yocto.html
- https://pretalx.com/oe-workshop-2020/talk/XHKQ3M/
- https://github.com/WindRiver-OpenSourceLabs/ci-scripts
- IRC is irc.freenode.net #oe and #yocto

## OE Workshop 2020 - a common infrastructure for PKCS#11-based code signing (Jan Lübbe)

> Many upstream components integrated via OpenEmbedded already support cryptographic signatures for authentication (kernel, FIT images, update artifacts, boot images).
>
> There is already some existing support for signing using keys stored in the file-system (uboot-sign.bbclass, meta-rauc's bundle.bbclass, meta-secure-core). In larger projects, there is often the requirement to support more secure key storage devices such as HSMs (Hardware Security Modules).
>
> Fortunately, support for the standard API to use keys on hardware tokens (PKCS#11) is widespread by now. We can use this API and SoftHSM (a PKCS#11 simulator) to decouple individual packages from the key configuration. This simplifies testing, as almost the same code is used during development with keys loaded from the file-system and during release with a real HSM.
>
> Jan will present his implementation (a single .bbclass) and some example packages. He is looking for feedback, additional use-cases and testing.

- https://www.youtube.com/watch?v=ntwbkJTP1pw&feature=youtu.be
- https://pretalx.com/oe-workshop-2020/talk/XHKQ3M/
- https://pretalx.com/media/oe-workshop-2020/submissions/XHKQ3M/resources/OE-PKCS11_bQSY4xK.pdf
