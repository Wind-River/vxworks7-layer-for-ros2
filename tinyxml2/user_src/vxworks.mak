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
# 26jun18,rcw updated
# 27oct17,rpa  created

ifndef __DEFS_VSBVARS_MK_INCLUDED
include $(WIND_KRNL_MK)/defs.vsbvars.mk
endif

.PHONY: default

PKG_NAME = tinyxml2
PKG_VER = 6.2.0

PKG_BUILD_DIR = build
PKG_SRC_DIR = src

# RTP_BASE_DIR = tinyxml2

include $(WIND_USR_MK)/defs.packages.mk
include $(WIND_USR_MK)/defs.crossbuild.mk
include $(WIND_USR_MK)/rules.packages.mk
MAKE_INSTALL_OPT=install DESTDIR=$(ROOT_DIR); install -m 755 ./xmltest* $(ROOT_DIR)/$(TOOL)/bin/.
default: $(AUTO_INCLUDE_VSB_CONFIG_QUOTE) $(__AUTO_INCLUDE_LIST_UFILE) | $(TOOL_OPTIONS_FILES_ALL)
