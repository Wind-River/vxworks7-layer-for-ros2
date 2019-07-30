# Makefile - makefile for extra_unix layer
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
#
# DESCRIPTION
# This file contains the makefile rules for building the extra functions
# UNIX library
#
#

LIB_BASE_NAME = unix
LIB_FORMAT = both

include $(WIND_USR_MK)/defs.library.mk

C_SOURCE := $(sort $(wildcard *.c))
OBJS=$(C_SOURCE:.c=.o)

PRE_INCLUDE := -isystem$(VSB_DIR)/usr/h/published/UTILS_UNIX

include $(WIND_USR_MK)/rules.library.mk
