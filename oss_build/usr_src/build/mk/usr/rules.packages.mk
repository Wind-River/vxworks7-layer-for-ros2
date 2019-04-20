# Makefile fragment for rules.packages.mk
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

.PHONY: all

ifndef __packages_defs
include $(WIND_USR_MK)/defs.packages.mk
endif

ifndef __DEFS_UENV_SH_MK_INCLUDED
include $(WIND_USR_MK)/rules.env.sh.mk
endif


ifeq "$(BUILDSTAGE)" "PREBUILD"
default : prebuild
endif
ifeq "$(BUILDSTAGE)" "BUILD"
MAKE_TARGET := $(PKG_NAME).build
default : build
endif
ifeq "$(BUILDSTAGE)" "POSTBUILD"
MAKE_TARGET := $(PKG_NAME).install
default : postbuild
endif

VXWORKS_MAK ?= vxworks.mak

prebuild: $(TPP_DIRS) $(PKG_NAME).patch

# descend into the build directory after all other packaging
# steps are complete and build with vxworks.mak
#
build postbuild : $(TPP_DIRS)
	@echo building $(VSBL_NAME): $@
	if [ -z "$(VXE)" ] && [ -f $(VSBL_SRC_DIR)/$(PKG_BUILD_DIR)/$(VXWORKS_MAK) ]; then \
		$(MAKE) -C $(VSBL_SRC_DIR)/$(PKG_BUILD_DIR) -f $(VXWORKS_MAK) $(MAKE_ARGS) $(MAKE_TARGET) VXE=$(PKG_NAME) $(MAKECMDGOALS); \
	fi

$(TPP_DIRS):
	@test -d $@ || mkdir -p $@

define echo_action
	@$(ECHO) "--------------------------------------------------------------------------------"; \
	$(ECHO) "$1"; \
	$(ECHO) "--------------------------------------------------------------------------------";
endef

# obtain lock before downloading file
define __flock
	if [ -f $1.lock ] ; then \
		$(ECHO) " Waiting on $1.lock " ; \
	fi ; \
	while [ -f $1.lock ] ; do \
		sleep 1 ; \
	done ; \
	$(TOUCH) $1.lock ; \
	$(ECHO) "locked $1.lock"
endef

define __funlock
	if [ -f $1.lock ] ; then \
		$(RM) $1.lock ; \
		$(ECHO) "unlocked $1.lock" ;  \
	fi
endef

define pkg_install
	cd $(VSBL_SRC_DIR)/$(PKG_BUILD_DIR) && \
	export MAKEFLAGS='$(FILTERED_MAKEFLAGS)' &&  \
	$(MAKE_INSTALL_VAR) $(MAKE) -C $(VSBL_SRC_DIR)/$(PKG_BUILD_DIR) -f Makefile $(MAKE_INSTALL_OPT)
endef

define pkg_build
	cd $(VSBL_SRC_DIR)/$(PKG_BUILD_DIR) && \
	export MAKEFLAGS='$(FILTERED_MAKEFLAGS)' &&  \
	echo "MAKE_OPT: $(MAKE_OPT)" && \
	$(MAKE) -C $(VSBL_SRC_DIR)/$(PKG_BUILD_DIR) -f Makefile $(MAKE_OPT)
endef

