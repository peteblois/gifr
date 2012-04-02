
include $(HEADER)

# Add libpng and zlib to the dependent libs
LIBS_$(d):= png z

# Add gifr as an output target
TARGETS_$(d):= $(d)/gifr

include $(FOOTER)
