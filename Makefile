HOME?=~

# Emacs基础配置变量定义
EMACS:=$(HOME)/.emacs
EMACSDIR:=$(HOME)/.emacs.d
SETTINGS:=$(shell ls .emacs.d/*el | xargs)
ACDICT:=$(EMACSDIR)/ac-dict

PLUGINS:=$(EMACSDIR)/plugins

# yasnippet插件配置变量定义
YASNIPPET:=$(PLUGINS)/yasnippet
SNIPPETS:=$(EMACSDIR)/snippets

.PHONY:install clean dummy

install:$(EMACS) $(EMACSDIR) $(ACDICT) $(YASNIPPET) $(SNIPPETS)

$(EMACS):.emacs  # emacs配置文件
	cp .emacs $(HOME)/
$(EMACSDIR):.emacs.d $(SETTINGS)  # emacs配置目录
	-mkdir $(EMACSDIR)
	touch $(EMACSDIR)
	cp $(SETTINGS) $(EMACSDIR)
$(ACDICT):.emacs.d/ac-dict
	cp -r $^ $(EMACSDIR)

$(SNIPPETS):.emacs.d/snippets  # 基于yasnippet的编程模板
	ln -s $(PWD)/.emacs.d/snippets $(SNIPPETS)
$(YASNIPPET):  # yasnippet
#-git clone --recursive git@github.com:ruleless/yasnippet.git $(YASNIPPET)

clean:
	-rm $(EMACS)
	-rm -rf $(EMACSDIR)

dummy:
	@echo $(SETTINGS)
