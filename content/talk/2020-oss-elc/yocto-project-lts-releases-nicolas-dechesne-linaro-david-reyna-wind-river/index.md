---
title: "Yocto Project LTS Releases - Nicolas Dechesne, Linaro & David Reyna, Wind River"

# subtitle: ""
# summary: ""
# tags: []
categories: [ "2020-oss-elc" ]
date: 2020-06-29
featured: false
draft: false

event: "2020 OSS ELC"
event_url: "https://ossna2020.sched.com/event/c3SS/yocto-project-lts-releases-nicolas-dechesne-linaro-david-reyna-wind-river"
# location: ""
# summary: ""
# abstract: ""
date: 2020-06-29
date_end: 2020-06-29
publishDate: "2020-06-29"

links:
- name: Event
  url: https://ossna2020.sched.com/event/c3SS/yocto-project-lts-releases-nicolas-dechesne-linaro-david-reyna-wind-river
- name: Type
  url: https://ossna2020.sched.com/overview/type/Embedded+Linux+Conference+%28ELC%29
- name: Slack
  url: https://osselc.slack.com/archives/C014FHZSLRY
- name: Yocto Project Long Term Support Announced
  url: https://www.yoctoproject.org/yocto-project-long-term-support-announced/
- name: youtube
  url: https://www.youtube.com/user/TheYoctoProject/
- name: Slides
  url: https://static.sched.com/hosted_files/ossna2020/34/Yocto%20Project%20LTS%20ELC%20NA%20June%202020.pdf

# https://www.twitch.tv/yocto_project
# https://stackoverflow.com/search?q=yocto+project
# https://www.facebook.com/yoctoproject/
# https://twitter.com/yoctoproject
# https://www.linkedin.com/company/yocto-project/

# image:
#   caption: ""
#   focal_point: ""
#   preview_only: false
projects: [ "2020-oss-elc" ]
---

## Yocto Project LTS Releases - Nicolas Dechesne, Linaro & David Reyna, Wind River

- Speakers: David Reyna, Nicolas Dechesne

> Many projects struggle between the requirements for Long Term Support (LTS) and cadence delivery, the balance between stability versus agility and resources.
>
> The Yocto Project is an open source project from the Linux foundation which provides tools and processes to build Linux systems. The Yocto Project makes releases every six months, and each release is maintained by the Yocto Project for a period of one year. This works great for keeping a tight integration loop with upstream. However the release cadence and the amount of changes that occur in each release make it less than ideal for certain markets. LTS releases have been one of the main feedback from our ecosystem for some time.
>
> In this talk we will review the process behind this decision which is most likely the biggest change in the project since its inception. We will present how it will be implemented, how member organizations participated through the Yocto Project Advisory Board, discuss the potential impact on the Yocto Project ecosystem, and address the lessons learned in addition to the expected shortcomings and challenges.

## Notes

- First Linux Foundation project in 2010.
- OpenEmbedded Started in 2003

### Yocto Releases

- 6 month cadence (slide-8)
- Release contains: OE-core, bitbake, meta-yocto, yocto-docs (slide 9)

### Autobuilder

- autobuilder
- 25 builders, 12+ hosts
- ptests
- Major improvements to reduce need for manual testing (slide 13)
- hash equivalence is a way to get more efficiency

### LTS background

- Longer LTS cycle
- LTS announced in March 2020
- https://www.yoctoproject.org/yocto-project-long-term-support-announced/
- Maintained for two years
- Yocto 3.1 is first LTS (dunfell)
- 20 hrs a week fo maintainer duties
- TSC is responsible for LTS releases, rpcoess and maintainer

### What is not in LTS

- meta-oe
- vendor bsp
- only test on virtualized tests
- valudate use of CVE automated tools
- replacement for vendor BSP support

### Branching

- LTS
- stable (was 12-18 months, reduced to 8? months)
- master

### contribute LTS

- submit patches to mailing list
- patches should be on master, except whne incorporating a CVE/bug fix for old version
