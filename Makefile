HOME?=~


# Emacs基础配置变量定义
EMACS:=$(HOME)/.emacs
EMACSDIR:=$(HOME)/.emacs.d
SETTINGS:=$(shell ls .emacs.d/*el | xargs)
ACDICT:=$(EMACSDIR)/ac-dict
ACDATA:=$(EMACSDIR)/ac-comphist.dat


# 插件配置变量定义
PLUGINS:=$(EMACSDIR)/plugins

YASNIPPET:=$(PLUGINS)/yasnippet
SNIPPETS:=$(EMACSDIR)/snippets

COLOR_THEME:=$(PLUGINS)/color-theme-6.6.0


.PHONY:install clean dummy

install:
	$(MAKE) install_emacs
	$(MAKE) install_plugins


# Emacs基础配置安装
install_emacs:$(EMACS) $(EMACSDIR) $(ACDICT) $(ACDATA)

$(EMACS):.emacs  # emacs配置文件
	cp .emacs $(HOME)/
$(EMACSDIR):.emacs.d $(SETTINGS)  # emacs配置目录
	-mkdir $(EMACSDIR)
	touch $(EMACSDIR)
	cp $(SETTINGS) $(EMACSDIR)
$(ACDICT):.emacs.d/ac-dict
	cp -r $^ $(EMACSDIR)
	touch $(ACDICT)
$(ACDATA):.emacs.d/ac-comphist.dat
	cp -r $^ $(EMACSDIR)


# Emacs插件安装
install_plugins:$(YASNIPPET) $(SNIPPETS) $(COLOR_THEME)

$(SNIPPETS):.emacs.d/snippets  # 基于yasnippet的编程模板
	ln -s $(PWD)/.emacs.d/snippets $(SNIPPETS)
$(YASNIPPET):$(PLUGINS) .emacs.d/plugins/yasnippet  # yasnippet
	@echo "install yasnippet"
	-git clone --recursive git@github.com:ruleless/yasnippet.git $(YASNIPPET)
	touch $(YASNIPPET)
$(COLOR_THEME):$(PLUGINS) .emacs.d/plugins/color-theme-6.6.0
	cp -r .emacs.d/plugins/color-theme-6.6.0 $(PLUGINS)
	touch $(COLOR_THEME)	

$(PLUGINS):
	-mkdir $(PLUGINS)


clean:
	-rm $(EMACS)
	-rm -rf $(EMACSDIR)

dummy:
	@echo $(SETTINGS)
