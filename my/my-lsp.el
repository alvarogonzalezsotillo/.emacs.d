;;; Package --- my-lsp
;;
;;; Commentary:
;;
;;; Code:

(provide 'my-lsp)

;; https://github.com/emacs-lsp/lsp-javascript
;; npm i -g javascript-typescript-langserver
(require 'lsp-javascript-typescript)
(add-hook 'js-mode-hook #'lsp-javascript-typescript-enable)
(add-hook 'typescript-mode-hook #'lsp-javascript-typescript-enable) ;; for typescript support
(add-hook 'js3-mode-hook #'lsp-javascript-typescript-enable) ;; for js3-mode support
(add-hook 'rjsx-mode #'lsp-javascript-typescript-enable) ;; for rjsx-mode support


;;; my-lsp.el ends here
