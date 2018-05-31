;;; Package --- my-lsp
;;
;;; Commentary:
;;
;;; Code:


(provide 'my-lsp)


(require 'lsp-mode)
(require 'lsp-imenu)
(add-hook 'lsp-after-open-hook 'lsp-enable-imenu)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)



;; Make a directory for global installations:
;; 1. mkdir ~/.npm-global
;; Configure npm to use the new directory path:
;; 2.npm config set prefix '~/.npm-global'
;; Open or create a ~/.profile file and add this line:
;; 3.export PATH=~/.npm-global/bin:$PATH
;; Back on the command line, update your system variables:
;; 4.source ~/.profile


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

;; BASH
;; https://github.com/mads-hartmann/bash-language-server
;; npm i -g --unsafe-perm bash-language-server
(defconst lsp-shell--get-root
  (lsp-make-traverser #'(lambda (dir)
                          dir)))

(lsp-define-stdio-client
 lsp-shell-script
 "Shell-script"
 lsp-shell--get-root
 '("bash-language-server" "start"))

(add-hook 'sh-mode-hook #'lsp-shell-script-enable)

;; HTML
;; sudo npm i -g --unsafe-perm vscode-html-languageserver-bin
(defconst lsp-html--get-root
  (lsp-make-traverser #'(lambda (dir)
                          dir)))

(lsp-define-stdio-client
 lsp-html
 "HTML"
 lsp-html--get-root
 '("html-languageserver" "--stdio"))

(add-hook 'web-mode-hook #'lsp-html-enable)


;;; my-lsp ends here
