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
;; (global-set-key (kbd "C-<tab>") 'ac-complete-clang)
(define-key ac-mode-map  (kbd "M-/") 'ac-complete-clang)

;; 通过命令获取gcc搜索目录：echo "" | g++ -v -x c++ -E -""
(setq ac-clang-flags
      (mapcar (lambda (item)(concat "-I" item))
              (split-string
               "
/usr/lib/gcc/i686-redhat-linux/4.4.7/../../../../include/c++/4.4.7
/usr/lib/gcc/i686-redhat-linux/4.4.7/../../../../include/c++/4.4.7/i686-redhat-linux
/usr/lib/gcc/i686-redhat-linux/4.4.7/../../../../include/c++/4.4.7/backward
/usr/local/include
/usr/lib/gcc/i686-redhat-linux/4.4.7/include
/usr/include
"
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


(provide 'settings-complete)