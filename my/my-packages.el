;;; Package --- my-packages
;;
;;; Commentary:
;;
;;; Code:


(provide 'my-packages)

;; REINSTALAR LOS PAQUETES (SI ES UN EMACS NUEVO)
(defvar my/install-packages '( adaptive-wrap company-emoji
  company-c-headers company company-auctex crappy-jsp-mode chess
  calfw auto-highlight-symbol alert dumb-jump lorem-ipsum
  calfw-ical web-beautify gitignore-mode git-gutter howdoi
  kodi-remote git-timemachine flycheck expand-region ensime
  diffview helm-company highlight-indent-guides which-key
  dired-narrow org helm-google latex-preview-pane
  markdown-preview-mode helm-ag markdown-mode magit
  popup-complete scad-preview scad-mode neotree multiple-cursors
  image+ htmlize helm-projectile org-attach-screenshot bm
  yafolding web-mode transpose-frame org-page company-web
  company-shell company-quickhelp rectangle-utils php-mode
  page-break-lines restclient transmission
  paradox gift-mode tablist switch-window swiper
  smartparens request-deferred use-package company-restclient
  ob-restclient restclient-helm ox-reveal))

(defvar packages-refreshed? nil)

(defun reinstalar-paquetes-en-emacs-nuevo()
  (interactive)
  (dolist (pack my/install-packages)
    (message (concat "Refrescando:" (symbol-name pack )))
    (unless (package-installed-p pack)
      (message (concat "Necesita reinstalar:" (symbol-name pack )))
      (unless packages-refreshed?
        (package-refresh-contents)
        (setq packages-refreshed? t))
      (package-install pack))))


(defun requerir-paquetes ()
  (dolist (pack my/install-packages)
    (message (concat "Requires:" (symbol-name pack )))
    (require pack)))
  


(provide 'reinstalar-paquetes)

;;; my-packages ends here
