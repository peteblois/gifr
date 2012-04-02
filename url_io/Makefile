# Copyright (c) 2012 The Native Client Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

#
# GNU Make based build file.  For details on GNU Make see:
#   http://www.gnu.org/software/make/manual/make.html
#


#
# Get pepper directory for toolchain and includes.
#
# If NACL_SDK_ROOT is not set, then assume it can be found a two directories up,
# from the default example directory location.
#
THIS_MAKEFILE:=$(abspath $(lastword $(MAKEFILE_LIST)))
PROJECT_ROOT:=$(abspath $(dir $(THIS_MAKEFILE))..)
NACL_SDK_ROOT?=$(abspath $(dir $(THIS_MAKEFILE))../../nacl_sdk/pepper_18)
BUILD_PATH:=$(abspath $(PROJECT_ROOT)/../build/url_io)


#
# Project Build flags
#
# Turns on warnings (-Wxxx), builds with zero optimization (-O0) and adds debug
# information (-g) for correctness and ease of debugging.
INCLUDES:=-I$(PROJECT_ROOT)
WARNINGS:=-Wno-long-long -Wall -Wswitch-enum -Werror -pedantic
CXXFLAGS:=-pthread -O0 $(WARNINGS) $(INCLUDES)
LDFLAGS:=-lppapi_cpp -lppapi

#
# Compute path to compiler
#
OSNAME:=$(shell python $(NACL_SDK_ROOT)/tools/getos.py)
TC_PATH:=$(abspath $(NACL_SDK_ROOT)/toolchain/$(OSNAME)_x86_newlib)


# Alias for C compiler
CXX:=$(TC_PATH)/bin/i686-nacl-g++

#
# Disable DOS PATH warning when using Cygwin based tools Windows
#
CYGWIN ?= nodosfilewarning
export CYGWIN

OBJECTS:= \
	$(patsubst %.cc,$(BUILD_PATH)/%_32.o,$(wildcard *.cc)) \
	$(patsubst %.cc,$(BUILD_PATH)/%_64.o,$(wildcard *.cc))

# Default target is everything
all: $(OBJECTS)

$(BUILD_PATH)/%_32.o: %.cc $(BUILD_PATH)
	$(CXX) -o$ $@ -c $< -m32 -O0 -g $(CXXFLAGS)

$(BUILD_PATH)/%_64.o: %.cc $(BUILD_PATH)
	$(CXX) -o$ $@ -c $< -m64 -O0 -g $(CXXFLAGS)

# Makes the build dir if it's not there.
$(BUILD_PATH):
	mkdir -p $(BUILD_PATH)

clean:
	rm -rf $(BUILD_PATH)

