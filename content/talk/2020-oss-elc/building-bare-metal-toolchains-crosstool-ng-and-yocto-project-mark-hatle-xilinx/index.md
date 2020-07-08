---
title: "Building Bare Metal Toolchains, Crosstool-ng and Yocto Project"
authors: [ "nathan-genetzky" ]

# subtitle: ""
# summary: ""
tags:
- Yocto

categories: [ "2020-oss-elc" ]
date: 2020-06-30
featured: false
draft: false

event: "Building Bare Metal Toolchains, Crosstool-ng and Yocto Project"
event_url: "https://ossna2020.sched.com/event/c3Ua/building-bare-metal-toolchains-crosstool-ng-and-yocto-project-mark-hatle-xilinx"
# location: ""
# summary: ""
# abstract: ""
date: 2020-06-30
date_end: 2020-06-30
publishDate: "2020-06-30"

links:
- name: Event
  url: https://ossna2020.sched.com/event/c3Ua/building-bare-metal-toolchains-crosstool-ng-and-yocto-project-mark-hatle-xilinx

# image:
#   caption: ""
#   focal_point: ""
#   preview_only: false
projects: [ "2020-oss-elc" ]
---

## Building Bare Metal Toolchains, Crosstool-ng and Yocto Project

- Mark Hatle, Xilinx

> Recently I was tasked to create a bare metal toolchain to create software for a variety of embedded processor architectures and configurations. Crosstool-ng is often used to create these toolchains, but Yocto Project SDK builder is capable of doing this as well. This presentation will compare both crosstool-ng and the Yocto Project for this task, include my experiences working with both tools, include Yocto Project configuration information and give the audience an understanding when they may want to use one tool vs the other.

## Agenda

- crosstool-ng
- Yocto Project SDK builder
- Experience
- Yocto Project Configuration
- Recommendation
- Questions

## crosstool-ng

- crosstool-ng is versatile cross toolchain generator
- good at reproducable toolchain
- `ct-ng list-samples
- Runtime relocatable
  - can install in one location and mount/run from many
- binaries are very specific to the host environments they were built for
  - determine which operating system the user is using
  - builds on the oldest distro
  - Can build  from Cygwin
  - expects you to have cygwin cross compiler
- Configuration is similar to kernel config

- Config process will create ctx files
- xilinx typically distributed "multilib" versions

## Yocto Project SDK builder

### Yocto Project

- yocto project is not linux specific
  - FreeRTOS
  - OpenAMP
  - Bare Metal
- Outputs include
  - Run-time images
  - SDK / eSDK

This talk is focusing on SDK

### Yocto Project SDK

- target SDK
  - matches operating system runtime environment
- defined SDK
  - SDK where each component is define to be include in SDK
- SDK can be multilib enabled
  - multilib are built independently of each other
  - slower, but safer approach foor complex configuration

- self extracting installation file
- built to isolate sdk environment from the host system
  - SDK includes its own glibc, and some runtime components
  - Don't need your own cygwin and other environment
- installation and runtime locations must be the same
- automatic runtime relocation is not supported
  - note - this is supported by the plain 'sdk'

example

```bash
oe-init-build-env build-baremeta-tc
DISTRO=xilinx-standalone MACHINE=microblaze-tc bitbake meta-toolchain
```

- slower than crosstool-ng
  - more steps to prevent multilib contamination

### SDK - distro conf - xilinx-standalone.conf

How to create SDK config (and distro) ?

- LIBC_DEPENDENCIES
  - newlib-static dev
  - libgloss-staticdev
- install static library
  - clear defaults for distro feature backfill
  - virtual runtime init manager
  - preffered virtual kernel

```
# xilinx-standalone.conf
SDK_VERSION = ""xilinx-standalone
```

### SDK - machine conf - microblaze-tc.conf

- multilib
  - MULTILIB_GLOBAL_VARIANTS
  - MULTILIBS += "multilib:libmble"
  - tons more
- default tune
  - `DEFAULTTUNE = "microblaze"`
  - AVAILTUNES
  - BASE_LIB
  - TUNE_FEATURES
  - PACKAGES_EXTRA_ARCH

## Experience - part 1

#### Changes from crosstool-NG

- binutils
  - set diffferent defaults to match prior toolchain
- GCC
  - different default to match prior toolchain
  - restore some previously disabled newlib options (sysroots)
  - only build SDK GCC once, create symlinks for other multilibs (gnu-toolchain-canadian.bb)
- newlib/libgloss
  - adjust defaults
  - workaround issues with multilibs conflicted
  - workaround issues where libgloss and newlib dependency wasn't multilib aware

### Compare

- cross
  - MIA
- yocto
  - linux sample confs
  - no baremetal confs
  - not relocatable
  - full feature toolchain
  - support mingw

## Experience - part 2

### Xilinx Bare Meta Toolchain

- transitions from crosstool-ng to Yocto Project SDK to unify toolchain source and testing
- transition was not painless from development perspective
  - 2-3 weeks for first few weeks
  - took 3 months to iterate the get it stable
- lots of questions about multilib configuration
- why was this transition and maintence was hard
  - people didn't understand **why** certain settings were set
  - old version of crosstool-ng, people were not keeping up on configuration
- initial goals was compatability with fromer crosstool-ng and custom ARM toolchain
  - pseudo runtime relocation capable

### Bare Metal Multilibs

- aarch32-tc.conf
- aarch32
  - standard ARM (A profile) 32bit instruction set
  - multilib config based on GNU/ARM defaults
  - 17 multilibs defined
    - custom defined to match GNU/ARM settings
- first we got it working
- Now we can focus on fine tuning
- Custom `arm-rm-tc.conf`
- ARM R/M
  - readltime
  - microcontroller
- aarch64
  - `aarch64-tc.conf`
- Microblaze (microblaze-tc.conf)
  - common microblaze isntruction set permulation
  - custom config

### Bare Meta Toolchain COnfiguration

- binutils
  - disable: gold as LD, gprof, shared
  - enable: enable-lto, static, multilib
- gcc
- newlib/libgloss
  - `recipes-core`
  - xilinx baaremeta implements device specific items using libxil, but we use libgloss to provide the framework
  - flags
    - enable-newlib-io-c99-format
    - long-long
    - io-flow
    - long-double
    - disable-newlib-supplied-syscall
  - libgloss multilib
    - "${MLPREFIX}newlib"

This was one of the major issues:

- disable 'disable-initfini-array'

### Lessons

- more multilib - longer initial project parse time
- microblaze parse time is nearly an hour (48 multilibs)
  - devlopment workaround, build for only one multilib
- mingw32 builds are sequential with linux version, using shared sstatic-cache
- roughly 15 minutes on the same machine for mingw parts

### Recommendations

- for quick toolchain - use Crosstool-ng
- Yocto Project makes sense if you need Cygwin
  - less important since windows is moving to linux
- Yocto Project take more time and effort
  - easy way for common source and configuration switchs
  - simplify defect handling and propagation of fixes for systems

## Questions

- Vivado vitis baremetal tools chians are built with this
- How did you converge configuration
  - query gcc
  - check logs for what arguments were passed
  - print config
- which release was this against.
  - 3.0 zeus
- multilib vs multiconfig
  - this was largely due to legacy reasons
  - one gcc binary to execute

## Author

- kernel-crashing.org
- author: fray
