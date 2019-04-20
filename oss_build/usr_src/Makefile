# Makefile - 3PP  Makefile for a oss_build 
#
# Copyright (c) 2018  Wind River Systems, Inc.
#
# This software is released under the terms of the 
# Python Software Foundation License Version 2
# included in this repository in the LICENSE file
# or at https://docs.python.org/3/license.html
#
# modification history
# -------------------- 
# 24sep18,akh  created

CMAKE_MODULE_DIR = buildspecs/cmake
PKG_PATCHES := $(sort $(wildcard patches/*.patch))
PKG_PATCHES_REVERTED := $(sort $(wildcard patches/*.patch.reverted))


Default : patch_unix_files install_usr_mk_scripts install_cmake_toolchain_files

install_usr_mk_scripts :
	echo "installing OSS build mk scripts"
	install -m 644 ./build/mk/usr/*.mk -t $(WIND_USR_MK)

patch_unix_files :
	echo "patching UNIX related mk files"
	for PATCH in $(PKG_PATCHES_REVERTED) ; do \
		patch -p5 -s -R -f --dry-run -d $(WIND_BUILD) <$(CURDIR)/$$PATCH  ; \
		if [ "$$?" -ne "0" ] ; then \
			echo "skipping $$PATCH already reverted" ; \
		else  \
			echo "reverting $$PATCH" ; \
			patch -R -d $(WIND_BUILD) -p5 < $(CURDIR)/$$PATCH ; \
		fi ; \
	done
	for PATCH in $(PKG_PATCHES) ; do \
		patch -p5 -s -N --dry-run -d $(WIND_BUILD) <$(CURDIR)/$$PATCH  ; \
		if [ "$$?" -ne "0" ] ; then \
			echo "skipping $$PATCH already applied" ; \
		else  \
			echo "applying $$PATCH" ; \
			patch -d $(WIND_BUILD) -p5 < $(CURDIR)/$$PATCH ; \
		fi ; \
	done

install_cmake_toolchain_files :
	echo "installing toolchain cmake files"
	mkdir -p $(VSB_DIR)/$(CMAKE_MODULE_DIR)/Platform
	mkdir -p $(VSB_DIR)/$(CMAKE_MODULE_DIR)/Compiler
	install -m 644 ./$(CMAKE_MODULE_DIR)/*.cmake -t $(VSB_DIR)/$(CMAKE_MODULE_DIR)
	install -m 644 ./$(CMAKE_MODULE_DIR)/Platform/*.cmake -t $(VSB_DIR)/$(CMAKE_MODULE_DIR)/Platform
	install -m 644 ./$(CMAKE_MODULE_DIR)/Compiler/*.cmake -t $(VSB_DIR)/$(CMAKE_MODULE_DIR)/Compiler

include $(WIND_KRNL_MK)/rules.library.mk

