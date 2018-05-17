;;; Package --- Mi init.el
;;
;;; Commentary:
;;
;;; Code:


;; POR SI FALLA ALGO DURANTE LA CARGA
(setq debug-on-error t)
(setq debug-on-quit t)
(setq package-check-signature nil)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(add-to-list 'load-path "~/.emacs.d/my/")

;; PAQUETES
(require 'package)

(require 'my-packages)
(require 'my-parches)
(require 'my-settings)
(require 'my-lsp)
(require 'my-company)
(require 'my-shortcuts)
(require 'my-utils)
(require 'my-lsp)




;; DESACTIVAR EL DEBUG, LO QUE QUEDA YA ES DE CUSTOMIZE
(setq debug-on-error nil)
(setq debug-on-quit nil)

;; TEMA
(tema-oscuro)



;; CARGAR customize
(setq custom-file "~/.emacs.d/custom-file.el")
(load custom-file)

;;; init.el ends here


