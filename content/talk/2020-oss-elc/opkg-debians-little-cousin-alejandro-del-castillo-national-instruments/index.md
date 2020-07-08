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

# image:
#   caption: ""
#   focal_point: ""
#   preview_only: false
projects: [ "2020-oss-elc" ]
---

> Opkg is a lightweight package management system designed for embedded devices. It provides most of dpkg/rpm functionality at a fraction of the size. Open Embedded distributions use it extensively, as well as other resource-constrained distributions, like OpenWRT.
>
> On this talk we will cover the project architecture, as well as the design decisions that make opkg highly customizable, enabling trade-offs of speed/space. The talk will also cover the solver backend plugin mechanism, which was developed as a way to re-use existing dependency solver technologies, instead of maintaining a custom one. The backend currently supports libsolv, a very popular library used by other package managers (dnf, hawkey). The talk will explain the basics of libsolv, and how it leverages SAT solvers in the dependency package management space. It will also cover differences between the libsolv solver and the old internal solver one.
>
> Finally, Alejandro will share some thought on the future of the project, challenges and work ahead.

### Ipkg

- Ipkg 2001  Itsy bitsy package manage
- started as shell script written as C

#### Opkg

- 2008
- fork of ipkg
- adopted by open embedded

Much simplier than dpkg
