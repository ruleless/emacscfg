(setq org-todo-keywords
	  '((sequence "TODO(t)" "PROCESSING(p!)" "|" "DONE(d!)")))

(setq org-log-done 'time)

(setq org-src-fontify-natively t)

;; The following lines are always needed. Choose your own keys.
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

(provide 'settings-org)
