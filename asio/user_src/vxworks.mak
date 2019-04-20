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
# 12mar18,akh created

ifndef __DEFS_VSBVARS_MK_INCLUDED
include $(WIND_USR_MK)/defs.vsbvars.mk
endif

ifneq ($(wildcard $(VSB_MAKE_CONFIG_FILE)),)
include $(VSB_MAKE_CONFIG_FILE)
endif


.PHONY : default

PKG_NAME = asio
PKG_VER = 3.2.1

PKG_NAME = asio
PKG_VER = 1.12.0

PKG_BUILD_DIR = build
PKG_SRC_DIR = asio-asio-1-12-0/asio

ADDED_LIBS := -lunix -lnet

include $(WIND_USR_MK)/defs.packages.mk
include $(WIND_USR_MK)/rules.env.sh.mk
include $(WIND_USR_MK)/defs.crossbuild.mk

ifdef _WRS_CONFIG_CFG_ASIO_WITHOUT_BOOST
CONFIGURE_OPT += --without-boost
endif

include $(WIND_USR_MK)/rules.packages.mk
default: $(VXWORKS_ENV_SH) $(AUTO_INCLUDE_VSB_CONFIG_QUOTE) $(__AUTO_INCLUDE_LIST_UFILE) | $(TOOL_OPTIONS_FILES_ALL)
