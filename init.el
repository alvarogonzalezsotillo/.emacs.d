;; POR SI FALLA ALGO DURANTE LA CARGA
(setq debug-on-error t)
(setq debug-on-quit t)

(package-initialize t)
(require 'org)
(require 'ob-tangle)
(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))


;; DESACTIVAR EL DEBUG, LO QUE QUEDA YA ES DE CUSTOMIZE
(setq debug-on-error nil)
(setq debug-on-quit nil)

