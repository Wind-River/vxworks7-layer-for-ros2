# vxworks.mak - for Fast-RTPs
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
# Modification history
# --------------------
# 24juj18,akh updated cmake options
# 27jun18,rcw updated
# 2oct17,cai  created
#

ifndef __DEFS_UVSBVARS_MK_INCLUDED
include $(WIND_USR_MK)/defs.vsbvars.mk
endif

.PHONY: default

PKG_NAME = fastrtps

PKG_BUILD_DIR = fast-rtps/build
PKG_SRC_DIR = fast-rtps

ADDED_LIBS  += -lunix -lregex -lnet

CMAKE_OPT = -DTHIRDPARTY=OFF \
	    -DASIO_INCLUDE_DIR="$(VSB_DIR)/usr/h/public" \
	    -DTinyXML2_DIR="$(ROOT_DIR)/lib/cmake/tinyxml2" \
	    -DTINYXML2_INCLUDE_DIR="$(ROOT_DIR)/include" \
	    -DTINYXML2_LIBRARY="$(ROOT_DIR)/lib/libtinyxml2.so" \
	    -Dfastcdr_DIR="$(ROOT_DIR)/lib/fastcdr/cmake" \
	    -DADDED_INCLUDES="$(EXTRA_INCLUDE)"

MAKE_OPT += VERBOSE=1

include $(WIND_USR_MK)/defs.packages.mk
include $(WIND_USR_MK)/defs.crossbuild.mk
include $(WIND_USR_MK)/rules.packages.mk