define pkg_configure
	mkdir -p $(VSBL_SRC_DIR)/$(PKG_BUILD_DIR) ; \
	if [ -n "$(VXWORKS_ENV_SH)" ] && \
	   [ -f $(VXWORKS_ENV_SH) ]; then \
		. ./$(VXWORKS_ENV_SH); \
	fi ; \
	cd $(VSBL_SRC_DIR)/$(PKG_SRC_DIR) && \
	if [ -f $(VSBL_SRC_DIR)/$(PKG_CMAKE_DIR)/CMakeLists.txt ]; then \
		cd $(VSBL_SRC_DIR)/$(PKG_BUILD_DIR) ; \
		cmake $(VSBL_SRC_DIR)/$(PKG_CMAKE_DIR) \
		    $(CMAKE_TOOLCHAIN_FILE) \
		    -DCMAKE_INSTALL_PREFIX=$(CMAKE_INSTALL_PREFIX) \
		    $(CMAKE_OPT) ; \
	else \
		if [ -f configure.in -o -f configure.ac ] ; then \
			autoreconf --verbose --install --force || exit 1 ; \
		fi ; \
		if [ -f ./configure ]; then \
			cd $(VSBL_SRC_DIR)/$(PKG_BUILD_DIR) ; \
			$(CONFIGURE_VAR) $(VSBL_SRC_DIR)/$(PKG_SRC_DIR)/configure \
				$(CONFIGURE_OPT) ; \
		fi ; \
	fi
endef

define pkg_patch
	$(ECHO) "PKG_PATCHES: $(PKG_PATCHES)"
	for PATCH in $(PKG_PATCHES) ; do \
		$(PATCH) -p1 -N -d $(VSBL_SRC_DIR)/$(PKG_SRC_DIR) -p1 < $(CURDIR)/$$PATCH ; \
	done
endef

define pkg_buildsys
	mkdir -p $(VSBL_SRC_DIR)/$(PKG_BUILD_DIR) && \
	for FILE in $(BUILD_SYS_FILES) $(PKG_EXTRA_SRC); do \
		if [ -f $$FILE ] ; then \
			cp $$FILE $(VSBL_SRC_DIR)/$(PKG_BUILD_DIR) ; \
		fi  ; \
	done
endef

define fetch_svn
	$(ECHO) "fetch_svn - not yet implemented" ; \
	exit 1
endef

