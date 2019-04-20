# vxworks.mak - for rcutils
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
# 27jul18,akh  updated for SR600
# 06mar18,akh  created for EAR37 release

ifndef __DEFS_VSBVARS_MK_INCLUDED
include $(WIND_KRNL_MK)/defs.vsbvars.mk
endif

ifndef _WRS_CONFIG_CFG_RCUTILS_BUILD_SHARED_LIBRARY
AMENT_OPTIONS += -DBUILD_SHARED_LIBS=OFF
endif

ADDED_LIBS  += --as-needed -ldl

ifdef _WRS_CONFIG_CFG_RCUTILS_BUILD_TESTS
AMENT_OPTIONS += -DBUILD_TESTING=ON
PRE_INCLUDE := -isystem$(VSB_DIR)/usr/h/published/UTILS
ADDED_LIBS  += -lunix -lregex
endif

.PHONY : default

PKG_NAME = rcutils

PKG_BUILD_DIR = $(PKG_NAME)/build/$(PKG_NAME)
PKG_SRC_DIR = rcutils

$(PKG_NAME).install : em.install ament.install

include $(WIND_USR_MK)/defs.packages.mk
include $(WIND_USR_MK)/defs.crossbuild.mk
include $(WIND_USR_MK)/rules.packages.mk
include $(VSB_DIR)/buildspecs/ament/rules.ament.mk

MAKE_INSTALL_OPT = list_install_components

em.install :
	echo "Installing empy: Installing $@ for native (host) build of ament"; \
	$(TPP_HOST_DIR)/usr/bin/pip3 install empy

