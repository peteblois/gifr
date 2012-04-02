
THIS_MAKEFILE:=$(abspath $(lastword $(MAKEFILE_LIST)))
PROJECT_ROOT:=$(abspath $(dir $(THIS_MAKEFILE)))
NACL_SDK_ROOT?=$(abspath $(dir $(THIS_MAKEFILE))../nacl_sdk/pepper_18)

WARNINGS:= -Wno-long-long -Wall -Wswitch-enum -Werror -pedantic
CXXFLAGS:= -pthread -O0 $(WARNINGS)
LDFLAGS:= -lppapi_cpp -lppapi
INCLUDES:= -I$(PROJECT_ROOT)

#
# Compute path to compiler
#
OSNAME:=$(shell python $(NACL_SDK_ROOT)/tools/getos.py)
TC_PATH:=$(abspath $(NACL_SDK_ROOT)/toolchain/$(OSNAME)_x86_newlib)

# Alias for C compiler
CXX:=$(TC_PATH)/bin/i686-nacl-g++

COMP_32            = $(CXX) -o$ $@ -c $< -m32 -O0 -g $(CXXFLAGS) $(INCLUDES)
COMP_64            = $(CXX) -o$ $@ -c $< -m64 -O0 -g $(CXXFLAGS) $(INCLUDES)
LINK_32            = $(CXX) -o $@ $^ -m32 -O0 -g $(LDFLAGS) $(LIBS)
LINK_64            = $(CXX) -o $@ $^ -m64 -O0 -g $(LDFLAGS) $(LIBS)
COMPLINK        = $(CXX) $(CXXFLAGS) $(CF_TGT) $(LDFLAGS) $(LF_TGT) -o $@ $< $(LL_TGT) $(LL_ALL)
DEPS:=

HEADER:=$(abspath $(PROJECT_ROOT)/header.mk)
FOOTER:=$(abspath $(PROJECT_ROOT)/footer.mk)

include Rules.mk


all: $(TARGETS_32) $(TARGETS_64)

