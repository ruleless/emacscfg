SUBT:=copyt

DESTDIR:=$(HOME)
SRCFILES:=.emacs

dirs:=.emacs.d

.PHONY:default config plugin yasnippet
default:config plugin

include ./build.mak

# only copy configuration files
config:all

# install plugins
PLUGINDIR:=$(HOME)/.emacs.d/plugins
plugin:$(PLUGINDIR) yasnippet

$(PLUGINDIR):
	mkdir $(PLUGINDIR)

yasnippet:
	git clone --recursive git@github.com:ruleless/yasnippet.git $(PLUGINDIR)/yasnippet
