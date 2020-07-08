---
title: "2020 OSS ELC"
authors: [ "nathan-genetzky" ]

# subtitle: ""
# summary: ""
# tags: []
categories: [ "2020-oss-elc" ]
date: 2020-06-29
featured: false
draft: true

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
- name: Linux GPIO-Evolution and Current State of the User API.pdf
  url: https://static.sched.com/hosted_files/ossna2020/67/Linux%20GPIO-Evolution%20and%20Current%20State%20of%20the%20User%20API.pdf

# image:
#   caption: ""
#   focal_point: ""
#   preview_only: false
projects: [ "2020-oss-elc" ]
---

> Over the last couple years the GPIO sub-system has evolved significantly both in kernel- as well as in user-space. Certain bad design decisions made in the past - namely using a global numberspace for GPIO lines - had led to several problems that were finally addressed with the introduction of the provider-consumer, descriptor based API in the kernel and with the character device and the corresponding library - libgpiod - in user-space.
>
> The GPIO character device has been extended with new features in linux v5.5 and final new additions before declaring it feature-complete are planned for v5.6 & v5.7. The goal of these changes is to gradually move people away from the deprecated sysfs interface as well as non-upstreamable, SoC-specific solutions (e.g. /dev/gpiomem in RPi kernel) by providing users with appropriate replacement interfaces.
>
> This talk will briefly go through the basics of libgpiod and the character device (which have been already presented in the past) but mainly focus on the new features: support for pull-up and pull-down resistors, configuration changes on requested lines, the GPIO aggregator and finally the new ioctl() for monitoring state changes of GPIO lines.
