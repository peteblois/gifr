# Standard things

sp    := $(sp).x
dirstack_$(sp)  := $(d)
d   := $(dir)

LIBS_$(d):= png z

TARGETS_$(d):= $(d)/gifr

SRCS_$(d):= $(wildcard $(d)/*.cc)

OBJS_32_$(d):= $(addsuffix _32.o,$(basename $(SRCS_$(d))))
OBJS_64_$(d):= $(addsuffix _64.o,$(basename $(SRCS_$(d))))

OBJECTS_32:= $(OBJECTS_32) $(OBJS_32_$(d))
OBJECTS_64:= $(OBJECTS_64) $(OBJS_64_$(d))

TARGETS_32_$(d):= $(addsuffix _x86_32.nexe, $(TARGETS_$(d)))
TARGETS_64_$(d):= $(addsuffix _x86_64.nexe, $(TARGETS_$(d)))

TARGETS_32:= $(TARGETS_32) $(TARGETS_32_$(d))
TARGETS_64:= $(TARGETS_64) $(TARGETS_64_$(d))

LIBS:= $(LIBS) $(addprefix -l,$(LIBS_$(d)))

CLEAN   := $(CLEAN) $(OBJS_32_$(d)) $(OBJS_64_$(d)) $(TARGETS_32_$(d)) $(TARGETS_64_$(d))

d := $(dirstack_$(sp))
sp := $(basename $(sp))

foo:
	echo $(LIBS)