define stringify_url
	$1="$2" ; \
	$1=$${$1//:/.} ; \
	$1=$${$1//\//.} ; \
	$1=$${$1//\*/.} ; \
	$1="$${$1#.}"
endef

define clone_git
	$(ECHO) "clone_git " ; \
	$(call stringify_url,GIT_DIR_NAME,$2) ; \
	if [ ! -d $(VSBL_SRC_DIR)/$(PKG_SRC_DIR) ] ; then \
		cd $(VSBL_SRC_DIR) && \
		LANG=C git clone $(DOWNLOADS_DIR)/$$GIT_DIR_NAME $(PKG_SRC_DIR) --progress ; \
		if [ -n "$(PKG_COMMIT_ID)" ]; then \
			cd $(VSBL_SRC_DIR)/$(PKG_SRC_DIR) && \
			LANG=C git checkout $(PKG_COMMIT_ID); \
		fi ; \
	else \
		$(ECHO) "$(VSBL_SRC_DIR)/$(PKG_SRC_DIR) already exists." ; \
		exit 1 ; \
	fi
endef

define fetch_git
	$(ECHO) "fetch_git $1 $2" ; \
	$(call stringify_url,GIT_DIR_NAME,$2) ; \
	if [ ! -d $(DOWNLOADS_DIR)/$$GIT_DIR_NAME ] ; then \
		cd $(DOWNLOADS_DIR) &&  \
		echo LANG=C git clone --bare --mirror $2 $(DOWNLOADS_DIR)/$$GIT_DIR_NAME --progress ; \
		LANG=C git clone --bare --mirror $2 $(DOWNLOADS_DIR)/$$GIT_DIR_NAME --progress ; \
	else \
		cd $(DOWNLOADS_DIR)/$$GIT_DIR_NAME &&  \
	        LANG=C git fetch -f --prune --progress $2 refs/*:refs/* ; \
	fi
endef

define fetch_hg
        $(ECHO) "fetch_hg $1 $2" ; \
        $(call stringify_url,HG_DIR_NAME,$2) ; \
        if [ ! -d $(DOWNLOADS_DIR)/$$HG_DIR_NAME ] ; then \
                cd $(DOWNLOADS_DIR) &&  \
                echo LANG=C hg clone $2 $(DOWNLOADS_DIR)/$$HG_DIR_NAME ; \
                LANG=C hg clone $2 $(DOWNLOADS_DIR)/$$HG_DIR_NAME ; \
        else \
                cd $(DOWNLOADS_DIR)/$$HG_DIR_NAME &&  \
                LANG=C hg fetch $2 ; \
        fi
endef

define clone_hg
        $(ECHO) "clone_hg " ; \
        $(call stringify_url,HG_DIR_NAME,$2) ; \
        if [ ! -d $(VSBL_SRC_DIR)/$(PKG_SRC_DIR) ] ; then \
                cd $(VSBL_SRC_DIR) && \
                LANG=C hg clone $(DOWNLOADS_DIR)/$$HG_DIR_NAME $(PKG_SRC_DIR) ; \
                if [ -n "$(PKG_COMMIT_ID)" ]; then \
                        cd $(VSBL_SRC_DIR)/$(PKG_SRC_DIR) && \
                        LANG=C hg update $(PKG_COMMIT_ID); \
                fi ; \
        else \
                $(ECHO) "$(VSBL_SRC_DIR)/$(PKG_SRC_DIR) already exists." ; \
                exit 1 ; \
        fi
endef


define fetch_cvs
	$(ECHO) "fetch_cvs - not yet implemented" ; \
	exit 1
endef

define fetch_web
	$(ECHO) "fetch_web $1 $2 $3 $4"; \
	if [ -f $(which $(CURL)) ]; then  \
		$(CURL) $(CURL_OPT) $(PKG_FILE_NAME) $(PKG_URL) ; \
	elif [ -f $(which $(WGET)) ]; then \
		$(WGET) $(WGET_OPT) $(PKG_FILE_NAME) $(PKG_URL) ; \
	fi
endef

define fetch_ftp
	$(ECHO) "fetch_ftp $1 $2 $3 $4"; \
	if [ -f $(which $(CURL)) ]; then  \
		$(CURL) $(CURL_OPT) $(PKG_FILE_NAME) $(PKG_URL) ; \
	elif [ -f $(which $(WGET)) ]; then \
		$(WGET) $(WGET_OPT) $(PKG_FILE_NAME) $(PKG_URL) ; \
	fi
endef

# XXX
define unpack_archive
	$(ECHO) "Unpacking archive $1" ; \
	case "$1" in \
	  *.tar.bz2) \
	    $(BZIP2) -dc $(DOWNLOADS_DIR)/$1 \
	    | $(TAR) -xf - -C $(VSBL_SRC_DIR)/$2 ;; \
	  *.tgz|*.tar.gz) \
	    $(GZIP) -dc $(DOWNLOADS_DIR)/$1 \
	    | $(TAR) -xf - -C $(VSBL_SRC_DIR)/$2 ;; \
	  *.tar) \
	    $(TAR) -xf $(DOWNLOADS_DIR)/$1 -C $(VSBL_SRC_DIR)/$2 ;; \
	  *.zip) \
	    $(UNZIP) $(DOWNLOADS_DIR)/$1 -d $(VSBL_SRC_DIR)/$2 ;; \
	esac
endef

define pkg_unpack
	case "$(PKG_TYPE)" in \
		git) $(call clone_git,$(PKG_NAME),$(PKG_URL)) ;; \
		hg) $(call clone_hg,$(PKG_NAME),$(PKG_URL)) ;; \
		cvs) $(call copy_cvs,$(PKG_NAME),$(PKG_URL)) ;; \
		svn) $(call copy_svn,$(PKG_NAME),$(PKG_URL)) ;; \
		unpack) $(call unpack_archive,$(PKG_FILE_NAME),$(PKG_SRC_NAME)) ;; \
		*) $(OTHER_UNPACK) ;; \
	esac
endef

# XXX
define fetch_archive
	$(ECHO) "Fetching archive $(PKG_FILE_NAME)" ; \
	if [ -n "$(PKG_FILE_NAME)" ] && [ ! -f $(DOWNLOADS_DIR)/$(PKG_FILE_NAME) ] ; then \
		case "$(PKG_URL)" in \
			http://*) $(call fetch_web, $(PKG_NAME), $(PKG_URL), \
			            $(PKG_FILE_NAME)) ;; \
			https://*) $(call fetch_web, $(PKG_NAME), $(PKG_URL), \
			            $(PKG_FILE_NAME)) ;; \
			ftp://*) $(call fetch_ftp, $(PKG_NAME), $(PKG_URL), \
			            $(PKG_FILE_NAME)) ;; \
			*) $(OTHER_CHECKOUT) ;; \
		esac ; \
	fi ; \
	sleep 1 ; \
	if [  -f $@ ] ; then \
		if [ `du -k $@ | cut -f 1` -le 2 ] ; then \
			$(call __funlock,$1) ; \
			$(ECHO) "Download failed, file too small" >&2 ; \
			exit 1 ; \
		fi ; \
	fi
endef

define pkg_checksum
	if [ "$(PKG_FILE_TYPE)" == "unpack" ] ; then \
		if [ ! -f "$(DOWNLOADS_DIR)/$(PKG_FILE_NAME)" ] ; then \
			echo "Could not find $(PKG_FILE_NAME) in downloads" ; \
			exit 1 ; \
		fi ; \
		if [ -n "$(PKG_MD5_CHECKSUM)" ]; then \
			echo "$(PKG_MD5_CHECKSUM)  $(DOWNLOADS_DIR)/$(PKG_FILE_NAME)" | md5sum --check || \
			exit 1 ; \
		fi ; \
	fi
endef

define pkg_download
	@cd $(DOWNLOADS_DIR) && $(call __flock,$1) ; \
	case "$(PKG_TYPE)" in \
		svn) $(call fetch_svn,$(PKG_NAME),$(PKG_URL)) ;; \
		git) $(call fetch_git,$(PKG_NAME),$(PKG_URL)) ;; \
		hg) $(call fetch_hg,$(PKG_NAME),$(PKG_URL)) ;; \
		cvs) $(call fetch_cvs,$(PKG_NAME),$(PKG_URL)) ;; \
		unpack) $(call fetch_archive, $(PKG_NAME), $(PKG_URL)) ;; \
		*) $(OTHER_CHECKOUT) ;; \
	esac ; \
	cd $(DOWNLOADS_DIR) && $(call __funlock,$1)
endef

%.install : %.build
	@$(call echo_action,Installing,$(PKG_NAME))
	$(call pkg_install,$(PKG_NAME))
	@$(MAKE_STAMP)

%.build : %.configure
	@$(call echo_action,Building,$(PKG_NAME))
	$(call pkg_build,$(PKG_NAME))
	@$(MAKE_STAMP)

%.configure : $(CONFIGURE_DEPENDS) %.patch
	@$(call echo_action,Configuring,$(PKG_NAME))
	$(call pkg_configure,$(PKG_NAME))
	@$(MAKE_STAMP)

%.patch : %.buildsys
	@$(call echo_action,Patching,$(PKG_NAME))
	$(call pkg_patch,$(PKG_NAME))
	@$(MAKE_STAMP)

%.buildsys: %.unpack
	@$(call echo_action,Adding build system files,$(PKG_NAME))
	$(call pkg_buildsys,$(PKG_NAME))
	@$(MAKE_STAMP)

%.unpack : %.check
	@$(call echo_action,Unpacking,$(PKG_NAME))
	$(call pkg_unpack,$(PKG_NAME))
	@$(MAKE_STAMP)

%.check : %.download
	@$(call echo_action,Checksum,$(PKG_NAME))
	$(call pkg_checksum,$(PKG_NAME))
	@$(MAKE_STAMP)

%.download: | $(TPP_DIRS)
	@$(call echo_action,Downloading,$(PKG_NAME))
	$(call pkg_download,$(PKG_NAME))
	@$(MAKE_STAMP)
