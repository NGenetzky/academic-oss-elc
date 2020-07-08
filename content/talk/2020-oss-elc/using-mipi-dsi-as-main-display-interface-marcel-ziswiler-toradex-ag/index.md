---
title: "Using MIPI DSI as Main Display Interface"

# subtitle: ""
# summary: ""
categories: [ "2020-oss-elc" ]
date: 2020-06-30
featured: false
draft: false

tags:
- Audio
- Embedded Linux Conference (ELC)
- Practical Experiences and War Stories
- Standards
- Streaming Media and Graphics
- Video

event: "Using MIPI DSI as Main Display Interface"
event_url: "https://ossna2020.sched.com/event/c3XO/using-mipi-dsi-as-main-display-interface-marcel-ziswiler-toradex-ag"
# location: ""
# summary: ""
# abstract: ""
date: 2020-06-30
date_end: 2020-06-30
publishDate: "2020-06-30"

links:
- name: Event
  url: "https://ossna2020.sched.com/event/c3XO/using-mipi-dsi-as-main-display-interface-marcel-ziswiler-toradex-ag"

# image:
#   caption: ""
#   focal_point: ""
#   preview_only: false
projects: [ "2020-oss-elc" ]
---

## Using MIPI DSI as Main Display Interface

- Marcel Ziswiler, Toradex AG

> The MIPI Display Serial Interface (DSI) is the de-facto standard display interface featured by modern higher-end SoCs. Lacking the long-term availability of discrete MIPI DSI display panels most embedded systems rely on bridge chips converting to more common display interfaces like parallel RGB, LVDS, (e)DP or HDMI. Our generic system concept relies on DSI adapter boards integrating various such bridge chips. After introducing the Linux DSI subsystem this talk concentrates on the auto-detection of such DSI adapters based on parametrisation stored in EEPROMs. The U-Boot boot loader reads the EEPROM contents and chooses the applicable device tree overlay to be applied. The concept of DDC/EDID with hot-plug detect vs. a custom model-specific parametrisation is discussed. The talk continues covering the integration aspect of such DSI bridge chips within the Linux DRM stack. Various limitations of the DSI subsystem and possible solutions are discussed. The DSI bridge chip ecosystem is covered and we look into possible reasons only very few bridge chips are actually supported in mainline so far. The talk concludes with a live demo of our DSI auto-detection implementation. 

- Tordadex - swiss. Embedded. Computing

## Intro

- MIPI
- U-Boot FIT Image
- LIve Demo

## MIPI Display Serial Interface (MIPI DSI)

- Spec by MIPI Alliance
- Low power (LP) mode or high speed (HS)  mode
  - HS is ussually one direction

- MIPI DSI Spec initial version May 2006
- MIPI DSI-2 Spec supports Ultra high definition (4k and 8k)

- Physical Layer
  - 1.0 Gbps/lane (1.01), 1.5, 2.5, 4.5 Gbps/lane (D-PHY 2.0)
  - MIPI DCS - MIPI Display Command Set
  - Incorportates Display Stream Compression (DSC)
    - Standard from VESA
  - de-facto standard display interface feature by modern high-end SoC

## Verdin products

Verdin MIPI DSI Display Adapter System Design

- generic system concept
- display adapter boards integrating various bridge chips
- DSI Mezzanine Connector
  - MIPI DSI: 1 clk + 4 data
  - GPIO ( BLK1_EN, Touch Interrupt)
- 2 x I2C bridge chip + DDC/EDID
- PWM backlight
- I2S for optional audio
- Generic system control signals
  - PWR_EN_MOCI
  - SLEEP_MOCI#
  - RESET_MOCI#

Verdin iMX8M Mini

- NXP i.MX 8M Mini SoC
- Single display controller, LCDIF
- MIPI DSI output w/ 4 data
- MIPI D-PHY 1.2 max data per lane 1.5 GPS
- Resoution up to 1920x180p60 and 1800x1200p60

Verdin DSI to HDMI Adapter

- Lontium Se
- HDMI V1.4 1080p, 8bit RGB up to 60Hz
- ST HDMI2C1-14HD ESD prtect and signal conditiong
- type A standard HDMI connector

Verdin DSI to LVDS Adatper

- SN65DS184 MIPI DSI to dual link LVDS bridge
- signle/dual-lane LVDS up to 1920x1200/1377x768
- LVDS and touch connector compatible with Capacitive Touch Display 10.1" LVDS

## Intro Linux DSI Subsystem

DRM MIPI DSI Core
common logic helpers to deal with MIPI DSI peripherals

- DRM Panel COre - Generic LVDS Panel (panel-lvds.c)
- DRM Bridge Core TI SN65DS184 DSI to LVDS Bridge - (ti-sn65dsi84.c)
- MIPI DSI Core - Northwest Logic MPI DSI Host COntroller (nwi-dsi.c)
- DRM CORE - Display Engine Driver

