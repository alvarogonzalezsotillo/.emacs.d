

;;; Code:
(defun carga-config-org (refresh debug)
  "Carga la configuración, refrescando la lista de paquetes si se indica REFRESH, con debug si se indica DEBUG"
  (setq debug-on-error debug)

  (package-initialize nil)
  (setq package-check-signature nil)
  (setq package-archives
        '(
          ("org" . "http://orgmode.org/elpa/")
          ("gnu" . "http://elpa.gnu.org/packages/")
          ("melpa" . "http://melpa.org/packages/") ) )


  (package-initialize t)

  (if refresh
      (progn
        (package-refresh-contents)
        (package-install 'org)
        (package-install 'use-package)))
  
  (require 'org)
  (require 'ob-tangle)
  (require 'use-package)
  (org-babel-load-file (expand-file-name "~/.emacs.d/config.org") t)

  (byte-compile-file (expand-file-name "~/.emacs.d/config.el"))

  ;; DESACTIVAR EL DEBUG
  (setq debug-on-error nil))

(carga-config-org nil nil)


