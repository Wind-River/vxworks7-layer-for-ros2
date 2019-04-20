VxWorks® 7 Layer for ROS2
===
---

# Overview

The VxWorks 7 Layer for ROS2 provides the recipes for building the
dependencies needed by ROS2 on VxWorks.  The Robot Operating System 2 is 
a set of software libraries and tools that aid in building robot 
applications. ROS2 is a re-architecture of the framework to 
include support for new use cases.

These new use cases include:
* Teams of multiple robots
* Small embedded platforms
* Real-time systems
* Non-ideal networks
* Production environment
* Design patterns for building and structuring systems

This layer is an adapter to make standard ROS2 build and run on
VxWorks. This layer does not contain the ROS2 source, it only
contains all functions required to allow ROS2 to build and execute
on top of VxWorks. Use this layer to add the ROS2 framework to your 
user space, and to build the ROS2 example applications as RTPs.

NOTE: ROS2 is not part of any VxWorks® product. If you need help, 
use the resources available or contact your Wind River sales representative 
to arrange for consulting services.

# Project License

The source code for this project is provided under the Apache 2.0 license license. 
Text for the ROS2 dependencies and other applicable license notices can be found in 
the LICENSE file in the project top level directory. Different 
files may be under different licenses. Each source file should include a 
license notice that designates the licensing terms for the respective file.

# Prerequisite(s)

* Install the Wind River® VxWorks® 7 operating system version SR0610.

* The build system will need to download source code from github.com and bitbucket.org.  A
  working Internet connection with access to both sites is required.
* A writeable VxWorks 7 product installation that is user-writeable and may be patched with
  changes specific to building ROS2.

### Setup

Please refer to [[https://github.com/Wind-River/vxworks7-ros2-build]] for build
scripts and Docker containers to completely automate your builds.

These scripts assume that the repository for this layer will be automatically cloned
and placed in the following location:

***installDir***/vxworks-7/pkgs_v2/middleware

Please refer to the build scripts for steps on how to build ROS2 for VxWorks 7, using this
layer.

# Legal Notices

All product names, logos, and brands are property of their respective owners. All company, 
product and service names used in this software are for identification purposes only. 
Wind River and VxWorks are registered trademarks of Wind River Systems, Inc. UNIX is a 
registered trademark of The Open Group.

Disclaimer of Warranty / No Support: Wind River does not provide support 
and maintenance services for this software, under Wind River’s standard 
Software Support and Maintenance Agreement or otherwise. Unless required 
by applicable law, Wind River provides the software (and each contributor 
provides its contribution) on an “AS IS” BASIS, WITHOUT WARRANTIES OF ANY 
KIND, either express or implied, including, without limitation, any warranties 
of TITLE, NONINFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A PARTICULAR 
PURPOSE. You are solely responsible for determining the appropriateness of 
using or redistributing the software and assume any risks associated with 
your exercise of permissions under the license.
