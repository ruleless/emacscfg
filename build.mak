MAKE=make
RM=-rm -rf

# dirs:=$(shell find . -maxdepth 1 -type d)
# dirs:=$(basename $(patsubst ./%,%,$(dirs)))
# dirs:=$(filter-out $(exclude_dirs),$(dirs))
SUBDIRS:=$(dirs)
HOME?=~


# Phony Target
.PHONY:all fake
all:$(phonyt) subdirs


# First Layer
subdirs:$(SUBDIRS)
	for dir in $(SUBDIRS); \
		do $(MAKE) -C $$dir||exit 1; \
	done


# clean
clean:
	for dir in $(SUBDIRS);\
		do $(MAKE) -C $$dir clean||exit 1;\
	done


# for debug
fake:
