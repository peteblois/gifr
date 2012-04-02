
# Grab all .CC files as source files.
SRCS_$(d):= $(wildcard $(d)/*.cc)

# Generate local objects from the local source files.
OBJS_32_$(d):= $(addsuffix _32.o,$(basename $(SRCS_$(d))))
OBJS_64_$(d):= $(addsuffix _64.o,$(basename $(SRCS_$(d))))

# Add the local objects to the global objects.
OBJECTS_32:= $(OBJECTS_32) $(OBJS_32_$(d))
OBJECTS_64:= $(OBJECTS_64) $(OBJS_64_$(d))

# Generate local 32 bit and 64 bit targets from the local targets.
TARGETS_32_$(d):= $(addsuffix _x86_32.nexe, $(TARGETS_$(d)))
TARGETS_64_$(d):= $(addsuffix _x86_64.nexe, $(TARGETS_$(d)))

# Add the local targets to the global targets
TARGETS_32:= $(TARGETS_32) $(TARGETS_32_$(d))
TARGETS_64:= $(TARGETS_64) $(TARGETS_64_$(d))

# Add the local libs to the global libs.
LIBS:= $(LIBS) $(addprefix -l,$(LIBS_$(d)))

# Add all objects and targets to the clean list.
CLEAN   := $(CLEAN) $(OBJS_32_$(d)) $(OBJS_64_$(d)) $(TARGETS_32_$(d)) $(TARGETS_64_$(d))
