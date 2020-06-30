---
title: "Robot Operating System (ROS) 2 - How Open Source Software and Linux is Powering the Next Generation of Robotics"
authors: [ "nathan-genetzky" ]

# subtitle: ""
# summary: ""
categories: [ "2020-oss-elc" ]
date: 2020-06-30
featured: false
draft: false

tags:
- Embedded Linux Conference (ELC)
- Open Source Project Updates

event: "Robot Operating System (ROS) 2 - How Open Source Software and Linux is Powering the Next Generation of Robotics"
event_url: "https://ossna2020.sched.com/event/c3TE/robot-operating-system-ros-2-how-open-source-software-and-linux-is-powering-the-next-generation-of-robotics-katherine-scott-open-robotics"
# location: ""
# summary: ""
# abstract: ""
date: 2020-06-30
date_end: 2020-06-30
publishDate: "2020-06-30"

links:
- name: Event
  url: https://ossna2020.sched.com/event/c3TE/robot-operating-system-ros-2-how-open-source-software-and-linux-is-powering-the-next-generation-of-robotics-katherine-scott-open-robotics

# image:
#   caption: ""
#   focal_point: ""
#   preview_only: false
projects: [ "2020-oss-elc" ]
---

## Robot Operating System (ROS) 2 - How Open Source Software and Linux is Powering the Next Generation of Robotics

- Katherine Scott, Open Robotics

> Robot Operating System (ROS) is a set of mature free and open source software packages used by the robotics community to program robots. Recently ROS had its first major version upgrade in a decade to ROS 2. This new version introduces a number of changes and new features, many of which simplify the development process and allow users to build virtual robots without ever touching a piece of hardware. ROS 2 is the version of ROS that supports Python 3 out of the box and has new additions that allow for high-fidelity simulations. Simulation makes learning advanced robotics topics more accessible, as you no longer need to outfit a robotics lab and you can simulate cutting edge hardware for free. In this talk we'll cover the state of the open source robotics ecosystem and cover the changes made in ROS 2 to improve its simplicity, stability, safety, and security. These features, along with enhanced embedded hardware support, are helping ROS become the de facto standard for the developers of autonomous vehicles, drones, industrial, and agricultural robots. This talk will give the Linux community and update on ROS ecosystem and a starting point for learning how to use it. 

## Notes

- ROS is a lyer on top of Linux for robots
- metrics.ros.org

### Windows

- works on Windows
- vscode

### Intro

#### Software before times

- research grade
- proprietary
- works on Windows 95
- system integrators
- vendors
- bespoke
- hardware controllers
- Feed forwards

Catalyst

- 2004 competition for autonomous vehical

Input to innovation

- flexible robots
- IPO
- FOSS
- Willow Garage - 2007 Poof FOOS for robots

Three projects results

- opencv
- pcl
- ROS

Two Robots born

- Willow: Shared World Class Research
- 2013 Willow Folders but OS lives on

Ethos of Global Research Community

- Small, Simple, Composable Utilities
- Don't Reivent the Wheel
- Non-Exclusive (polyglot, packagin infrastructure)
- Inclusive (in addition to, not in place of)
- Freedom

Out of Willow was born:

- OpenRobotics
- ROS Industrial

## ROS Philosophy

- Federation over Centralation

Plus list from above.

- Small, Simple, Composable Utilities
- Don't Reivent the Wheel
- Non-Exclusive (polyglot, packagin infrastructure)
- Inclusive (in addition to, not in place of)
- Freedom

Order of topics

1. Don't Reinvent

### Dont Reinvent

Multiprocess Control

- Components
  - Sensors
  - Control
  - actuators
- nodes are process encapsulation between languages
- Imagine
  - C++ Python programs all start concurently
  - with hardware
  - lots of config
  - control flow based on config
  - What would your shell script file look like?
  - ROS nodes and launch files take care of this
  - Tooling to start them.

Topics

- pub/sub bus
- ROS nodes communicate over topics
- Cross language serialation primitives that predate protobuff, rabbitMQ, etc.
- Standard messages allow
  - plug and play
  - loose coupling
- Online introspection
- quality of service capabilities
- build as an abstraction
  - DDS implementation, ensures security, robustness
  - implementation of pub/sub is pushed off to other implementation

RVIZ

- Robots make lots of data
  - much of it is live
  - with 3D context
  - annotation
- RVIZ is your GUI

[Bags](http://wiki.ros.org/Bags)

- standard serialzation library for transport also works for disk storage
  - MIA
- bags are amazing
  - ML/CV/DL
  - unit tests
  - collaborators
  - Black Box
- collect on robot and transfer elsewhere for analysis
- De-facto standard for sharing data
  - Ford Autonomous Vehical Data
- http://wiki.ros.org/ROS/Tutorials/Recording%20and%20playing%20back%20data

Services/Actions

- Services: synchronous behavior API
- Action: async behavior
  - Handles request negotation
  - with preemption
  - with status callbacks
- Callback driven API
- build robot behvaiors, fast

Geometry/Kinematics

- Hard robot problems
  - where is everything
  - where am I
  - how to get A to B
  - I can see X, how to graph it
  - Many more
- URDF: Universal Robot Description Format
  - Defines 3D Geometry of a Robot
  - Works with your CAD format
  - gives a robot an idea of its shape and size
- TF2 Transform 2
  - transform coordinates from different frames
  - API driven, minimal math

Forward/Inverse Kinematics

- MoveIt

SLAM/Navigation

- Path planning

Simulation

- Robots are expensive, dangerous, slow
- sharing a robot is hard
- testing is hard
- what if you don't need robot?
- What if you could have robot VM?

Simulation - Gazebo

- build a virtual robot
- simulate Physics, robot, and sensors
- Plays well with ROS2
- Allows yo build test debug from your desk

## ROS: Getting to Plug and Play Hardware

- Hardware Ready
- Bridge between ROS 2 DDS layer and ROS

## Community not just Code

- ros.org
- discourse.ros.org
- answers.ros.org

## ROS 2 Foxy

- 6th Ros 2 Release
- First major LTS
- Start now 3 year of patches and supports

I want to learn!

- DARPA SubT Simulator has great tutorial
- Autoware has Autonomy class
  - Prepackaged docker container to run simulation
  - [awf-course](https://autoware.org/awf-course)
- [ROS 2 Docs](index.ros.org/doc/ros2)
- TurtleBot3

## Contact

- rosorg
- kscottz
- org.org
- openrobics

## Questions

- Q: Gazebo included?
- A: No

- Q: I work on embedded projects that run on custom hardware for fancy PTZ cameras. I would love to convience our Python app developers how/if ROS could be leveraged. Where do you think I should start? Are their any consultants that could help analysis the specific use case?
- A: This is something we are missing.  She views robots broadly. MicroROS. Developing concepts for hardware. hardware interface framework.

- Start with simulation
