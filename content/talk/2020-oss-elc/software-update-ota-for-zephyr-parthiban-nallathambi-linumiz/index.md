---
title: "Software Update (OTA) for Zephyr"
authors: [ "nathan-genetzky" ]

# subtitle: ""
# summary: ""
categories: [ "2020-oss-elc" ]
date: 2020-07-01
featured: false
draft: false

tags:
- Internet of Things
- Outside World Meets IoT RTOSes
- RTOS

event: "Software Update (OTA) for Zephyr"
event_url: "https://ossna2020.sched.com/event/c3St/software-update-ota-for-zephyr-parthiban-nallathambi-linumiz"
# location: ""
# summary: ""
# abstract: ""
date: 2020-07-01
date_end: 2020-07-01
publishDate: "2020-06-29"

links:
- name: Event
  url: https://ossna2020.sched.com/event/c3St/software-update-ota-for-zephyr-parthiban-nallathambi-linumiz
- name: Slides
  url: https://static.sched.com/hosted_files/ossna2020/56/Software%20Update%20%28OTA%29%20for%20Zephyr.pdf

# image:
#   caption: ""
#   focal_point: ""
#   preview_only: false
projects: [ "2020-oss-elc" ]
---

## Software Update (OTA) for Zephyr

- Parthiban Nallathambi, Linumiz

> Zephyr devices can be connected in two possible (direct and in-direct) ways to the internet. Directly using Modem/WiFi/Ethernet medium or in-directly via local radio through Gateways like Linux. Upgrading such Zephyr system in the field is a complex task and must be robust, secure.
>
> This talk will details various possible update solutions available like UpdateHub, Hawkbit, SWUpdate for Zephyr. Using a NXP FRDM-K64F board as an example, we will discuss and demo different possible ways for updating Zephyr system.

## Agenda

- McuBoot
- Updatehub
- mcumgr
- ZUpdate
- ZUpdate -Hawkbit
- Future work

### Linux vs Zephyra

- on linux it handles both download and install
- for zephyr this is split into two
  - download handled by application
  - install is handled by MCUBoot

- First we focus on download.
- Then we look at install

## MCUBoot

- Bootloader for Zephyr and mynewt
- integrity and security check
- multi image boot support
- softwre update heavy lifting

MCUBoot Memory Layout

- NXP Freedom kit

```javascript
chosen {
zephyr,code-partition = &slot0_partition;
};
&flash0 {
partitions {
compatible = "fixed-partitions";
#address-cells = <1>;
#size-cells = <1>;
boot_partition: partition@0 {
label = "mcuboot";
reg = <0x00000000 0x00010000>;
read-only;
};
slot0_partition: partition@20000 {
label = "image-0";
reg = <0x00020000 0x00060000>;
};
slot1_partition: partition@80000 {
label = "image-1";
reg = <0x00080000 0x00060000>;
};
scratch_partition: partition@e0000 {
label = "image-scratch";
reg = <0x000e0000 0x00020000>;
};
};
};
```

Paritions

- Mcuboot
- slot0
- slot1
- scratch

MCUBoot operation

- conditions: Interrupt swap, request swap, valid image
- Video from Youtube

MCUBoot swap

- swap status
  - three stage operation
  - slot1 to slot0

API

- image confirmed
- write image
- request upgrade
- erase

Live share

```sh
west flash -d ./frdm_mcuboot/
```

## Software Update

### Updatehub

- What is it?
- Polling Mode
- Manual mode
- Community vs Enterprise

Live Share

```sh
~/work/west/native/zephyr/samples/net/updatehub
west flash

~/work/west/native/zephyr/samples/net/updatehub
west flash -bin-file ./build/zephyr/zephyr-signed.bin
```

Web UI

- Overview
- Devices
- Pakcages
- Rollouts

Each rollout has

- UID, version, hardware

### MCUmgr

- Management library for Zephyr and mynewt
- OS and hwardware agnostic

Layered modular design

- 1: img_mgmt,fs_mgmt,log_mgmt,os_mgmt
- 2: mgmt
- 3: SMP
- 4: BLuetooth, Shell, UDP

Reference Screenshots

- STM32 target initial slot list
- Uploading the OTA image via the Bluetooth interface
- STM32 target initial slot list after OTA push

### ZUpdate architecture

- Configuration Manager
- ZUpdate Core
- Download Handler
  - Hawkbit
  - updatehub
  - SWUpdate
  - Custom
- StorageHandler
  - SPI NOR
  - FLash
  - MMC
- Low-Level Comm
  - BLE
  - WiFI
  - LoRa
