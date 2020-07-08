---
title: "Linux on Open Source Hardware with RISC-V"
subtitle: "Drew Fustini, BeagleBoard.org Foundation"
# summary: ""
categories: [ "2020-oss-elc" ]
date: 2020-06-30
featured: false
draft: false
tags:
- Linux

event: "Linux on Open Source Hardware with RISC-V"
event_url: "https://ossna2020.sched.com/event/c3Pn/linux-on-open-source-hardware-with-risc-v-drew-fustini-beagleboardorg-foundation"
# location: ""
# summary: ""
# abstract: ""
date: 2020-06-30
date_end: 2020-06-30
publishDate: "2020-06-30"

links:
- name: Event
  url: https://ossna2020.sched.com/event/c3Pn/linux-on-open-source-hardware-with-risc-v-drew-fustini-beagleboardorg-foundation
- name: Slides
  url: https://github.com/pdp7/talks/blob/master/rv-elc.pdf
- name: Talks
  url: https://github.com/pdp7/talks

# image:
#   caption: ""
#   focal_point: ""
#   preview_only: false
projects: [ "2020-oss-elc" ]
---

> Want to run Linux on open hardware? This talk will explore Open Source Hardware projects capable of that task, and explore how RISC-V and free software FPGA projects can be leveraged to create libre systems.
>
> This talk will explore Open Source Hardware projects relevant to Linux, including boards like BeagleBone, Olimex OLinuXino, the Reform laptop and more.
>
> I will also talk about the importance of the open RISC-V instruction set and free software FPGA toolchains. I will explain how myself and others at Hackaday Supercon teamed up to get Linux running on RISC-V core in the ECP5 FPGA badge. I will explain what LiteX is and how it enabled us to quickly build a SoC capable of running Linux.
>
> Finally, I will explore the landscape of open source chip design projects and the Linux-capable RISC-V silicon chips on horizon for 2020.

## Notes

- https://github.com/pdp7/talks
- https://github.com/pdp7/talks/blob/master/rv-elc.pdf
- https://media.ccc.de/v/36c3-10549-linux_on_open_source_hardware_with_open_source_chip_design

What's required to be "open hardware"

- schematic
- board layouts

### RISC V: The instruction set for everything?

- ISA=instruction set architecture
- ARM requires commercial licening

### What's different about RISC-V

- simple
- clean slate design
- modular
  - extensively/specialization
  - small standards base ISA, with multiple standard extensions
- stable
- community design

### Ecosystem

- opensource software
- commercial software
- open-source cores

Hardware

- commercial cores
- commercial core provisders
- inhouse cores

### Industry

- Most people are just licensing cores from ARM
- open source implementation
  - BOOM, Rocket, PULP, SweRV

### Chips

lowRISC

- not-for-profit organisation
- OpenTitan project with Google

SiFive

- SiFive FE310 microcontroller
- HiFive1: Arguino Compatible RISC-V dev kit

Linux on RISV-V

- HiFive Unleashed
  - best core if you want to run RISC-V Linux
  - mostly just a proof of concept

Kendryte K210

- 8 mb of SRAM
- $13
- https://hackaday.com/2019/02/14/new-part-day-a-risc-v-cpu-for-eight-dollars/
- Has MMU but too old to be supported by linux
- will be suported in Linux 5.8

PolarFire

- CORE-V Chassis - tapeout 2H 2020
- Hard RISC-V with FPGA fabric

Open Source FPGA Tools

- [MeganWachs - Keynote RISC-V and FPGAs: Open Source Hardware Hacking](https://www.youtube.com/watch?v=vCG5_nxm2G4)
- Lattice

### Linux on Badge

- has ECP5 FPGA
  - Supported by open source FPGA tool
- Linux running on Supercon badge
- 2019 Supercon badget
- 32 MB of SDRAM to the Hackaday badge

### Migen

- HDL written in python
- https://github.com/litex-hub/fpga_101

### LiteX

- Litex used to build cores, create SoCs and full FPGA designs
- LiteX Hub - Collaborative FPGA projects around LiteX
- Based on Migen

### Linux on LiteX

- https://github.com/litex-hub/linux-on-litex-vexriscv

What baords could you use?

- ULX3S
  - ECP FPGA dev board

### Quickstart - FPGA

- Fomu
  - RGB LED
  - MicroPython
  - Verilog
  - LiteX

### Quickstart -No Hardware

- [Renode](renode.io)
