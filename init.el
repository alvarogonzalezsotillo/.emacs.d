;; POR SI FALLA ALGO DURANTE LA CARGA
(setq debug-on-error t)
(setq debug-on-quit t)

(package-initialize)
(setq package-check-signature nil)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)


(package-initialize t)

(package-install 'org)
(require 'org)
(require 'ob-tangle)
(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))


;; DESACTIVAR EL DEBUG, LO QUE QUEDA YA ES DE CUSTOMIZE
(setq debug-on-error nil)
(setq debug-on-quit nil)

