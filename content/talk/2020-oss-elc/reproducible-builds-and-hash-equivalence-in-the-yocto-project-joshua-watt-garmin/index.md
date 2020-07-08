---
title: "Reproducible Builds and Hash Equivalence in the Yocto Project"

# subtitle: ""
# summary: ""
categories: [ "2020-oss-elc" ]
date: 2020-07-01
featured: True
draft: false

tags:
- Embedded Linux Conference (ELC)
- Build Systems
- Embedded Distributions and Development Tools
- Yocto

event: "Reproducible Builds and Hash Equivalence in the Yocto Project"
event_url: "https://ossna2020.sched.com/event/c3R9/reproducible-builds-and-hash-equivalence-in-the-yocto-project-joshua-watt-garmin"
# location: ""
# summary: ""
# abstract: ""
date: 2020-07-01
date_end: 2020-07-01
publishDate: "2020-06-29"

links:
- name: Event
  url: https://ossna2020.sched.com/event/c3R9/reproducible-builds-and-hash-equivalence-in-the-yocto-project-joshua-watt-garmin
- name: Slides
  url: https://static.sched.com/hosted_files/ossna2020/0b/Hash%20Equivalence%20and%20Reproducible%20Builds.pdf

# image:
#   caption: ""
#   focal_point: ""
#   preview_only: false
projects: [ "2020-oss-elc" ]
---

## Reproducible Builds and Hash Equivalence in the Yocto Project

-  Joshua Watt, Garmin
- [reproducible-builds](https://reproducible-builds.org/)

> As embedded Linux devices get more complex, many questions arise about the process of constructing these systems and how it can be improved. Can these complex systems be built more efficiently to reduce development time? How can developers be assured that these systems can be built reproducibly to ensure software supply chain integrity? Joshua will highlight two new features in the latest release of the Yocto project specifically designed to address these questions. The first feature is hash equivalence which reduces build times by collectively detecting when tasks have rebuilt unnecessarily and preventing rebuilds of downstream tasks. Joshua will explain how this feature works, how to apply it to your own projects, and what to expect when you do. The second feature is build reproducibility testing, which ensures that the project has binary identical outputs from one build to the next. Joshua will describe how these tests work, what they currently cover within the project, and how to enable them for your own projects. Taken together, these features improve the Yocto project’s unique ability to effectively construct complex Linux embedded systems that are cost effective and secure.

## Notes

### RunQueue

MIA

### RunQueue with Hash Equivalence

- Now each task also has `unihash`
- breaks task hash from it's upstream
- `unihash` is `tashhash` by default.
- `outhash` is calculated. Then stored in `hashserver`

Trickle down effect

- all downstream tasks will still have `taskhash` updated.
- if it's a trivial task we would like not to have to rebuild the downstream tasks.
- if the `outhash` is the same even if the `taskhash` changed, then the hashserver will set `unihash` to a certain value
  - Now this `unihash` propagates down to downstream tasks.

### Recipe Updates

Which updates work well with this hash equivalence server?

- Library updates & CVE Fixes
- Native tool updates

Output Hash Calc

- Checksum of all files and metadata that goes into an sstate object
- signature files can be found in depsig

Hash Equivalence Server

- Reference impl in bitbake
  - `BB_HASHSERVE = "auto"`
- can be shared between multiple clients
  - Specify server with BB_HASHSERVER
  - Only makes sense if you are sharing SSTATE_CACHE

Debugging Hash Equiv.

- Can configure logging in `local.conf`
  - `BB_LOGCONFG = "logconfig.json"`

Future Improvements

- Read-only hash server for CI centered workflows
  - "read-only" flag for the client
  - "read-mostly" flag for the client
- better hash equivalence database introspection tools

## Reproducable Builds

- https://reproducible-builds.org/

1. Imrpove Hash Equiv. effectiveness
2. Code archival
3. Software supply chain
   1. verify toolchain is not comprising your target

### Build FLow

- tool builds almost all the tools it needs
- compile native tools from source

### Reproducibility QA Test

- reproducible build
  - available since 3.0 (zeus) release

QA Test

- Does an 'A' and 'B' build
  - A uses sstate
  - B from scratch
- test images
  - core-image-minimal
  - core-image-full-cmdline
  - core-image-sato
- test packages formats
  - deb
  - ipk

What causes reproducibility issues?

- build path differences
- timestamp differences
- host differences
  - consider using docker container to reduce issues

diffoscope

- report non-reproducible packages in browsable HTML
- supports diff inside of archive files
  - packages (deb, ipks)
  - archives (tar, tar.xz, etc)

### Future Imrpovements

NOTE: exttool-sdk provides all the tools required to rebuild

- test more packages
  - SDK images
  - sato images
  - world images
- test rpm packages
- test final rootfs images
- test other deployed objectstest native tools
- test more architectures
  - Currently only tests x86-64
  - AArch64 would be the highest priority
- reproducible-builds.org recomended these things
  - Use DisorderFS to test for file system ordering non-reproducibility
  - Use libfaketime to do proper timestamp testing
    - psuedo library needs adjustments
    - provides fake timestamps

## Conclusions

### Community

- Freenode IRC
  - #yocto
  - #oe
- Monthly virtual planning meeting
  - First Tuesday of each month at 8:00 AM Pacific Time
- Bug triage
  - Thursday at 7:30

### Contact

- JPEWhacker@gmail
- Joshua.Watt@Garmin.com

### Questions

QA with Speaker

- restoring from sstate is called set-scene?
  - Yes, bitbake actually executes a task called do_populate_sysroot_setscene in place of of do_populate_sysroot to do the actual restoring from setsecene
- Is the hash server part of the sstate cache?
  - No. It depends on the sstate cache contents (as I'll cover in a bit), but it's a separate entity.
- Will the uni-hash always stay as the first 'equivalent' task-hask?
  - The hash equivalence server currently uses the oldest reported hash as the "canonical" unihash, but the decision is internal to the server, so other things could be done.
- What if a recipe doesn't change it all but only a referenced file (using SRC_URI) which is copied by the recipe into the roots?
  - hash equivalence is based on the output of sstate tasks, so if the file changes sstate output, then it won't be equivalent, but if the state output is the same, than it will be equivalent.
- This is true for any of the things that go into a tasks hash (files, variables, etc).
  - how does hash equivalence work in a multiconfig scenario when building for both arm32 and aarch64?
- Can you elaborate?
  - Can the path for your own tests be in a location outside of the poky repo?
- Yes. In fact, OE's QA test core will look in those paths in any layer, so you can simply drop the file in that path relative to your own layer root and it will find it.
  - Can you restate the reproducobilty project that recommend DisorderFS and Libfaketime?
reproducible-builds.org, and it's on my references slide

My Questions

- Can you comment on 'universal/' and on 'uninative' with respect to sstate?
  - uninative provides consistent native tools. allows you to use the same tools
  - really "light" container

Notes

- Paths encoded in dwarf symbols in debug symbols becomes problems