## DSI bridge chip integration

How does DSI bridge chip integrate with that?

- DRM bridge
- DRM connector
- I2C device
- MIPI DSI device

DSI Bridge Chip Integration Pitfalls

- availability of super secret data sheets
  - chinese vendors hide their data sheets
- ancient downstream or bare skeleton drivers only
- lots of hard-coded parmeters
- link bring-up sequences not well documented
  - lots of trial and error
- Drivider frequency limitations on either controller side, bridge side or both
  - may require running outside of recommended range

### Bridge Chips in our current Adapters

How about Bridge Chips used in our designs current Adapters?

- Lontium LT8912B MIPI DSI to HDMI bridge
- Adopted driver from Rockchip Linux on Github
  - Forward ported to later DRM API
  - Reword driver to be proper I2C device
  - full register set from Lontium psuedo code driver
  - imrpoved regmap integration
  - I2C sub addresses
  - added regular I2C based DDC/EDID handling
  - Added GPIO based hot-plug detection
    - Needed for I2C GPIO expander support
    - hot plug detect GPIO handling crashed GPIO exapdnder
  - bus format was not properly set
- not pretty but it works
- Further clean-up and upstreaming pending

- Texas Instruments SN65DSI84 MIPI DSI to dual-link LVDS bridge
- Downstream driver taken from a patch in CompLab Yocto Meta Layer on Github

### DSI Bridge Chip Ecosystem

- Vendors still reluctant to maining drivers
- Few mainline supported bridge chips
- Few examples to copy from
- procedure of actual silicon may be difficult
- conformance of MIPI DSI host IP vs bridge chip silicon

 Bridge Chips supported in Mainline

- driver/gpu/drm/bridge
- Differentiate between
  - SoC internal IP
  - discrete external bridge chips
  - directly connected panels

- SoC internal IP
  - NXP i.MX 8 series
- discrete external bridge chips
  - ADV7533
  - Parade PS8640 MIPI DSI to eDP converter
  - SN65DSI86 DSI to eDP Bridge
  - TC358764 DSI/LVDS Bridge
  - TC358768AXBG/TC358778XBG MIPI DSI bridge chips
- directly connected panels
  - Rasperry Pi 7In touch. Toshiba TC358762 DSI to DPI aka parallel RGB bridge

## Auto-Detection of DSI Adapter Base on EEPROM Contents

- idea 1
  - regular device tree: setting bridge stat to disable vs okay
  - device graph: linking endpoint and remote-endpoint nodes?
  - full flexbility requires device tree overlays
- idea 2
  - storing device tree overlay in EEPROM
  - simple DTBO may be below 1kb more complex ones quickly more than 2kb
- compromise. Store configuration block

### U-Boot read EEPROM Contents and Selecting Applicatble Device Tree Overlay

- Generalized ConfigBlock Handling from NAND/eMMC to EEPROM
- table with product ID to device treee overlay file name mapping
- Distroboot script to apply device tree overlays based on auto-detection as well as overlays.txt file

- HDMI may do hot-plug detect
- DDC/EDID

- MIA...

### DT Overlays

Verdin DSI

- Verdin DSI to HDMI Adapter
  - fragment for I2C bus
  - fragment for I2C bus where you have bridge chip on
- Verdin DSI to LVDS Adapter

### Uboot FIT Image

- board specfici device trees
- display adapter specific device tree overlays

- FIT image allows conveninet packing of Linux kernel binary toegether with various device trees, device tree overlays and/or ramdisk
- booted as...
- fdt_module is deduced form the EEPROM on the module. fdt_board from one on the carrier board. display_adapter_dtbo from one of the display adapters

```sh
mkimage -l tezi.itb
...
```

### Device Tree Overlay Pitfalls

- complex device tree overlays may require symbols
- `DTC_FLAGS='-@'`
- if reference device nodes with hex addresses.
  - CASE SENSITIVE!!!
  - use lower case!!!
- troubleshooting
  - Add dtc on target. `opkg install dtc`
  - Use `dtc -l fs` on target and dump /proc/device-tree

## Conclusion

- Demo - DSI Auto-Detection Demo

## Questions

- Q: Used overlay stuff in u-boot
- Q: Is Low power signaling Single ended?
- Q: Can the end pane llike LVDS support partial update? How will the bridge propogate the presence/absence of particular DCS feature to Linux DRM driver subsytem?
- Q: did you consider doing the overlays in linux kernel?
- Q: Why is DRM required with DSI?
- Q: Why are the vendors reluctant with regards to mainlining (or even docs)?
- Q: Keep the conversation going. Please visit the #2-track-embedded-linux on our Slack Workspace after the session ends
