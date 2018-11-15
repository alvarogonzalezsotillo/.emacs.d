;; POR SI FALLA ALGO DURANTE LA CARGA
(setq debug-on-error t)

(package-initialize nil)
(setq package-check-signature nil)
(setq package-archives
      '(
	      ("org" . "http://orgmode.org/elpa/")
              ("gnu" . "http://elpa.gnu.org/packages/")
	      ("melpa" . "http://melpa.org/packages/") ) )


(package-initialize t)
;(package-refresh-contents)
(package-install 'org)
(require 'org)
(require 'ob-tangle)
(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))


;; DESACTIVAR EL DEBUG
(setq debug-on-error nil)
