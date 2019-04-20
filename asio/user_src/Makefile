# Makefile - for ASIO
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
#
# modification history
# --------------------
# 26jun18,rcw updated
# 12mar18,akh  created
#

PKG_NAME = asio
PKG_VER = 1.12.0

ifeq  "$(WIND_HOST_TYPE)" "x86-win32"
PKG_URL = https://github.com/chriskohlhoff/asio/archive/asio-1-12-0.zip
PKG_FILE_NAME = asio-1-12-0.zip
PKG_TYPE = unpack
PKG_MD5_CHECKSUM = e7b27761818ba597886620c87f48a768
else
PKG_URL = https://github.com/chriskohlhoff/asio/archive/asio-1-12-0.tar.gz
PKG_FILE_NAME = asio-1-12-0.tar.gz
PKG_TYPE = unpack
PKG_MD5_CHECKSUM = 9bacab7c7c9a0e81410571f14e36cbe4
endif

PKG_LICENSE = Boost

PKG_BUILD_DIR = build
PKG_SRC_DIR = asio-asio-1-12-0/asio

# PKG_EXTRA_SRC = acinclude.m4

include $(WIND_USR_MK)/defs.packages.mk
include $(WIND_USR_MK)/defs.crossbuild.mk
include $(WIND_USR_MK)/rules.packages.mk
