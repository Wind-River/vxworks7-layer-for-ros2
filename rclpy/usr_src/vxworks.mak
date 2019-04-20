# vxworks.mak - for rclpy
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
# 12aug18,akh  created

ifndef __DEFS_VSBVARS_MK_INCLUDED
include $(WIND_KRNL_MK)/defs.vsbvars.mk
endif

ifndef _WRS_CFG_RCLPY_BUILD_SHARED_LIBRARY
ADDED_FLAGS += -DBUILD_SHARED_LIBS=OFF
endif

.PHONY : default

PKG_NAME = rclpy

PKG_BUILD_DIR = $(PKG_NAME)/build/$(PKG_NAME)
PKG_SRC_DIR = $(PKG_NAME)

ADDED_LIBS  += --as-needed -ldl

include $(WIND_USR_MK)/defs.packages.mk
include $(WIND_USR_MK)/defs.crossbuild.mk
include $(WIND_USR_MK)/rules.packages.mk
include $(VSB_DIR)//buildspecs/ament/rules.ament.mk

MAKE_INSTALL_OPT = list_install_components
AMENT_OPTIONS = "-DPYTHON_LIBRARY=$(ROOT_DIR)/common/lib$(PYTHON_VERSION)m.so" "-DPYTHON_INCLUDE_DIR=$(ROOT_DIR)/include/$(PYTHON_VERSION)m"

