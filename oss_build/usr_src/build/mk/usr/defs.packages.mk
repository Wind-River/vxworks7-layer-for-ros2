# Makefile fragment for defs.packages.mk
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
# 19may16,brk HLD review changes
# 21mar14,brk created
#
__packages_defs = TRUE

ifndef __DEFS_VSBVARS_MK_INCLUDED
include $(WIND_KRNL_MK)/defs.vsbvars.mk
endif

ECHO  ?= echo
RM    ?= rm
PATCH ?= patch

UNZIP ?= unzip
BZIP2 ?= bzip2
GZIP  ?= gzip

TAR ?= tar

CURL ?= curl
CURL_OPT  ?= -L --output
WGET ?= wget
WGET_OPT  ?= -O

CHMOD ?= chmod

OTHER_UNPACK ?= $(ECHO) "ERROR: Unknown source type, can't extract" ; exit 1
OTHER_CHECKOUT ?= $(ECHO) "ERROR: Unknown protocol type, can't checkout" ; cd $(DOWNLOADS_DIR) && $(call __funlock,$1) ; exit 1

TOUCH = touch

VSB_SRC_DIR := $(VSB_DIR)/3pp
VSBL_SRC_DIR := $(VSB_SRC_DIR)/$(VSBL_NAME)

# TPP_STAMP_DIR is intentionall separate from VSBL_STAMP_DIR
# Stamp files are mentioned as part of the TPP HLD
TPP_STAMP_DIR = $(VSB_SRC_DIR)/.stamp
TPP_HOST_DIR  = $(VSB_SRC_DIR)/host
DOWNLOADS_DIR = $(VSB_SRC_DIR)/downloads

ROOT_DIR  ?= $(VSB_DIR)/usr/root

MAKE_STAMP    = $(TOUCH) $(TPP_STAMP_DIR)/$@

PATH := $(TPP_HOST_DIR)/usr/bin:$(PATH)
LD_LIBRARY_PATH := $(TPP_HOST_DIR)/usr/lib:$(LD_LIBRARY_PATH)
PKG_CONFIG_PATH := $(TPP_HOST_DIR)/usr/lib/pkgconfig:$(PKG_CONFIG_PATH)
PYTHONPATH := $(shell test -d $TPP_HOST_DIR && find $(TPP_HOST_DIR) -maxdepth 3 -type d -path '*/usr/lib/python*' -exec echo \{\}: \;)$(PYTHONPATH)

VPATH = $(TPP_STAMP_DIR)

PKG_BUILD_TARGETS ?=  $(PKG_NAME).install

PKG_PATCHES := $(sort $(wildcard *.patch))

PKG_CMAKE_DIR := $(PKG_SRC_DIR)

TPP_DIRS = $(VSB_SRC_DIR) $(VSBL_SRC_DIR) $(TPP_STAMP_DIR) $(DOWNLOADS_DIR)

BUILD_SYS_FILES = vxworks.make vxworks.mak vxworks.rtp.mak vxworks.lib.mak vxworks.krnl.mak config.vx.app

# shared libraries still have issues
EXE_FORMAT?=static

# prefer shared libraries if not selected
ifeq ($(EXE_FORMAT),)
ifeq ($(LIB_FORMAT),)
LIB_FORMAT := shared
EXE_FORMAT := dynamic
endif
ifeq ($(EXE_FORMAT),dynamic)
LIB_FORMAT := shared
endif
ifeq ($(EXE_FORMAT),static)
LIB_FORMAT := static
endif
endif


export LIB_FORMAT
export EXE_FORMAT
export PATH
