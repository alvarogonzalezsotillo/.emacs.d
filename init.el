;; POR SI FALLA ALGO DURANTE LA CARGA
(setq debug-on-error t)
(setq debug-on-quit t)

(package-initialize nil)
(setq package-check-signature nil)
(setq package-archives
      '(
	("org" . "http://orgmode.org/elpa/")
	("melpa" . "http://melpa.org/packages/") ) )


(package-initialize t)
(package-refresh-contents)
(package-install 'org)
(require 'org)
(require 'ob-tangle)
(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))


;; DESACTIVAR EL DEBUG, LO QUE QUEDA YA ES DE CUSTOMIZE
(setq debug-on-error nil)
(setq debug-on-quit nil)

