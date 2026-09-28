;; -*- lexical-binding: t; -*-

(defun ags/setup-straight ()
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
    (load bootstrap-file nil 'nomessage)
    ;; Make use-package use straight by default
    (setq straight-use-package-by-default t)

    ;; Install/use use-package itself through straight
    (straight-use-package 'use-package)))

(defun ags/setup-use-package (&optional refresh)
  (interactive
   (list
    (y-or-n-p "Refresh packages? ")
    )
   )


  (message "Inicializo sistema de paquetes...")

  (ignore-errors
    (setq package-native-compile t))
  
  (setq package-check-signature 'allow-unsigned)
  (setq package-archives
        '(
          ("melpa" . "https://melpa.org/packages/")
          ("gnu" . "https://elpa.gnu.org/packages/")
          ("nongnu" . "https://elpa.nongnu.org/nongnu/")
	  ;;("org" . "https://orgmode.org/elpa/")
          )
        )
  (package-initialize t)
  (when (or refresh (not package-archive-contents))
    (package-refresh-contents))
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
  )

(defun ags/install-org-mode ()
  (straight-use-package 'org))

;;; Code:
(defun ags/carga-config-org (config.org refresh debug)
  "Carga la configuración, refrescando la lista de paquetes si se indica REFRESH, con debug si se indica DEBUG"
  (interactive
   (list
    (read-file-name "Config file: " "~/.emacs.d/" nil t "neoconfig.org")
    (y-or-n-p "Refresh packages? ")
    (y-or-n-p "Enable debug? ")
    )
   
   )
  (setq debug-on-error debug)
  (ags/setup-straight)
  (ags/setup-use-package refresh)

  (ags/install-org-mode)
  (message "Cargo el fichero org de configuración con org-version:%s" (org-version))

  
  (org-babel-load-file (expand-file-name config.org))

  ;; DESACTIVAR EL DEBUG
  (setq debug-on-error nil))



;;(ags/carga-config-org "~/.emacs.d/config.org" nil nil)
(ags/carga-config-org "~/.emacs.d/neoconfig.org" nil t)

;; Cargar las personalizaciones guardadas por `customize'
(load custom-file t)


(put 'dired-find-alternate-file 'disabled nil)
