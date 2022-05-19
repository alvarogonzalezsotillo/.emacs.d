

(defun ags/setup-use-package (&optional refresh)
  (interactive
   (list
    (y-or-n-p "Refresh packages? ")
    )
   )


  (message "Inicializo sistema de paquetes...")

  (ignore-errors
    (setq package-native-compile t))
  
  (package-initialize nil)
  (setq package-check-signature nil)
  (setq package-archives
        '(
          ("melpa" . "http://melpa.org/packages/")
          ("gnu" . "http://elpa.gnu.org/packages/")
          ("nongnu" . "https://elpa.nongnu.org/nongnu/")
	  ("org" . "http://orgmode.org/elpa/")
          )
        )
  (package-initialize t)
  (message "Comprobando si use-package está instalado...")
  (when (or refresh (not (require 'use-package nil t)))
    (package-refresh-contents)
    (package-install 'use-package))

  (message "use-package está instalado")
  (require 'use-package)
  
  (when refresh
    (message "Actualizando todos los paquetes...")
    (unless package-archive-contents
      (package-refresh-contents))
    (use-package auto-package-update
		 :ensure t
		 :defer nil
		 :config
		 (setq auto-package-update-delete-old-versions t)
		 (setq auto-package-update-hide-results t)
		 (setq auto-package-update-interval 1)
		 (auto-package-update-maybe)))

  (message "Versión inicial de org:%s" (org-version))
  (message "Instalando org-plus-contrib para conseguir la última versión de org" )
  (use-package org :ensure org-plus-contrib :pin org
    :config
    (require 'ob-tangle)
    )
  )
;;; Code:
(defun ags/carga-config-org (config.org refresh debug)
  "Carga la configuración, refrescando la lista de paquetes si se indica REFRESH, con debug si se indica DEBUG"
  (interactive
   (list
    (y-or-n-p "Refresh packages? ")
    (y-or-n-p "Enable debug? ")
    )
   
   )
  (setq debug-on-error debug)
  (ags/setup-use-package refresh)

  (message "Cargo el fichero org de configuración con org-version:%s" (org-version))

  
  (org-babel-load-file (expand-file-name config.org))
  ;;(load-file (expand-file-name "~/.emacs.d/config.el"))

  ;; DESACTIVAR EL DEBUG
  (setq debug-on-error nil))

(find-file "~/.emacs.d/config.org")
(find-file "~/.emacs.d/neoconfig.org")
(find-file "~/.emacs.d/init.el")
;(ags/carga-config-org "~/.emacs.d/config.org" nil nil)
(ags/carga-config-org "~/.emacs.d/neoconfig.org" nil nil)

