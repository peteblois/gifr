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
BUILD_PATH:=$(abspath $(dir $(THIS_MAKEFILE))../build/gifr)

#
# Project Build flags
#
# Turns on warnings (-Wxxx), builds with zero optimization (-O0) and adds debug
# information (-g) for correctness and ease of debugging.
WARNINGS:=-Wno-long-long -Wall -Wswitch-enum -Werror -pedantic
INCLUDES:=-I$(PROJECT_ROOT)
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

OBJECTS_32:= \
	$(patsubst %.cc,$(BUILD_PATH)/%_32.o,$(wildcard *.cc)) \
	$(abspath $(dir $(THIS_MAKEFILE))../build/url_io/url_request.o)


OBJECTS_64:= \
	$(patsubst %.cc,$(BUILD_PATH)/%_64.o,$(wildcard *.cc))

RESOURCES_SRC:= index.html gifr.nmf nyan.png
RESOURCES_DST:= $(addprefix $(BUILD_PATH)/, $(notdir $(RESOURCES_SRC)))

# Default target is everything
all: \
	$(BUILD_PATH)/gifr_x86_32.nexe \
	$(BUILD_PATH)/gifr_x86_64.nexe \
	$(RESOURCES_DST)

$(RESOURCES_DST): $(RESOURCES_SRC)
	@cp -av $^ $(BUILD_PATH)

# Makes the build dir if it's not there.
$(BUILD_PATH):
	mkdir -p $(BUILD_PATH)

$(BUILD_PATH)/%_32.o: %.cc $(BUILD_PATH)
	$(CXX) -o$ $@ -c $< -m32 -O0 -g $(CXXFLAGS)

$(BUILD_PATH)/%_64.o: %.cc $(BUILD_PATH)
	$(CXX) -o$ $@ -c $< -m64 -O0 -g $(CXXFLAGS)

# Define link rule for 32 bit (-m32) nexe
$(BUILD_PATH)/gifr_x86_32.nexe: $(OBJECTS_32)
	$(CXX) -o $@ $^ -m32 -O0 -g $(LDFLAGS)

$(BUILD_PATH)/gifr_x86_64.nexe: $(OBJECTS_64)
	$(CXX) -o $@ $^ -m64 -O0 -g $(LDFLAGS)

clean:
	rm -rf $(BUILD_PATH)

# Define a phony rule so it always runs, to build nexe and start up server.
.PHONY: RUN
RUN: all
	python httpd.py
