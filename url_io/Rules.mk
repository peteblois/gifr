# Standard things

sp    := $(sp).x
dirstack_$(sp)  := $(d)
d   := $(dir)


SRCS_$(d):= $(wildcard $(d)/*.cc)

OBJS_32_$(d):= $(addsuffix _32.o,$(basename $(SRCS_$(d))))
OBJS_64_$(d):= $(addsuffix _64.o,$(basename $(SRCS_$(d))))

DEPS_$(d)	:= $(OBJS_$(d):%=%.d)

DEPS:= $(OBJS_$(d))
OBJECTS_32:= $(OBJECTS_32) $(OBJS_32_$(d))
OBJECTS_64:= $(OBJECTS_64) $(OBJS_64_$(d))

CLEAN   := $(CLEAN) $(OBJS_32_$(d)) $(OBJS_64_$(d))

# Local rules

$(OBJS_$(d)):	CF_TGT := -I$(d)

-include	$(DEPS_$(d))

d := $(dirstack_$(sp))
sp := $(basename $(sp))
