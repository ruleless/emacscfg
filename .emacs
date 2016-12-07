;; 个人信息
(setq user-full-name "ruleless")

;; 配置emacs的启动目录
(add-to-list 'load-path "~/.emacs.d")

;; server mode
(require 'server)
(when (and (= emacs-major-version 23)
           (= emacs-minor-version 1)
           (equal window-system 'w32))
  (defun server-ensure-safe-dir (dir) "Noop" t)) ; Suppress error "directory
                                        ; ~/.emacs.d/server is unsafe"
                                        ; on windows.
(server-start)

;; 编辑器设置
(require 'settings-edit)

;; 颜色设置
(require 'settings-color)

;; 自动补全设置
(require 'settings-complete)

;; 编程风格
(require 'settings-codestyle)

;; gtags
(require 'settings-gtags)

;; 使用函数list-packages安装插件
;; (package-initialize)

;; 快捷键
(require 'settings-keys)

;; org-mode
(setq org-directory "~")
(require 'settings-org)
(require 'settings-markdown)

;; 字体
(if (eq system-type 'windows-nt)
    (progn
      (require 'settings-font)
      (message "align font setted!"))
  (message "align font note setted!"))

;; grep 设置(支持中文)
(require 'color-moccur)

;; 列宽规则
(require 'settings-fci)

;; 自动检测文本编码，以解决乱码问题
(require 'unicad)

(require 'settings-codingsystem)

;; Buffer切换设置
(require 'switch-window)
(require 'settings-window)

;; 格式相关
(require 'settings-format)

;; 变量定义
(setq temp "~/.emacs.d/plugins/yasnippet/snippets")
(setq mytemp "~/.emacs.d/snippets")
