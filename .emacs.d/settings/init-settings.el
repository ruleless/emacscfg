;; edit settings
(require 'edit-settings)

;; color settings
;; (require 'color-settings)

;; auto complet setttings
(require 'complete-settings)

;; for codeding
(require 'codestyle-settings)

;; gtags
(require 'gtags-settings)

;; 快捷键
(require 'keys-settings)

;; org-mode
(setq org-directory "~")
(require 'org-settings)
(require 'markdown-settings)

;; 字体
(if (eq system-type 'windows-nt)
    (progn
      (require 'font-settings)
      (message "align font setted!"))
  (message "align font note setted!"))

;; 列宽规则
(require 'fci-settings)

(require 'codingsystem-settings)

;; 格式相关
(require 'format-settings)

;; Buffer切换设置
(require 'switch-window)
(require 'window-settings)

(provide 'init-settings)
