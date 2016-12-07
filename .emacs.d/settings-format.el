
(defun untabify-file ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun add-untaify-hook ()
  (add-hook 'before-save-hook
            '(lambda ()
               (untabify (point-min) (point-max))
               (message "untabify"))))

(if (not (eq system-type 'windows-nt))
    (progn
      (add-hook 'c-mode-common-hook 'add-untaify-hook)
      (add-hook 'c++-mode-common-hook 'add-untaify-hook)
      (add-hook 'lua-mode-common-hook 'add-untaify-hook)))


;; 行尾换行处理
(defun dos-unix () (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

(defun unix-dos () (interactive)
  (goto-char (point-min))
  (while (search-forward "\n" nil t) (replace-match "\r\n")))


(provide 'settings-format)
