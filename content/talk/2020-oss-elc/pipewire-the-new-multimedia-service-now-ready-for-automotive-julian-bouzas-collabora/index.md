---
title: "PipeWire: The New Multimedia Service, Now Ready for Automotive"

# subtitle: ""
# summary: ""
tags:
- Linux
categories: [ "2020-oss-elc" ]
date: 2020-06-29
featured: false
draft: false

event: "PipeWire: The New Multimedia Service, Now Ready for Automotive"
event_url: "https://ossna2020.sched.com/event/c3TN/pipewire-the-new-multimedia-service-now-ready-for-automotive-julian-bouzas-collabora"
# location: ""
# summary: ""
# abstract: ""
date: 2020-06-29
date_end: 2020-06-29
publishDate: "2020-06-29"

links:
- name: Event
  url: https://ossna2020.sched.com/event/c3TN/pipewire-the-new-multimedia-service-now-ready-for-automotive-julian-bouzas-collabora
- name: Slides
  url: https://static.sched.com/hosted_files/ossna2020/8d/pipewire-slides.pdf

# image:
#   caption: ""
#   focal_point: ""
#   preview_only: false
projects: [ "2020-oss-elc" ]
---

## PipeWire: The New Multimedia Service, Now Ready for Automotive - Julian Bouzas, Collabora

> PipeWire is the new emerging open source project that aims to greatly improve both audio and video handling on Linux systems, both desktop and embedded. It was recently adopted by Automotive Grade Linux as the core audio framework because its design's flexibility makes it possible to address automotive requirements, replacing entirely previous solutions and addressing new use cases such as achieving ultra low latency with zero-copy media exchange, and allowing external session managers to define device policy logic.
>
> In this talk, Julian is going to present the PipeWire project, how it evolved to overcome the automotive industry use cases, and what the current upstream status is. Julian will also present the WirePlumber policy management framework, which makes it easy to write use-case specific policy systems. 

## Notes

### Intro

Fresh multimedia service for Linux

- originally mean for video only: PulseAudio for Video (PulseVideo)
- video capture
  - cameras
  - graphic sources (wayland, vulkan, OpenGL)
- Audio playback and capture
  - microphone and speaker
  - bluetooth device

Why do we need Pipewire

- Unified both pulseaudio and Jack audio servers
- Permissions, support for container
- Low Latency
  - designed for small buffer sizes
  - (1-2ms of latency)
- Flexible: external session manager adaptable to any use cases
  - can write your own session manager

### Architecture and Design

Multimedia stack

- DRM
- PipeWire: Layer between Kernel and Applications
- DRM -> Wayland compositor -> PipeWire
- Kernel devices: DRM, V4L2, Bluetooth, Alsa
- PipeWire Sessions Manager

Compatibilities APIs on top of PipeWirte

- Alsa
- Pulse AUdio
- JACK

Architecture and Design

- Modular with Plugin
- Graph based like GStreamer: Nodes, ports and Links
- Multi-Process
  -  external session manager configures and links the nodes
  -  daemon processes most of the data
- Fully based on internal and simple plugin API library (SPA)
  - extremely simple lightweight generic purpose multimedia libraries
  - mostly header-only C library

Pipewire is very performant

- Uses modern Linux Kernel APIs

Security
- External session manager grants permission

Permissions

- read - Visable, capture data
- write, play data
- execute: allow executing methods on object (setup format on nodes)

Adopted

- Version 0.3.5 released in May 2020 and distributed in Fedora 32
- Adopted by AGL

### pipewire dot tool

Generates DOT graphs `pw-dot pw.dot`

### WirePlumber Design

- application that loads modules that were written with that library
- allows external session manager
- Plan to add PYthon/Rust bindings

Wire plumber Versions

- v0.3.0 (2020 June) first version with desktop support

- `pavucontrol` can still be used to control audio
