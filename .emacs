;; self imformation
(setq user-full-name "ruleless")

;; set load directory
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/settings")
(add-to-list 'load-path "~/.emacs.d/theme")

;; server mode
(require 'server)
(when (and (= emacs-major-version 23)
           (= emacs-minor-version 1)
           (equal window-system 'w32))
  (defun server-ensure-safe-dir (dir) "Noop" t)) ; Suppress error "directory
                                        ; ~/.emacs.d/server is unsafe"
                                        ; on windows.
(server-start)

;; 加载自定义设置
(require 'init-settings)
(require 'init-theme)

;; grep 设置(支持中文)
(require 'color-moccur)

;; 自动检测文本编码，以解决乱码问题
(require 'unicad)

;; 使用函数list-packages安装插件
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))

(package-initialize)

;;; python 开发环境
(elpy-enable)

;; 变量定义
(setq temp "~/.emacs.d/plugins/yasnippet/snippets")
(setq mytemp "~/.emacs.d/snippets")
