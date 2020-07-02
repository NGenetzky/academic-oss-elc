---
title: "YOCTO PROJECT® DEV DAY VIRTUAL NORTH AMERICA 2020"
authors: [ "nathan-genetzky" ]

# summary: ""
# tags: []
# categories: []
date: 2020-07-02
# external_link: ""

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
# image:
#   caption: ""
#   focal_point: ""
#   preview_only: false

# Custom links (optional).
#   Uncomment and edit lines below to show custom links.
links:
- name: Event
  url: https://www.yoctoproject.org/yocto-project-dev-day-virtual-north-america-2020/

# https://wiki.yoctoproject.org/wiki/images/8/8e/DD0_Introduction_NA20.pdf
# https://wiki.yoctoproject.org/wiki/images/d/da/DD0_Introduction_NA20.pptx
# https://wiki.yoctoproject.org/wiki/images/0/02/DD1_Highly_Scalable_Build_Automation_NA20.pdf
# https://wiki.yoctoproject.org/wiki/images/a/a9/DD1_Highly_Scalable_Build_Automation_NA20.pptx
# https://wiki.yoctoproject.org/wiki/images/3/38/DD2_YoctoContainer-handout_NA20.pdf
# https://wiki.yoctoproject.org/wiki/images/d/d7/DD3_Kernel_Lab_NA20.pdf
# https://wiki.yoctoproject.org/wiki/images/e/e4/DD3_Kernel_Lab_NA20.pptx
# https://wiki.yoctoproject.org/wiki/images/0/0d/DD5_Security_Hardening_NA20.pdf
# https://wiki.yoctoproject.org/wiki/images/8/8a/DD6_Size-Optimizations_NA20.pptx
# https://wiki.yoctoproject.org/wiki/images/3/3d/DD7_CI_CD_NA20.pptx
# https://wiki.yoctoproject.org/wiki/images/2/2e/DD8_Userspace_Lab_NA20.pptx
# https://wiki.yoctoproject.org/wiki/images/c/c7/DD9_Devtool_NA20.odp
# https://wiki.yoctoproject.org/wiki/images/f/f3/DD9_Devtool_NA20.pdf
# https://wiki.yoctoproject.org/wiki/images/d/d7/DD10_Xen_Hypervisor_NA20.pdf

# url_code: ""
# url_pdf: ""
# url_slides: ""
# url_video: ""

# Slides (optional).
#   Associate this project with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides = "example-slides"` references `content/slides/example-slides.md`.
#   Otherwise, set `slides = ""`.
# slides: ""
---

## YOCTO PROJECT® DEV DAY VIRTUAL NORTH AMERICA 2020

> The Yocto Project Developer Day Virtual is a one day presentation and hands-on training event that puts you in direct contact with Yocto Project technical experts and developers. Its primary aim is to show developers how to create, customize, and optimize Linux distributions for embedded devices using the rich features, tools, and content of Yocto Project. Our knowledgeable and engaging instructors will help you better understand topics like build system workflow, working with containers, building applications, optimizing images, hardening your devices, and leveraging tools like devtool. You will also have a chance to network and put your new skills to work.

### Program

- Keynote & Welcome
- Security Hardening
- Image Size Optimization
- Reproducible Builds
- LTS
- CI/CD
- DevTool Lab
- User Space Lab
- Kernel Lab
- and more…

### Agenda

```none
9:00	30	Paul Barker, "Highly-scalable build automation"
 9:30	45	Robert Berger, "Containers and micro services", use cases: containers on host and target
10:15	15	--- Morning break ---
10:30	90	Trevor, "Kernel Lab", HANDS ON
12:00	60	--- Lunch ---
 1:00	15	BugBoard Presentation, Call to action
 1:15	30	Scott, "Security Hardening"
 1:45	30	Khem, “Techniques and tools to reduce image size with Yocto Projects"
 2:15	30	Konrad, "CI/CD"
 2:45	15	--- Afternoon break ---
 3:00	60	Rudi, User Space, HANDS ON
 4:00	30	Paul Eggelton, "DevTool"
 4:30	30	Christopher Clark & TimO, "Virtualization"
```

## Highly scalable build automation

### Solutions

Solutions?

- Buildbot
- GitLab CI
- Jenkins

Design

- ideally CI should run a single comamnd
- Ensure you can run the same scrip tlocally
- allo manual build and release manually if your CI system breaks

Pulling in other layers

- git submodule
- repo
- oe-layersetup
- kas

examin simple setup

Build environment
sstate cahce
download cache
artifact storage
log storage management interface

 Scaling up

- bigger build machine
- NVMe > SATA SSD > SATA HDD
- Verify write edurance on SSD
- Server/Workstation Hardware

CPU and RAM

- Don't blinly assume more expenseive is better
- check for single threaded bottlenecks
  - if they dominate go for high clock
  - otherwise go for high core count
- profile RAM usage

Tips

- dedicated machine not VM
- if you use docker make sure you look into settings

Benefits of Scaling Out

