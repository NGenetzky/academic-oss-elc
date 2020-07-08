---
title: "Developing, Building and Testing Your Baremetal Applications Using The Yocto Project and OpenEmbedded Infrastructure"
authors: [ "nathan-genetzky" ]

# subtitle: ""
# summary: ""
categories: [ "2020-oss-elc" ]
date: 2020-06-30
featured: true
draft: true
tags:
- Yocto

event: "Developing, Building and Testing Your Baremetal Applications Using The Yocto Project and OpenEmbedded Infrastructure"
event_url: "https://ossna2020.sched.com/event/c3R6/developing-building-and-testing-your-baremetal-applications-using-the-yocto-project-and-openembedded-infrastructure-alejandro-hernandez-samaniego-microsoft"
# location: ""
# summary: ""
# abstract: ""
date: 2020-06-30
date_end: 2020-06-30
publishDate: "2020-06-30"

links:
- name: Event
  url: https://ossna2020.sched.com/event/c3R6/developing-building-and-testing-your-baremetal-applications-using-the-yocto-project-and-openembedded-infrastructure-alejandro-hernandez-samaniego-microsoft
- name: Slides
  url: https://static.sched.com/hosted_files/ossna2020/9e/ELC_2020_AlejandroHS_new.pdf

# image:
#   caption: ""
#   focal_point: ""
#   preview_only: false
projects: [ "2020-oss-elc" ]
---

## Developing, Building and Testing Your Baremetal Applications Using The Yocto Project and OpenEmbedded Infrastructure

- Alejandro Hernandez Samaniego, Microsoft

> Multiarchitecture SoCs are more widely used, usually containing a large architecture where it can run a full operating system such as Linux, and one or more small architectures designed to run an RTOS or a baremetal application,requiring less hardware resources,leveraging suitable tasks from one to another creating a more efficient product.
>
> While the Yocto Project is well known for its capabilities on creating customized Embedded Linux Distributions,bitbake is also capable of building a toolchain to create Baremetal applications or an RTOS.
>
> In this presentation Alejandro will show how to create baremetal applications using the same flow currently used in OpenEmbedded to develop Linux applications, using recipes, classes and user configuration files, he will show how users from the community can benefit from a single flow, showcasing how to run these applications on QEMU and create tests for them to be automatically tested using the OpenEmbedded infrastructure along with their corresponding Linux distributions.
>
> Anyone from the community interested in learning about baremetal programming or about the Yocto Project might find the contents of this presentation interesting.

## Notes

Multiarchitecture Embedded Devices

- Azure Sphere
  - Secured MCU
  - Secured OS
  - Cloud Security
  - MT3620 Dev Board Diagram

### OE Runtime Testing Infra

- Testing a linux OS (poky)
- TEST_TARGET
  - QEMU
  - Hardware (simpleremote)
    - Send commands via SSH (TEST_SERVER_IP)

- TEST_SUITES
  - auto
  - cases: ping ssh scp parselogs
  - meta/lib/oeqa/runtime/cases

### TESTIMAGE_BOOT_PATTERNS in OE

- testimage.bbclass
  - TESTIMAGE_BOOT_PATTERNS
  - TESTIMAGE_BOOT_PATTERNS[send_login_user]
- qemurunner.py
  - default_boot_pattern
  - accepted_patterns

### Testimageflow

1. H: Start booting
2. T: Login
3. H: ROOT\n
4. T: Prints out root username
5. H: SEND_COMMAND
6. T: Check for another prompt
7. H: READ

### Baremetal Toolchain on the Yocto Project

```conf
MACHINE = "qemuarm64"
TCLIBC = "baremetal"
```

Then build and run in qemu

```sh
bitbake baremetal-helloworld
runqemu
```

Other tagets

```sh
bitbake meta-toolchain
bitbake baremetal-helloworld -c populate_sdk
```

- `TCLIBC="newlib"` - little more than baremetal

### Simple Baremetal HelloWorld on Aarch64

- QEMU source code (virt)
- UART, RAM, Kernel Address
- ARM Developers Manual - UART PL011

What files do you need?

- Start Code
- Linker Script
- Your source code

Example for aarch64

- hello_baremetal_aarch64.c
- startup_aarch64.s
- linkerscript_aarch64.ld

### Creating test for FreeRTOS

- Overriding Patterns in `local.conf`
  - TEST_SUITES = "freertos_echo"
- defined new test cases
  - [meta-freertos](https://github.com/aehs29/meta-freertos)
  - [freertos_echo.py]](https://github.com/aehs29/meta-freertos/blob/de4c8530b9bb31b9bbf08124a21a3ffc47d0121f/lib/oeqa/runtime/cases/freertos_echo.py#L1)
- These tests run in do_testimage

### How to create FreeRTOS test

This is a simple example of using OEQA test framework with a baremetal application.

- He then created a very basic C application that emulated the basic prompts for Linux.
- Hacky, but a simple way to get an initial test in with a framework focused on Linux testing.
- You could possibly get it working for libgloss

## Questions

- Q: Can a testimage.bb depend on something
- A: tests can depend on other recipes. Works with the build system itself.
