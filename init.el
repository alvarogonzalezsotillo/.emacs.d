

(defun ags/setup-straigth ()
  (defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage)))



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
	  ;;("org" . "http://orgmode.org/elpa/")
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
  (use-package org :ensure org-contrib
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

  ;; DESACTIVAR EL DEBUG
  (setq debug-on-error nil))



;(ags/carga-config-org "~/.emacs.d/config.org" nil nil)
(ags/carga-config-org "~/.emacs.d/neoconfig.org" nil t)

(find-file "~/.emacs.d/")
