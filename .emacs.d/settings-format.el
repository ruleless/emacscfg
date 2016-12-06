
(defun untabify-file ()
  (interactive)
  (untabify (point-min) (point-max)))

(add-hook 'before-save-hook
          '(lambda ()
             (untabify (point-min) (point-max))
             (message "untabify")))


;; 行尾换行处理
(defun dos-unix () (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

(defun unix-dos () (interactive)
  (goto-char (point-min))
  (while (search-forward "\n" nil t) (replace-match "\r\n")))
