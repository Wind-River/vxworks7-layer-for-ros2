# Makefile fragment for defs.crossbuild.mk
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

# --host and --build intentionally left to autodetect
CONFIGURE_DEPENDS = $(VXWORKS_ENV_SH) $(AUTO_INCLUDE_VSB_CONFIG_QUOTE) $(__AUTO_INCLUDE_LIST_UFILE) | $(TOOL_OPTIONS_FILES_ALL)

CONFIGURE_OPT = \
	--build=x86_64-pc-linux-gnu \
        --host=$(C_ARCH)-wrs-vxworks \
	--prefix= \
	--bindir=/$(TOOL_SPECIFIC_DIR)/bin \
	--libdir=/$(TOOL_COMMON_DIR) \
	--includedir=/include


MAKE_INSTALL_OPT = install DESTDIR=$(ROOT_DIR)
CMAKE_TOOLCHAIN_FILE = -DCMAKE_TOOLCHAIN_FILE=$(VSB_DIR)/buildspecs/cmake/rtp.cmake