- developer machines can use central sstate cache
- maintain download mirror
  - license compliance 
  - protect if upstream sources disappear
- reduce single points of failure

Local Scale Out

- High speed networking
  - 10Gbps between build machines and NAS

Global Scale Out

- issues
  - Limited network speeds
  - Packet drops and errors will happen
  - may see errors accessing the cache
- server caches over https
- update cache over SSH or an API

Distributed Cache and Aritacts Storage

- Build your own storage cluster
  - Ceph, Gluster, etc
  - Minio is also an option with S3 compatbile API

### A low cost example

- meta-sancloud bsp layer

high level design

- GItlab  CI
- BackBlaze B2
- CloudFlare eliminate bandwidth costs

kas

- desrived in yaml

gitlab-ci

Build agend

- Ryzen 7 3700X
- 64GB DDR4 EEC
- 2x 1TB NVMe drives in RAID1 pair

GitLab Runner configuration

- gitlab runner has very min configuration
- limit concurrent jobs
- select the docker job executor
- register with gitlab ci

docker

- mostly use crops/yocto
- sometimes custom 

BackBlaze2

- No upload cost
- cost for download

CloudFlare

- downloads from BackBlaze via CloudClare are free
- dedicated domain
- make sure you disable browser integrity check

Uploading

- use rclone
- API key stored in gitlab-ci

MOnnthly

- Build Agents about $60 per month
- BackBlaze B2 approx $2 per month
- no long te4rm commitments

- Bitbake inc files
  - sstate
  - download mirro
- gitlab-ci
- kas config
  - kas poky
  - kas argo

Summary

- requires some sysadmin work in setup and maintenance

## 2

1. mosquitto - mqtt browker
2. telegraf - colect analyze
3. influxdb
4. Grafana

mTIG Set ups

- mTIG Stack - "classic"
- mTIG Stack - "vms"
- mTIG Stack - "containers" - microservices
- mTIG Stack - "docker-compose"

Showed Dockerfile for mosquitto

- volumes for host storage
- expose for port acces

yoctozing the setup!

- populate sdk

- building packages from source
  - time consuming task
  - normally glang magically pulls in required dependencies
  - depency hell

prebuilt binaries

- influxdb-prebuilt
- this was easier
- but
  - prebuilt binaries are packaged differently
  - how reproducable is this? not at all

package summary

- additional work is  required
- image recipe - easy
- mosquitto - easy recipe upstream
- influxdb
- telegraph

Yocto Person - get docker packages on the target

- add packages
- configure kernel

Docker on the Target

bitbaking from sources seems to be hard
prebuilt containers for the target
need docker and friends

docker architecture

Start it up

- docker-compose up
  - same as before

#### Put it all together

- container standardization

app-container-image-influxdb-prebuilt-oci

- we need minimal rootfs without kernel and meta-virtualization
- skopeo in host container or host machine
- app-container-image-oci.bb
- IMAGE_FSTYPE 'oci' from meta-virtualization
- IMAGE_CONTAINER_NO_DUMMY = "0" -> no kernel

Building container images with OE and Yocto Project Scott Murry 2018

## Kernel

- upstream linux
- linux-stable
- vendor kernel
- eveil vendor kernel (fraken-kernel)

- Install kernel, dtb
- installed is highly board specific

### Kernel Workflow multiple users

- tewaking a kernel/config or writing a kernel module using an existing BSP
- board bring-up (creating a BSP)

Kernel Workflow TODO existin BSP chang kernel

- many kernels
- linux-yocto plus tolling to use your own
- linux-yocto has variants
  - -dev, - -tiny, -rt

new BSP

- obtain kernel
- setup cross toolchain - set the processor TUNE
- configure kernel and tweak DT . lots of yocto tooling
- install kernel modules DTB

### Kernel metadata

config fragment

- hands on we use devtool
- `devtool` or `-c menuconfig` `-c diffconfig`
- filename has cfg ext

SCC

- series configuration control
- ties together config framgent or patches with extra metadata

Kernel Metadata - storage

- two places to store
  - in-tree
  - in separate repository
- regardless add the lcoation of metadata to your SRC_URI.
  - Make sure to specify "type=kmeta"

- its much more sophisticated
- can define other kernel types `KTYPE` and have featured enabled based on kernel type (`-tiny,-dev,-rt`)
  - scc files can include other scc files
  - can restrict the includes of other scc

- examples of in-tree kmeta:
  - meta-odroid
  - meta-arm
  - meta-xilinx
- example of just using *.cfg without *.scc
  - meta-raspberrypi

## Security Hardening

### Intro

Agenda

- Security Hardening?
- Basic hardening with OE/YP
- meta-security
- meta-selinux
- Updater layers
- meta-sca

- not an expert

Security Hardening?

- Securing a system by reducing its attack surface
- Remove unnecessary software/services, users
- Control network access, e.g. firewall
- Intrusion detection
- Remove/improve default passwords/users
- Updates to remove vulnerabilities
- etc.

### Why

Attackers are becoming more aware of Linux devices

