


;;; Code:
(defun carga-config-org (refresh debug)
  "Carga la configuración, refrescando la lista de paquetes si se indica REFRESH, con debug si se indica DEBUG"
  (interactive
   (list
    (y-or-n-p "Refresh packages? ")
    (y-or-n-p "Enable debug? ")
   )
  
   )
  (setq debug-on-error debug)

  (message "Inicializo sistema de paquetes...")
  (package-initialize nil)
  (setq package-check-signature nil)
  (setq package-archives
        '(
          ("org" . "http://orgmode.org/elpa/")
          ("gnu" . "http://elpa.gnu.org/packages/")
          ("melpa" . "http://melpa.org/packages/") ) )
  (package-initialize t)

  
  (message "Comprobando si use-package está instalado...")
  (when (or refresh (not (require 'use-package nil 'noerror)))
            (package-refresh-contents)
            (package-install 'use-package))

  (require 'use-package)
  (when refresh
    (message "Actualizando todos los paquetes...")
    (use-package auto-package-update
      :ensure t
      :defer nil
      :config
      (setq auto-package-update-delete-old-versions t)
      (setq auto-package-update-hide-results t)
      (setq auto-package-update-interval 1)
      (auto-package-update-maybe)))

  (use-package org
    :ensure t
    :demand t
    :config
      (require 'ob-tangle))

  (message "Cargo el fichero org de configuración con org-version:%s" (org-version))

  
  (org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))

  ;; DESACTIVAR EL DEBUG
  (setq debug-on-error nil))

(carga-config-org nil nil)


