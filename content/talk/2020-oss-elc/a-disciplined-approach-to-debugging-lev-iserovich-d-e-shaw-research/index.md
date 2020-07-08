---
title: "A Disciplined Approach to Debugging"

# subtitle: ""
# summary: ""
# tags: []
categories: [ "2020-oss-elc" ]
date: 2020-06-30
featured: false
draft: false

event: "A Disciplined Approach to Debugging"
event_url: "https://ossna2020.sched.com/event/c3UL/a-disciplined-approach-to-debugging-lev-iserovich-d-e-shaw-research"
# location: ""
# summary: ""
# abstract: ""
date: 2020-06-30
date_end: 2020-06-30
publishDate: "2020-06-29"

links:
- name: Event
  url: https://ossna2020.sched.com/event/c3UL/a-disciplined-approach-to-debugging-lev-iserovich-d-e-shaw-research

# image:
#   caption: ""
#   focal_point: ""
#   preview_only: false
projects: [ "2020-oss-elc" ]
---

## A Disciplined Approach to Debugging

> A large fraction of the time spent on software development and system design projects is used for debugging. However, effective debugging techniques are not as well-studied or formalized as those for writing code. Instead, debugging is typically tackled with ad-hoc and idiosyncratic approaches. This talk will present a systematic approach to debugging software and hardware in order to locate bugs more effectively. It will also describe a taxonomy to classify such “insects,” which should enable better code-writing practices.
>
> Debugging faulty hardware, single executables, multi-threaded programs, and distributed applications will be covered. Tips and tricks for software and hardware debugging using tools like GDB, Wireshark, gperftools, and hardware protocol analyzers will also be presented, along with examples of both common and unusual bugs caught in the wild.

## Observe

- C++ glog
- Python logging module
- Shell logger, file redirect

Logging aggregators

- splunlk
- ElasticStack
- Graphana

Check and print all return codes

- assert is friend

strace - trace system calls

gdb

- attach to running
- don't forget debug symbols
  - debug symbolts don't use too much space
- set `ulimit -c unlimited`
- compile with `-O0 for straightforward flow
  - avoids jumping around codes.

## Bisect

- with or without hypothesis
- disable parts of prgram / workflow
- switch compiler optimzation
- Only switch one variable at a time.
- trust stack
  - your code < library < compiler < OS < hardware
  - trust but verify

## Classifying

Hard error (easy)

- crash
- unrecoverable
- wrong data output
- resouce exhaustion

Soft error

- only something happens
- want to turn this into hard error

Turning soft to hard

- tracking and exceptions

## Other

### EX: Disk I/O Errors

1. IO error log in program
2. "soft error" - intermittent - EIO is unpredicatable
3. Trying other errors (`ENOENT, EPERM`)
4. Look at `errorno.h` and `errno-base.h`
5. How about `ELOOP`? Try recursive symbolic links

### Start up program

MIA

### More GDB Features

- Remote debugging with gdb-server and target command
- Watchpoints
  - `watch <extpression> (write), rwatch (read), awatch (r,w)`
  - prefer HW watchpoints. HW watchpoints are free but limited in number (4 on x86)
- Conditional breakpoints
- Observe values at each break
  - `command <breakpoint> `
  - can run command at breakpoint
- catch
  - great for C++

### EX: Debugging Hang with GDB

- App hang periodically (one every 10,0000)

- Stuck in `read()`, why?
  - `read()` is a blocking call
  - libpthread is not compiled with debug info. This is why we don't see any of the code.
- it's reading input from stdin. it is meant to read from network.

```
(gdb) info registers
```

- race between close() and read()
- object is cleaned up, and memory used for something else that sets `m_socket = 0`.
- To fix we added a flash, and then a `wait()` for the thread

### Wireshark

- wireshark is the best GUI for network capture/debug
- tcpdump to cpature output to file, then visualize with wireshark
- `man 7 pcap-filter ` for capture
  - `tcpdump -i eth0 tcp port 80 and host 142..`
- MIA

### Packet Loss

- In wireshark look for RED, which indicates errors.

### Hardware Debugging

- Observability is key
- get analyzer for any interface
- I2C/SpI
  - SAleae
  - Beagle
  - Easyi2c (win only)
- USB
  - TCpdump and wireshark support
  - modprobe usbmod
  - tcpdump -i usbmodn
- MIA

### I2C Example

- Preioidc loss of I2C bus connected to Xilinx FPGA
- Step 1 repoduce
  - increase activity on i2c
  - poll temp volt sensors
- Step 2 observe
  - IP block was encrypted
  - use logic analyzer to watch probes

I2C ANlayzer Example

- yellow - SCL CLock
- green SDA data
- zoomed region shows glitched on rise
- causes "extra clock"
- solution was to put stronger pull up
  - faster rise time
- sly770.pdf from ti.com has more info

### Questions

- Surge?
- you can create your own version of `assert` if you need to avoid it being compiled out
- `-Wall` is a good starting point.
- Use static analysis tools
- gcore will work hen process is hung
- can attach to hung process directly with gbd
- docker containers are great from debugging.
  - drop packets
  - set up docker container for other aritecture.
- How to analyze core dump
  - gdb will load up application.
  - can't step, but you can examin all information.
- gdb has great thread support
- valgrind and halgring
  - halgrind is subset tool of valgrint
  - halgrind slows down your code because it's emulating the CPU
- gdb is hard to find documentation
  - Use `gdb help`
- release debugging
  - include `-g`. symbols are worth the minor space they add, minimal performance impact.
  - don't includee `-O0` because it will slow down program
