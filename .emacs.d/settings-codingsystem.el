
(if (eq system-type 'windows-nt)
	(setq default-buffer-file-coding-system 'chinese-gbk)
  (setq default-buffer-file-coding-system 'utf-8))

(if (eq system-type 'windows-nt)
	(prefer-coding-system 'chinese-gbk)
  (prefer-coding-system 'utf-8))

(provide 'settings-codingsystem)
