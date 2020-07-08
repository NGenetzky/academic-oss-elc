---
title: "Tutorial: Debugging Embedded Devices Using GDB - A Review of Some Lessons Learned"

# subtitle: ""
# summary: ""
# tags: []
categories: [ "2020-oss-elc" ]
date: 2020-06-29
featured: false
draft: false

event: "Tutorial: Debugging Embedded Devices Using GDB - A Review of Some Lessons Learned"
event_url: "https://ossna2020.sched.com/event/chs2/tutorial-debugging-embedded-devices-using-gdb-a-review-of-some-lessons-learned-mike-anderson-the-ptr-group"
# location: ""
# summary: ""
# abstract: ""
date: 2020-06-29
date_end: 2020-06-29
publishDate: "2020-06-29"

links:
- name: Event
  url: https://ossna2020.sched.com/event/chs2/tutorial-debugging-embedded-devices-using-gdb-a-review-of-some-lessons-learned-mike-anderson-the-ptr-group

# image:
#   caption: ""
#   focal_point: ""
#   preview_only: false
projects: [ "2020-oss-elc" ]
---

## Tutorial: Debugging Embedded Devices Using GDB - A Review of Some Lessons Learned

- Mike Anderson, The PTR Group

> Linux has an incredible selection of tools for both debugging and profiling applications to get the most out of the system. In this session, we will start with gdb and show many of the lesser-known features that can significantly shorten debugging time. Next we will focus on the profiling and code coverage features found in gprof/gcov for determining both the performance of function calls and whether your test code is actually testing all of the code that it needs to test via examining the code coverage of the execution. Next, we will go into more sophisticated approaches using strace, ftrace, oprofile and LTTng and show how they work and why you might choose one over the other for certain tasks.

## Notes

What we will talk about

- GNU project, gcc and gdb
- gdb CLI, TUI and gdbfront-ends
- help, scripts, macro
- attach to running app
- breakpoints, watchpoints and more
- fdbserver
- strace
- gprov/gcov
- valgrint
- LTTng and Ftrace

GNU Project

- GNU: GNU's Not Unix
- front-end laguage parser and back-end code generator
- numerous 'binutils' such as the linker, libraian

Line debug levels

- g0 produce no debug info
- g1 produce minimal info, enought for back trace, no info about local var and no line num
- g2 default debug level
- g3 extra info, macro definitions
- `-ggdb3` debug infor for gdb more than COFF,XCOFF or DWARF2 fof -g

Example

```shell
arm-linux-gnueabi-gcc -ggdb3 -o hello helloWorld.c
arm-linux-gnueabi-objdump -h hello
```

GDB GUI

- ddd Data Display Debugger
  - ddd supports: gdb, jdb, Python, Perl, TCL, and PHP
  - debugger arm-linux-gnueabi-gdb myapp
- MS Visual Studio Code

GDB help

- aliases
- breakpoints
- data
- files
- internals
- obscure
- running
- stack
- status
- support
- tracepoints
- user-defined

### gdb script

- `.gdbinit` in current directoy

useful init

```
set history save on
set print pretty on
set pagination off
set confirm off
```

`gdb -x` load at load time

gdb has built in python interpreter Just call `python`.

### Working with Signals via gdb

Print table of how gdb will handle each signal:

`info handle `

Ways GDB can handle signla

- nostop
- stop
- print
- no-print
- pass
- nopass

handle signal keywords

signal SIGSEGV - deliver SEGV signal to the current program

### Load/Execute your code

- Use 'file <filename>' to loca additional files
- Helpful for using with kgdb

### watchpoints

```shell
watch -l <address/symbol> # command is scope aware
rwatch <a/s> # stops if read
watch <a/s> thread 3 # stops if thread 3 modified
watch <a/s> if <a/s> > 5 # stops when contents > 5
```

### gdbserver Cross Debug Example

```
gdbserver 192.168.7.1:1929 myapp &
(gdb) target remote 192.168.7.2:1929
```

gdbserver hostIP:2345 --attach PID

- workds within GUI based fron-ends as well


### strace

watch system called made from user space.

```
strace -c ./capture_stream -D /dev/video0 -w 764*331 -p 1 | ./viewer -w 680*480 -p 1
```

### ltrace

- ltrace allows us to trace library calls
- strace for libraries

### Ftrace (function tracer)


### Kernelshark

- https://kernelshark.org/
- https://kernelshark.org/Documentation.html
- https://lwn.net/Articles/425583/
- TRACE-CMD The front-end application to Ftrace. The back-end application to KernelShark.