- Scans of all of IPv4 are a thing, e.g. shodan.io
- Customers cannot be relied upon to not attach devices directly to the Internet
- uPnP may make device services visible unexpectedly

During ELC there were good discussions

Some presentations this week with more detailed discussion

- "Introduction to Embedded Linux Security" - Sergio Prado, Embedded
Labworks
- https://ossna2020.sched.com/event/c3XR/introduction-to-embedded-linux-security-sergio-prado-embedded-labworks#
- "IoT Developer's Guide to Building Secure IoT Devices" - Yogesh Ojha, Tata Consultancy Services
- https://ossna2020.sched.com/event/c3Tl/iot-developers-guide-to-building-secure-iot-devices-yogesh-ojha-tata-consultancy-services#

### OWASP vunerability list

### OE/YP Hardening

- Read the Fine Manual
- https://www.yoctoproject.org/docs/3.1.1/dev- manual/dev-manual.html#making-images-more-secure
- Provides some useful high-level guidelines
- Has some more detailed guidance around disabling debug features, adding users and passwords, and security related compile flags
- Mentions meta-security and meta-selinux
- Useful, but mostly a starting point

### Expanding on the FM

- oe-pkgdata-util useful for finding what package files come from

Review kernel configuration
- Security options, but also things like hardware RNG, architecture specific address space randomization
- Some more ideas
in https://www.whonix.org/wiki/Hardened-kernel
- Make sure CONFIG_DEVMEM is disabled if at all possible
- Typically used to access device registers as a workaround
- Somewhat better now with default values of STRICT_DEVMEM and IO_STRICT_DEVMEM, but using/fixing drivers and disabling is safer

It's common for BSP layers to not enable desired features...

- e.g. cgroup, namespace, netfilter, BPF support
- These become more visible when using systemd or container runtimes
- ...and to enable a lot of things you do not need
- Usually err on the side of enabling a lot of driver subsystems and drivers
- May enable DEBUG options that are problematic

- ROOTFS_READ_ONLY feature is worth considering
  - Increase difficulty for attackers
  - Secondary benefit of also being useful for implementing reset to factory default schemes
- May require development effort
  - Locally developed applications, or packages from outside oe-core may not work out of the box
  - Combining with MAC schemes such as SELinux will require some work (as labelling is done on boot)

### meta-security

- cve-check.bbclass
- SRTool (https://wiki.yoctoproject.org/wiki/SRTool_User_Page) may be useful if you need to set up an issue tracker

meta-security – Compliance

- Recipes in meta-security-compliance layer
- Lynis (https://cisofy.com/lynis) runtime system auditor
- OpenSCAP (https://www.open-scap.org)
  - Implementation of Security Content Automation Protocol
  - In simple terms, a specification of standardized naming for interaction with tools and databases
  - oscap and oscap-daemon tools for checking NIST or other databases for vulnerabilities
- These seem likely to be overkill in a lot of embedded usecases
- But perhaps still useful in a QA role

- meta-security – Runtime Scanners

### meta-selinux

### meta-sca

- https://github.com/priv-kweihmann/meta-sca
- Collection of static analysis tools maintained by Konrad Weihmann
- Static analysis for C, C++, python, etc.
- Classes to enable per package or per image scanning (some limits depending on specific tools)
- Significant documentation
- Actively maintained

### Summary

- Updater layers – meta-swupdate
- Updater layers – meta-mender
- Updater layers – meta-updater
- meta-sca - Collection of static analysis tools maintained by Konrad Weihmann

## Khem, “Techniques and tools to reduce image size with Yocto Projects"

### Wrigel the Third

- Docker, DockerSwam
- Designed for easy setup of small cluters
- internal build and in AWS
- https://github.com/WindRiver-OpenSourceLabs/ci-scripts

WR setup tool and git-repo

- git-repo manages large tree of repos
- manifest generation by setup tool
- git repo detects changes across entire tree
- automatic rebase of local commits when syncing
- con: fork with support for bare repos

setup tool and layerindex

- dicovery and depenendecy management
- bitbake-layers layerindex-fetch is based on some of that

### Developer builds

- repo detects commits
- fork repos and store commits on git server
- containerized layerindex uses forks
- recreate local buildarea on buildsystem

- CONTAINERIZE layerindex???

- start_devbuild.sh

### Build Failure Login

- developer can't reproduce build failure on build server
- save docker container startup command
- create temp ssh key, upload build server
- add authorize key entry to run docker on login
- build environment perfectly recreated
- cleanup key
- workspace_login.sh

- https://lava.ciplatform.org/

### Summary

- expose large compuse to developers
- build and test patches before commit
- build failures inspection
- integration with runtime testing

### Demo

- OERuntimeTestCase
- searching layers in devbuild for local commits

- yocto autobuilder helper scripts
- awe to scale builds
- k8s and tekton
- yocto self-hosted AMIs

- spot instances are a great deal

### Questions

- try to prefer docker volumes.
- host path can be performant

- Add tmpfs at the common tmp locations. Some recipes misbehave.
- you can do docker run and verify that nothing in overlay has changed.
