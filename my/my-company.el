;;; Package --- my-company
;;
;;; Commentary:
;;
;;; Code:

(provide 'my-company)



(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(company-auctex-init)
(add-to-list 'company-backends 'company-c-headers)
(add-to-list 'company-backends 'company-emoji)
(add-to-list 'company-backends 'company-web-html)
(add-to-list 'company-backends 'company-web-jade)
(add-to-list 'company-backends 'company-web-slim)
(company-quickhelp-mode 1)
(defun my-org-mode-hook-for-company ()
  (add-hook 'completion-at-point-functions 'pcomplete-completions-at-point nil t))
(add-hook 'org-mode-hook #'my-org-mode-hook-for-company)

;;; my-company.el ends here
