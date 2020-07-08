---
title: "Tutorial: Introduction to the Embedded Boot Loader U-boot"

# subtitle: ""
# summary: ""
categories: [ "2020-oss-elc" ]
date: 2020-06-29
featured: false
draft: false
tags:
- Yocto

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

## Tutorial: Introduction to the Embedded Boot Loader U-boot - Behan Webster, Converse in Code

- Behan Webster, Converse in Code

> U-Boot is the universal bootloader used on a vast majority of embedded systems, development kits, products and so on. This session is an introduction into the U-Boot bootloader, including a hands-on part, and covers practical topics like identifying that the board is running U-Boot, accessing and exploring the U-Boot shell, including advanced scripting techniques to make life easier, obtaining information about the current hardware, accessing buses and storage and finally booting the kernel. Furthermore, since every embedded project has it’s a unique set of requirements, U-Boot customization topics are briefly touched at the end of the session. 

## Notes

- SPL - Secondary program Loader
  - Just enough of U-Boot to load something else
- Tertiary program loader
  - smaller than SPL
  - uncommon

### U-boot Shell

- original shell
- HUSH shell
- similar to bourne shell
- You can get help for 'usb': `help usb`

### contact

irc
mailing list

### Memory access

- support for read/write mem and reg
- support for byte/word/long/quad
- memory modification interactivly `mm`, `mn`
- `cp` copy memory
- `cmp` compare

### U-boot environment

- env key value storage
- default to compile time default
- can have defaults read from somewhere
- can be saved in memory

- `printenv` print all env
- `env print arch`
- `env set fookey barvaluse`
- `env set foonowempty` similar to unset foonowempty
- `saveenv` for env persistence
- `run` for running scripts. chain commands with ';'
- The script environment is evaluate when set. You can escape `$` to evaluate later

Special variables

- ver
- stdin, stdou, stderr
- loadaddr
- filesize
- bootargs
- bootcmd
- preboo
- ipaddr, netmask, serverip, gatewayip - network settings,
- ethaddr, eth1addr

Other commands

- setexpr - environment manipulation multitool

logical and conditional expression

- `if`, `||`, `&&`
- can't use `!` in conditional.
- `while`

### u-boot data loading

- SD/MMC `mmc`, usb, sata, nand
- Uiversal FS access `ls`, `load`
- Squash FS not supported

Example with SD card

```shell
mmc rescan
mmc part

# device and partition
ls mmc 0:1

load mmc 0:1 $loadaddr ID.txt

md.b $loadaddr $filesize
```

Loading from network

U-Boot network stack is UDP-only (no TCP)

- support for TFTP, NFS, DHCP/BOOTP
- ping
- tftp
- dhcp (obtain settings then tftp)

```
env set
ping $serverip
tftp $loadaddr $serverip:somefile
dhcp $loadaddr $serverip:somefile
```

Load over serial

- X/Y modem
- Srecord
- kermit protocol
- `loady`

Screen

```
loady
ctrl-a:exec !! sb -T yourbinary.bin
```

### Booting the kernel

- (z)Image
  - Linux binary (with decompressor)
  - no protection gainst bitrot
  - just set up registers and jump
  - optional separate device tree
- uImage (originally support, now legacy)
  - Legacy since forever
  - wrapper around binary
- `fitImage` - multi component image
  - based on device tree
  - support multiple files
  - configurable checksum algorithm per entry
  - support digital signatures
  - like tar files

Booting

- boot commands: bootz, booti, bootm

```
env set bootargs console=ttyO0,115200
load mmc 0:1 boot/dtbs/4.9.../am335x.dtb
load mmc 0:1 0x880000 boot/dtbs/4.9.../am335x.dtb
```

Device Tree

- Data structure describing the hardware
- asyclic graph
- can link to any items

snippet

```devicetree
`images { kernel@1 { data
  data = /incbin/("./arch/arm/boot/dts/...dtb")
}}
```

```
mkimage -f fitimage.its fitImage
```

```
bootm $fitimageaddr
iminfo imxtract
```

### fdt

fdt command can maniuplate flattend device tree

- fdt addr
- fdt resize
- fdt print
- fdt set

### gpio

- gpio input
- gpio set
- gpio clear
- gpio toggle

### i2c command

- i2c bus
- i2c dev
- i2c md
- i2c mw - write registers to I2C device
- i2c probe
- i2c speed


### qemu

```
qemu-system-arm -M virt -bios u-boot.bin
```

### Demo

```
env set bootargs root= rootfstype= rootwait console=ttyO0,115200
mmc rescan
load mcc...
load mmc...
```


### Task 7 build u-boot in sandbox mode

ALlows you to run u-boot as user application

```
make sandbox_defconfig
```

### Other task

```
env ask mac 'MAC address ?'
```
