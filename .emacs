;;;; 基本设置
;; 个人信息
(setq user-full-name "ruleless")

;; 配置emacs的启动目录
(add-to-list 'load-path "~/.emacs.d")




;;;; server mode
(require 'server)
(when (and (= emacs-major-version 23)
           (= emacs-minor-version 1)
           (equal window-system 'w32))
  (defun server-ensure-safe-dir (dir) "Noop" t)) ; Suppress error "directory
										; ~/.emacs.d/server is unsafe"
										; on windows.
(server-start)




;;;; 编辑器设置
;; 设置背景色和字体色
(set-foreground-color "white")
(set-background-color "black")
(set-face-foreground 'secondary-selection"skyblue")
(set-face-background 'secondary-selection"darkblue")
(global-font-lock-mode t)
;; (set-foreground-color "grey")
;; (set-background-color "black")

;; 关闭烦人的出错时的提示声
(setq visible-bell t)

;; 光标靠近鼠标指针时，让鼠标指针自动让开，别挡住视线
;; (mouse-avoidance-mode 'animate)

;; 滚动页面时比较舒服，不要整页的滚动
(setq scroll-step 1
	  scroll-margin 1
	  scroll-conservatively 10000)

;; 光标不闪
(blink-cursor-mode nil)

;; 光标显示为一竖线
;; (setq-default cursor-type 'bar)

;; 在模式栏中显示行号列号
(column-number-mode t)
(line-number-mode t)

;; 显示匹配括号
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;; 以 y/n代表 yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; 菜单栏、工具栏
(tool-bar-mode nil)
(menu-bar-mode nil)

;; 高亮当前行
(require 'hl-line)
(global-hl-line-mode t)

;; 滚动条在右侧
(set-scroll-bar-mode 'right)
(scroll-bar-mode nil)

;; 在标题栏显示buffer的名字
(setq frame-title-format "%b@emacs")

;; display time
(display-time-mode t)

;; 设置备份策略
(setq make-backup-files t) ; 启用备份功能
(setq vc-make-backup-files t) ; 使用版本控制系统的时候也启用备份功能
(setq version-control t) ; 启用版本控制，即可以备份多次
(setq kept-old-versions 2) ; 备份最原始的版本两次，即第一次编辑前的文档，和第二次编辑前的文档
(setq kept-new-versions 6) ; 备份最新的版本6次，理解同上
(setq delete-old-versions t) ; 删掉不属于以上3中版本的版本
(setq backup-directory-alist '(("." . "~/.saves"))) ; 设置备份文件的路径到~/.saves中
(setq backup-by-copying t) ; 备份设置方法，直接拷贝

;; 设置备份条件
(setq backup-enable-predicate 'ecm-backup-enable-predicate)

;; 关闭匹配下列目录或文件的备份功能
(defun ecm-backup-enable-predicate (filename)
  (and (not (string= "/tmp/" (substring filename 0 5)))
       (not (string-match "semanticdb" filename))))

;; 关闭自动保存模式
(setq auto-save-mode nil)

;; 不生成 #filename# 临时文件
(setq auto-save-default nil)

;; 可以递归的使用 minibuffer
;;(setq enable-recursive-minibuffers t)
(setq max-mini-window-height 1)

;; 在行首 C-k 时，同时删除该行
(setq-default kill-whole-line t)

;; 删除匹配括号间内容
(defun kill-match-paren (arg)
  (interactive "p")
  (cond ((looking-at "[([{]") (kill-sexp 1) (backward-char))
		((looking-at "[])}]") (forward-char) (backward-kill-sexp 1))
		(t (self-insert-command (or arg 1)))))

;; 删除一行
(defun zl-delete-line nil
  "delete the whole line"
  (interactive)
  (beginning-of-line) ;; 光标移动到行首
  (push-mark) ;; 做个标记
  (beginning-of-line 2) ;; 移动到下一行行首
  (kill-region (point) (mark))) ;; 光标和标记之间的删掉

;; 复制一行或者多行
;; C-c C-w 复制整行, 而"C-u 5 C-c w"复制 5 行
(defun copy-lines(&optional arg)
  (interactive "p")
  (save-excursion
    (beginning-of-line)
    (set-mark (point))
    (next-line arg)
    (kill-ring-save (mark) (point))))

;; 自动的在文件末增加一新行
(setq require-final-newline t)

;; 当光标在行尾上下移动的时候，始终保持在行尾。
(setq track-eol t)

;; 当浏览 man page 时，直接跳转到 man buffer。
(setq Man-notify-method 'pushy)

;; 当使用 M-x COMMAND 后，过 1 秒钟显示该 COMMAND 绑定的键
(setq suggest-key-bindings 1)

;; html-helper-mode
(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
(setq auto-mode-alist (cons '("\\.html$" . html-helper-mode) auto-mode-alist))

;; 关闭启动画面
(custom-set-variables '(inhibit-startup-screen t))

(setq inferior-lisp-program "/usr/bin/clisp")
(setq inferior-lisp-program "/usr/local/bin/clisp")

(add-to-list 'default-frame-alist '(width .70))
(add-to-list 'default-frame-alist '(height. 27))

(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(require 'linum)
(setq linum-format "%3d ")
(add-hook 'find-file-hooks (lambda ()(linum-mode 1)))
(setq frame-title-format"Kids@%b")
(setq standard-indent 4)

(custom-set-variables
 '(inhibit-startup-screen t))
(custom-set-faces)

;; 支持emacs和外部程序的粘贴
(setq x-select-enable-clipboard t)

;; 设置kill-ring-max为200
(setq kill-ring-max 200)

;; 删除行尾空白
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Tab键
(setq default-tab-width 4)
(setq tab-width 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40
						44 48 52 56 60 64 68 72 76 80 84 88 92 96))

;; 格式化整个文件函数
(defun indent-whole ()
  (interactive)
  (indent-region (point-min) (point-max))
  (message "format successfully"))

;; 代码折叠
(add-hook 'lua-mode-hook 'hs-minor-mode)
(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'c++-mode-hook 'hs-minor-mode)




;;;; 自动补全
;; yasnippet
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

;; auto-complete
;; (setq ac-auto-start t)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

;; auto-complete-clang
(require 'auto-complete-clang)
(setq ac-quick-help-delay 0.5)
(global-set-key (kbd "C-<tab>") 'ac-complete-clang)

;; 通过命令获取gcc搜索目录：echo "" | g++ -v -x c++ -E -""
(setq ac-clang-flags
      (mapcar (lambda (item)(concat "-I" item))
              (split-string
               "
/usr/include/c++/4.8
/usr/include/i386-linux-gnu/c++/4.8
/usr/include/c++/4.8/backward
/usr/lib/gcc/i686-linux-gnu/4.8/include
/usr/local/include
/usr/lib/gcc/i686-linux-gnu/4.8/include-fixed
/usr/include/i386-linux-gnu
/usr/include"
               )))

(defun my-ac-config ()
  (setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
  (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
  ;; (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)
  (add-hook 'css-mode-hook 'ac-css-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))
(defun my-ac-cc-mode-setup ()
  (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))
(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
(add-hook 'c++-mode-common-hook 'my-ac-cc-mode-setup)
(add-hook 'lua-mode-common-hook 'my-ac-cc-mode-setup)
(my-ac-config)




;;;; 基于语法分析的智能补全
;; 配置semantic,代码分析,智能补全
(setq semanticdb-default-save-directory (expand-file-name "~/.semanticdb")) ;设置semantic.cache路径
(setq semanticdb-project-roots (list (expand-file-name "/"))) ;配置Semantic的检索范围
(autoload 'senator-try-expand-semantic "senator") ;优先调用了senator的分析结果
(add-hook 'semantic-init-hooks 'semantic-idle-completions-mode) ;空闲时进行补全分析
(setq-default semantic-idle-scheduler-idle-time 432000) ;避免semantic占用CPU过多

;;; C/C++语言启动时自动加载semantic对/usr/include的索引数据库
(setq semanticdb-search-system-databases t)
(add-hook 'c-mode-common-hook
		  (lambda ()
			(setq semanticdb-project-system-databases
				  (list (semanticdb-create-database
						 semanticdb-new-database-class
						 "/usr/include")))))
(add-hook 'c++-mode-common-hook
		  (lambda ()
			(setq semanticdb-project-system-databases
				  (list (semanticdb-create-database
						 semanticdb-new-database-class
						 "/usr/include")))))




;;;; 编程相关(Lua模式)
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

;; Lua的折叠脚本
(defvar ywb-lua-sexp-alist '(("function" . "end")
							 ("local function" . "end")
                             ("do" . "end")))

(defun ywb-lua-forward-sexp (&optional arg)
  "Forward to block end"
  (save-match-data
    (when (looking-at (concat "^\\(\\s-*\\)\\(" (mapconcat 'car
                                                           ywb-lua-sexp-alist
                                                           "\\|") "\\)"))
      (re-search-forward (concat "^" (match-string 1)
                                 (assoc-default (match-string 2) ywb-lua-sexp-alist))
                         nil t arg))))

(add-to-list 'hs-special-modes-alist
             `(lua-mode ,(concat "^\\s-*\\(?:" (mapconcat 'car ywb-lua-sexp-alist "\\|") "\\)")
						,(concat "^\\s-*\\(?:" (mapconcat 'cdr ywb-lua-sexp-alist "\\|") "\\)")
						"--"
						ywb-lua-forward-sexp))

;; 配置Lua的Tab键
(setq lua-indent-level 4)
(defun my-lua-setup ()
  (setq indent-tabs-mode t))
(add-hook 'lua-mode-hook 'my-lua-setup)




;;;; 编程相关(C/C++)
;; CC-mode配置 http://cc-mode.sourceforge.net/
(require 'cc-mode)
;; (c-set-offset 'inline-open 0)
;; (c-set-offset 'friend '-)
;; (c-set-offset 'substatement-open 0)

;; 自定义hippie-expand补全或缩进函数
(defun my-indent-or-complete ()
  (interactive)
  (if (looking-at "\\>")
      (hippie-expand nil)
    (indent-for-tab-command)))

;; 括号匹配
(defun my-c-mode-auto-pair ()
  (interactive)
  (make-local-variable 'skeleton-pair-alist)
  (setq skeleton-pair-alist  '((?\(? _")")
							   (?{ \n > _ \n ?} >)))
  (setq skeleton-pair t)
  (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "{") 'skeleton-pair-insert-maybe))
(add-hook 'c-mode-hook 'my-c-mode-auto-pair)
(setq skeleton-pair t)
;;(setq skeleton-pair-on-word t)

;; \"等符号的自动右匹配
(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\'") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\`") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "<") 'skeleton-pair-insert-maybe)

;; 编程风格
(defconst my-c-style
  '((c-tab-always-indent        . t)
    (c-comment-only-line-offset . 4)
    (c-hanging-braces-alist     . ((substatement-open after)
                                   (brace-list-open)))
    (c-hanging-colons-alist     . ((member-init-intro before)
                                   (inher-intro)
                                   (case-label after)
                                   (label after)
                                   (access-label after)))
    (c-cleanup-list             . (scope-operator
                                   empty-defun-braces
                                   defun-close-semi))
    (c-offsets-alist            . ((arglist-close . c-lineup-arglist)
                                   (substatement-open . 0)
                                   (case-label        . 4)
                                   (block-open        . 0)
                                   (knr-argdecl-intro . -)))
    (c-echo-syntactic-information-p . t))
  "My C Programming Style")

;; offset customizations not in my-c-style
(setq c-offsets-alist '((member-init-intro . ++)))

;; Customizations for all modes in CC Mode.
(defun my-c-mode-common-hook ()
  ;; add my personal style and set it for the current buffer
  (c-add-style "PERSONAL" my-c-style t)
  ;; other customizations
  (setq tab-width 4
        ;; this will make sure spaces are used instead of tabs
        indent-tabs-mode t)
  ;; we like auto-newline and hungry-delete
  ;; (c-toggle-auto-hungry-state 1)
  ;; key bindings for all supported languages.  We can put these in
  ;; c-mode-base-map because c-mode-map, c++-mode-map, objc-mode-map,
  ;; java-mode-map, idl-mode-map, and pike-mode-map inherit from it.
  (define-key c-mode-base-map "\C-m" 'c-context-line-break))

;; (add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
;; (add-hook 'c++-mode-common-hook 'my-c-mode-common-hook)
;; (add-hook 'lua-mode-common-hook 'my-c-mode-common-hook)

(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c++-mode-common-hook 'google-set-c-style)
(add-hook 'lua-mode-common-hook 'google-set-c-style)




;;;; 全局快捷键
;; F1：列举我的书签
;; (global-set-key (kbd "<f1>") 'list-bookmarks)

;; Ctrl+F1：设置我的书签
;; (global-set-key [C-f1] 'bookmark-set)

;; F2:保存buffer
;; (global-set-key (kbd "<f2>") 'save-buffer)

;; Ctrl+F2：保存当前桌面
;; (global-set-key [C-f2] 'desktop-save)

;; F3:跳转到寄存器保存的位子
;; (global-set-key (kbd "<f3>") 'jump-to-register)

;; Ctrl+F3:记录当前光标位子到寄存器
;; (global-set-key [C-f3] 'point-to-register)

;; F4:激活speedbar
;; (global-set-key [(f4)] 'speedbar-get-focus)

;; F5:最大化当前buffer:
;; (global-set-key [(f5)] 'delete-other-windows)

;; F6:关闭buffer
;; (global-set-key [(f6)] 'kill-buffer-and-window)

;; 编译和调试
;; (global-set-key [f7] 'compile)
;; (global-set-key [C-f7] 'gdb)
;; (setq-default compile-command "make")
;; (global-set-key [C-f8] 'previous-error)
;; (global-set-key [f8] 'next-error)

;; F9:格式化代码
;; (global-set-key [f9] 'c-indent-line-or-region)
(global-set-key [f9] 'indent-whole)

;; F10:注释 / 取消注释
(global-set-key [f10] 'comment-or-uncomment-region)

;; Ctrl+F11:复制区域到寄存器
;; (global-set-key [C-f11] 'copy-to-register)
;; F11:粘贴寄存器内容
;; (global-set-key [(f11)] 'insert-register)

;; 定义F12键为激活ecb
;; (global-set-key [f12] 'ecb-activate)
;; 定义Ctrl+F12为停止ecb
;; (global-set-key [C-f12] 'ecb-deactivate)
(global-set-key [f12] 'hs-toggle-hiding)

;; (global-set-key [(control tab)] 'other-window);切换窗口
;; (global-set-key (kbd "C-z") 'undo);撤消
;; (global-set-key (kbd "C-a") 'mark-whole-buffer);全选
;; (global-set-key [(meta g)] 'goto-line);跳到某行
;; (global-set-key (kbd "C-/") 'hs-toggle-hiding)

;; 打开ibuffer
;; (global-set-key (kbd "C-x b") 'ibuffer)
;; 打开browse-kill-ring
;; (global-set-key (kbd "C-x v") 'browse-kill-ring)

;; C-x c 复制整行, 而"C-u 5 C-x c"复制 5 行
;; (global-set-key (kbd "C-x c") 'copy-lines) ; 复制一行或者多行
;; (global-set-key (kbd "C-x d") 'zl-delete-line) ; 删除一行
;; (global-set-key (kbd "C-x a") 'kill-match-paren) ; 删除匹配括号间内容

;; (global-set-key [(meta left)]  'tabbar-backward) ; 切换前一个tab
;; (global-set-key [(meta right)] 'tabbar-forward) ; 切换下一个tab
;; (global-set-key [(meta up)] 'tabbar-backward-group)
;; (global-set-key [(meta down)] 'tabbar-forward-group)

;; Tab补全或缩进
;; (global-set-key [(tab)] 'my-indent-or-complete)
