;;; Package --- my-company
;;
;;; Commentary:
;;
;;; Code:

(provide 'my-company)



(require 'company)



(defvar my-company-backends
  '(
    (
      company-lsp
      company-files
      company-dabbrev-code
      company-capf
      company-keywords
      company-yasnippet
      company-emoji
     )
   ))

;; set default `company-backends'
(setq company-backends my-company-backends)
(company-auctex-init)

(add-hook 'after-init-hook 'global-company-mode)
                                        ;(add-to-list 'company-backends 'company-c-headers)
                                        ;(add-to-list 'company-backends 'company-web-html)
                                        ;(add-to-list 'company-backends 'company-web-jade)
                                        ;(add-to-list 'company-backends 'company-web-slim)
                                        ;(add-to-list 'company-backends 'company-bbdb)
                                        ;(add-to-list 'company-backends 'company-nxml)
                                        ;(add-to-list 'company-backends 'company-css)
                                        ;(add-to-list 'company-backends 'company-eclim)
                                        ;(add-to-list 'company-backends 'company-semantic)
                                        ;(add-to-list 'company-backends 'company-clang)
                                        ;(add-to-list 'company-backends 'company-xcode)
                                        ;(add-to-list 'company-backends 'company-cmake )
                                        ;(add-to-list 'company-backends 'company-dabbrev-code)
                                        ;(add-to-list 'company-backends 'company-gtags)
                                        ;(add-to-list 'company-backends 'company-etags)
                                        ;(add-to-list 'company-backends 'company-oddmuse)

(company-quickhelp-mode 1)
                                        ;(defun my-org-mode-hook-for-company ()
                                        ;  (add-hook 'completion-at-point-functions 'pcomplete-completions-at-point nil t))
                                        ;(add-hook 'org-mode-hook #'my-org-mode-hook-for-company)

;;; my-company.el ends here
