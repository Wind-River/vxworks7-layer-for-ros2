# VxWorks.cmake -- Platform Definitions for VxWorks
#
# Copyright (c) 2019 Wind River Systems, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# Toolchain file for building RTP applications against this VSB.
# Copyright (c) 2016-2018 Wind River Systems, Inc. All Rights Reserved.
#
# This file is auto-included by cmake, when CMAKE_SYSTEM = VxWorks
# It is included "late" so allows overriding improper defaults
# from the cmake auto-discovery process where appropriate.
#
# modification history
# --------------------
# 03aug18,akh added Platform/GNU
# 16Nov17,ryan Override CMAKE_ASM_COMPILE_OBJECT for ASM support.
# 18oct16,mob  written

set(VXWORKS TRUE)

SET(CMAKE_EXECUTABLE_SUFFIX ".vxe")

#include(Platform/GNU)

set(CMAKE_SKIP_BUILD_RPATH TRUE)

set(CMAKE_SYSROOT $ENV{VSB_DIR})

set(CMAKE_FIND_ROOT_PATH $ENV{PRJ_WS}/install)

set(CMAKE_INCLUDE_PATH
        /usr/root/include
        /usr/h/published/UTILS_UNIX
        /usr/h/public)

set(CMAKE_LIBRARY_PATH
        /usr/root/lib
        /usr/lib/common)

# Workaround for FindOpenSSL.cmake not knowing VxWorks library names,
# and even failing when the CRYPTO library is not there.
# TODO The proper openssl library name should be contributed to cmake.
find_library(OPENSSL_SSL_LIBRARY OPENSSL)
find_library(OPENSSL_CRYPTO_LIBRARY OPENSSL)
mark_as_advanced(OPENSSL_SSL_LIBRARY OPENSSL_CRYPTO_LIBRARY)

include(Compiler/VxWorks-$ENV{TOOL})
