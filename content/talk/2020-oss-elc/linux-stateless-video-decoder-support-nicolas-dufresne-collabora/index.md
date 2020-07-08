---
title: "Linux Stateless Video Decoder Support"

# subtitle: ""
# summary: ""
categories: [ "2020-oss-elc" ]
date: 2020-06-30
featured: false
draft: false

tags:
- Embedded Linux Conference (ELC)
- Audio
- Video
- Streaming Media and Graphics
- Linux

event: "Linux Stateless Video Decoder Support"
event_url: "https://ossna2020.sched.com/event/c3VY/linux-stateless-video-decoder-support-nicolas-dufresne-collabora"
# location: ""
# summary: ""
# abstract: ""
date: 2020-06-30
date_end: 2020-06-30
publishDate: "2020-06-30"

links:
- name: Event
  url: https://ossna2020.sched.com/event/c3VY/linux-stateless-video-decoder-support-nicolas-dufresne-collabora

# image:
#   caption: ""
#   focal_point: ""
#   preview_only: false
projects: [ "2020-oss-elc" ]
---

## Linux Stateless Video Decoder Support

- Nicolas Dufresne, Collabora

> While it has been under development for years, the support for video CODEC accelerators has gain a lot of traction in past year. A formal specification has now been merge into Linux Media subsystem and staging control APIs and drivers now exist. This allow for blob free HW accelerated decoding on popular SoC like Allwinner, i.MX8 and Rockchip.
>
> In this talk, Nicolas will give an overview of the decoding process using such hardware accelerators along with an overview of the user space API and how it's used within multimedia frameworks. Nicolas will also explain the relation between this and accelerators attached to modern GPUs. This presentation would not be complete without mentioning the development of FFMPEG and GStreamer native support and their major role in the development of the the new Open Source drivers.
>
> This talk is addressed to multimedia enthusiasts and developers curious about video decoding and the upstream effort effort to make that available to users.

## Notes

## State-full Decoder

Begining of Linux Codecs

What is state-full?

- stateful is a blackbox
- blackbox gets bitstream

### V4L2 M2M

```none
output -> VPU -> capture
```

- V4L2 output queue is used for the bitstream
- capture queue is used for the decoded pictures
- capability to seek and end stream

### Pro/cons

- pro: minimal per codec code needed
- con: require a firmware
- con: harder to multiplex

CODA Driver

- Enabling iMX51 and iMX6
- reversed enginerring from imx binary blobs

### Begining of State-Less

2015

- Rockchip
- new type of CODEC hardware
- Rockchip VDPU

What is State-Less

- no processor
- expose "accelarators"

- 1. inputs:
  - reference
  - bitstream
  - parameters
- 2. accerator
- 3. outputs
  - pictures
  - may not be in order

What are GPU?

- Crafting command stream is HW specific
- only implement in userspace drivers (mesa)
- commands are schedule by the GPU driver
- multiple GPU hardware in the same application remains tedius

This is not what google did!

### V4L2 M2M + Request (2015)

Instead, extend stateless: V4L2 M2M + Request

Added components

- CODEC Controls
- Request
- Topology

- Request API
  - way to queue parameters, controls, and bitstream buffers
  - added to media controller API

### H.264

- NALU Sequence
  - SPS, PPS, IDR Slice, P Slice, B Slice
  - P previous decoded pictures
  - both past and future references
- Annex B NALU
  - Start-Code
  - HDR, Paylod
- AVCc NALU
  - Size
  - HDR, Payload

### Decoding Process

- MIA... Missed one slide

- Fill SPS/ PPS, Decode Parameters, Slice parameters
- Modify reference list
- Decode the slide/frame
- Do DPB management as per spec
  - Display Picture management
- Output frames that could be re-ordered

### V4L2

- Allocate a Request (an FD)
- set per frame
- queue a v4l2_buffer
- queue the request
- poll the request FD for completion

### Continue in time

MediaTek VPU (State-full)

- tiled output only (requires HW converter)

Qualcomm Venus

- Stateful
- lots of CODECS

Upstreaming Stalled

- Could not settle on the Request/Job API
- Low knowledge of CODEC decoing process by the linux-media maintainers
- only one hardware to test the API design (Only rockchip)
- No formal specific (not that state-full CODEC had one either)

### Allwinner VPU support Kickstarter by Bootlin (2018)

- Request API is finalized
- MPEG2 Support in Staging
- H.264 support was progressing (but only sliced based)
- reverse engineered from binary userspace
- VAAPI userspace drivers

2019

- formal specification was merged
- RK3288 driver was mainlined
- H264, VP8, HEVC uAPI added as staging control API
- RK3288 driver was renamed?

The Hantro Driver

- I.MX8M Quad, using Hantro G1/G2
- Registry compatible with the RK3288
- Give email and you get specification

Hantro Company

- Hantro Visibility Better
- on2 technology
- Google
  - VP8 and VP9 royalty free
- VeriSilicon

Other story of API rename

- stmmac is an ethernet driver, that was thought to be STM design
- later found to be DesignWare design, shared across numerous SoC
- Since API was released it was unable to be renamed

Testing and Fixing

- LibreELEC - just enough OS for KODI
  - FFMPEG support
  - bug fixing
  - interlaced Content Support

2020

- RK3399 JPEG, MPEG2, H.264, and VP9 support
- Start having base class for Stateless
  - DXVA2 and NVDEC support
- VA V4L2 Request driver was abandoned

## demo

- linux kernel 5.7rc2
- gstreamer has tool called 'gst-build' built on mesin
  - allow you to run plugin
  - gst-play-1.0
- video layers are an overlay
- prerolling.
- three different streams
- one two iMx8

## Questions

- performance stateless vs state-full
  - have to wake up processor more
  - more control over queuing
- converting them to state-less is complex

