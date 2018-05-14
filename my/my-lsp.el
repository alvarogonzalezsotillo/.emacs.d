;;; Package --- my-lsp
;;
;;; Commentary:
;;
;;; Code:


(provide 'my-lsp)


(require 'lsp-mode)
(require 'lsp-imenu)
(add-hook 'lsp-after-open-hook 'lsp-enable-imenu)

;; https://github.com/emacs-lsp/lsp-javascript
;; npm i -g javascript-typescript-langserver
(require 'lsp-javascript-typescript)
(add-hook 'js-mode-hook #'lsp-javascript-typescript-enable)
(add-hook 'typescript-mode-hook #'lsp-javascript-typescript-enable) ;; for typescript support
(add-hook 'js3-mode-hook #'lsp-javascript-typescript-enable) ;; for js3-mode support
(add-hook 'rjsx-mode #'lsp-javascript-typescript-enable) ;; for rjsx-mode support


;; https://github.com/emacs-lsp/lsp-css
;; npm i -g vscode-css-languageserver-bin
;;(require 'lsp-css)
(defconst lsp-css--get-root
  (lsp-make-traverser #'(lambda (dir)
                          (directory-files dir nil "package.json"))))

(lsp-define-stdio-client
 lsp-css
 "css"
 lsp-css--get-root
'("css-languageserver" "--stdio"))


(add-hook 'css-mode-hook #'lsp-css-enable)
(add-hook 'less-mode-hook #'lsp-css-enable)
(add-hook 'sass-mode-hook #'lsp-css-enable)
(add-hook 'scss-mode-hook #'lsp-css-enable)

;;; my-lsp ends here
