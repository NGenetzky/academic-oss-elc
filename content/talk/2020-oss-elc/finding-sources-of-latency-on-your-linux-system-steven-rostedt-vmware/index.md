---
title: "Finding Sources of Latency on your Linux System"

# subtitle: ""
# summary: ""
categories: [ "2020-oss-elc" ]
date: 2020-06-30
featured: false
draft: false

tags:
- Embedded Linux Conference (ELC)
- Real-Time Linux - Performance
- Tuning and Mainlining
- Linux

# event: "2020 OSS ELC"
# event_url: ""
# location: ""
# summary: ""
# abstract: ""
date: 2020-06-30
date_end: 2020-06-30
publishDate: "2020-06-30"

links:
- name: Event
  url: https://ossna2020.sched.com/event/c3Pw/finding-sources-of-latency-on-your-linux-system-steven-rostedt-vmware
- name: Slides
  url: https://static.sched.com/hosted_files/ossna2020/b1/oss-na-2020-sources-of-latency.pdf

# image:
#   caption: ""
#   focal_point: ""
#   preview_only: false
projects: [ "2020-oss-elc" ]
---

## Finding Sources of Latency on your Linux System

- Steven Rostedt, VMware

> In today's computer systems the level of complexity has risen such that when a task or response to an event takes longer than expected, it is not easy knowing what the culprit is. The Linux operating system contains several utilities that allows a user to see where things may be held up. This talk will cover many of these utilities and briefly explain how to use them. From the hardware latency detector to the latency tracers. It will also discuss the new synthetic event interface that allows users to create a histogram on the time it takes any two events to occur.
>
> I have previously discussed the latency tracers but they are soon to be obsolete, and the new synthetic event interface will be replacing them. There is still a lot more development going on with the synthetic events and this talk will briefly go over some of the new features that are yet to arrive.

## Notes

- Latency from Hardware
  - System Mangement Interrupt (SMI)
- Cache miss
- branch prediction
- Hyper-threading

- Hardware Latency detector (HWLAT_TRACER)
- fedora 31 not debian

- tracefs

Measuring latency from interrupts
