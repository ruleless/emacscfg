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
  (setq indent-tabs-mode nil))
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
        indent-tabs-mode nil)
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


(setq auto-mode-alist
	  ;; 将文件模式和文件后缀关联起来
	  (append '(("\\.py\\'" . python-mode)
				("\\.s?html?\\'" . html-helper-mode)
				("\\.asp\\'" . html-helper-mode)
				("\\.phtml\\'" . html-helper-mode)
				("\\.h\\'" . c++-mode)
				("\\.c\\'" . c++-mode)
				("\\.impl\\'" . c++-mode)
				("\\.inl\\'" . c++-mode)
				("\\.txt\\'" . org-mode)
				("\\Makefile\\'" . makefile-mode)
				("\\.mak\\'" . makefile-mode)
				("\\.css\\'" . css-mode))
			  auto-mode-alist))


(provide 'settings-codestyle)
