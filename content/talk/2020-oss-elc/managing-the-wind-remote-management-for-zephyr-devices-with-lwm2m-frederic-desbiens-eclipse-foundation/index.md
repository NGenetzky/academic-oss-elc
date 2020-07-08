---
title: "Managing the Wind: Remote Management for Zephyr Devices With LwM2M"
authors: [ "nathan-genetzky" ]

# subtitle: ""
# summary: ""
categories: [ "2020-oss-elc" ]
date: 2020-07-01
featured: false
draft: false

tags:
- RTOS

event: "Managing the Wind: Remote Management for Zephyr Devices With LwM2M"
event_url: "https://ossna2020.sched.com/event/c3X0/managing-the-wind-remote-management-for-zephyr-devices-with-lwm2m-frederic-desbiens-eclipse-foundation"
# location: ""
# summary: ""
# abstract: ""
date: 2020-07-01
date_end: 2020-07-01
publishDate: "2020-06-29"

links:
- name: Event
  url: https://ossna2020.sched.com/event/c3X0/managing-the-wind-remote-management-for-zephyr-devices-with-lwm2m-frederic-desbiens-eclipse-foundation
- name: Slides
  url: https://static.sched.com/hosted_files/ossna2020/b5/2020.06%20-%20fdesbiens%20-%20Managing%20the%20Wind%20-%20Zephyr%20and%20LwM2M.pdf
- name: Wiki
  url: https://wiki.yoctoproject.org/wiki/YP_DevDay_Austin_2020

# image:
#   caption: ""
#   focal_point: ""
#   preview_only: false
projects: [ "2020-oss-elc" ]
---

## Managing the Wind: Remote Management for Zephyr Devices With LwM2M

- Frédéric Desbiens, Eclipse Foundation

> LightweightM2M (LwM2M) by OMA SpecWorks is a device management protocol designed for sensor networks and the demands of a machine-to-machine (M2M) environment. It is designed for the remote management of devices and is based on the Contrained Application Protocol (CoAP, RFC 7252), which itself provides an interaction model similar to the client/server model of HTTP.
>
> The Zephyr RTOS from the Linux Foundation possesses built-in support for LwM2M. In this presentation, you will discover how to leverage LwM2M to manage Zephyr-based devices. You will understand the pros and cons of using Zephyr's built-in LwM2M client. You will also learn about various LwM2m servers, including the Eclipse Leshan open source project, which you can use to build your own LwM2M management server.

## LwM2M features

- bootstrapping
- Device Configuration
- Firmware Update
- Fault management
- Configuration and Control
- Reporting

## LwM2M in the Zephyr Arch

- IPSP
  - Bluetooth profile leveraging 6LoWPAN (IPv6 over BLE)
- LwM2M Client
  - Runs on QEMU
  - Runs on actual board
  - requires server

## A Server: Eclipse Leshan

- Java library for implementing clients and servers
- Simple (no framework, few dpenecneies)
- Web UI for discovering
- build  using `mvn install`
- based on Eclipse Californium (an implementation of CoAP)

## LwM2m sample

- lwm2m is lightweight. `net/lwm2m.h`.
- Includes
- main
- Setup
- Event processing

## Demo

### Deploy

```sh
west build -b nrf52_adafruit_feather samples/net/lwm2m_client -- - DCONF_FILE="prj.conf overlay-bt.conf"
west flash --runner jlink
sudo minicom -D /dev/ttyUSB0 -b 115200
```

### 6lowpan and assign IPv6 address

```sh
sudo su
modprobe bluetooth_6lowpan
echo 1 > /sys/kernel/debug/bluetooth/6lowpan_enable
hcitool lescan
echo "connect C2:FA:8D:93:21:DD 2" > /sys/kernel/debug/bluetooth/6lowpan_control
ip address add 2001:db8::2/64 dev bt0
ping6 2001:db8::1
```

### Getting and starting Leshan Demo Server

```sh
wget
https://ci.eclipse.org/leshan/job/leshan/lastSuccessfulBuild/artifact/le
shan-server-demo.jar
java -Djava.net.preferIPv6Addresses=true
-jar leshan-server-demo.jar
```

- you can read, write and modify values
- Some are built into sample
  - temperature sensor
  - lights
