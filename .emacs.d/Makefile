phonyt:= allt

TOPDIR:=..
DESTDIR:=$(HOME)/.emacs.d

srcfiles:= $(wildcard *.el)
destfiles:= $(foreach v,$(srcfiles),$(DESTDIR)/$(v))

allt:$(DESTDIR) $(destfiles)

$(DESTDIR):
	mkdir $(DESTDIR)

$(destfiles):$(srcfiles)
	cp $@ $^

fake:
	@echo $(destfiles)

include $(TOPDIR)/build.mak
