# Standard things

.PHONY:		targets
all:		targets


# Subdirectories, in random order

dir	:= url_io
include		$(dir)/Rules.mk
dir	:= gifr
include		$(dir)/Rules.mk


# General directory independent rules

%_32.o: %.cc
	$(COMP_32)

%_64.o: %.cc
	$(COMP_64)

%: %.o
	$(LINK)

%_x86_32.nexe: $(OBJECTS_32)
	$(LINK_32)

%_x86_64.nexe: $(OBJECTS_64)
	$(LINK_64)


# The variables TGT_*, CLEAN and CMD_INST* may be added to by the Makefile
# fragments in the various subdirectories.


.PHONY:		clean
clean:
		rm -f $(CLEAN)


# Prevent make from removing any build targets, including intermediate ones

.SECONDARY:	$(CLEAN)
