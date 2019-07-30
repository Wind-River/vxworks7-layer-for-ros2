# Makefile - VxWorks extra layer Makefile
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
# 27oct18,akh  Created

include $(WIND_KRNL_MK)/defs.layers.mk

ifdef _WRS_CONFIG_UNIX
ifdef _WRS_CONFIG_RTP
USER_PUBLIC_H_DIRS += publish_h
USER_PUBLIC_H_DIR_PATH_publish_h = ../published/UTILS_UNIX
BUILD_USER_DIRS += user_src
endif
endif

include $(WIND_KRNL_MK)/rules.layers.mk
