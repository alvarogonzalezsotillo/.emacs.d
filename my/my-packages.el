;;; Package --- my-packages
;;
;;; Commentary:
;;
;;; Code:


(provide 'my-packages)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

;; REINSTALAR LOS PAQUETES (SI ES UN EMACS NUEVO)
(defvar my/install-packages
  '(
    color-theme-sanityinc-tomorrow
    2048-game
    adaptive-wrap
    ag
    alert
    auto-highlight-symbol
    bm
    calfw
    calfw-ical
    chess
    company
    company-auctex
    company-c-headers
    company-emoji
    company-quickhelp
    company-restclient
    company-shell
    company-web
    crappy-jsp-mode
    diffview
    dired-narrow
    dumb-jump
    ensime
    expand-region
    flycheck
    gift-mode
    git-gutter
    git-timemachine
    gitignore-mode
    graphviz-dot-mode
    helm-ag
    helm-company
    helm-gitignore
    helm-google
    helm-projectile
    highlight-indent-guides
    howdoi
    htmlize
    image+
    kodi-remote
    latex-preview-pane
    lorem-ipsum
    magit
    markdown-mode
    markdown-preview-mode
    multiple-cursors
    neotree
    ob-restclient
    org
    org-attach-screenshot
    org-page
    ox-reveal
    page-break-lines
    paradox
    php-mode
    popup-complete
    rectangle-utils
    request-deferred
    restclient
    restclient-helm
    scad-mode
    scad-preview
    skewer-mode
    smartparens
    sublimity
    swiper-helm
    switch-window
    tablist
    transmission
    transpose-frame
    use-package
    web-beautify
    web-mode
    which-key
    yafolding
    ))

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
  "Requiere los paquetes para no tener variables indefinidas."
  (dolist (pack my/install-packages)
    (message (concat "Requires:" (symbol-name pack )))
    (require pack)))


(reinstalar-paquetes-en-emacs-nuevo)
(requerir-paquetes)




;;; my-packages ends here
