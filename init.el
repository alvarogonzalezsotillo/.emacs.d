
;; ESTO ES PARA LOS PAQUETES
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)  

;; REINSTALAR LOS PAQUETES (SI ES UN EMACS NUEVO)
(defun reinstalar-paquetes-en-emacs-nuevo() 

  (interactive) 
  ;; LISTA DE PAQUETES INSTALADOS (C-h v package-selected-packages)
  (setq package-selected-packages '(highlight-indent-guides which-key dumb-jump dired-narrow org markdown-mode magit popup-complete scad-preview scad-mode org-attach-screenshot bm yafolding web-mode transpose-frame tablist switch-window swiper sr-speedbar smartparens scala-outline-popup request-deferred rectangle-utils rainbow-delimiters php-mode page-break-lines ox-reveal org-present org-ac neotree multiple-cursors image+ htmlize helm-projectile github-browse-file git-timemachine git-link flycheck find-file-in-project expand-region epresent ensime discover diffview crappy-jsp-mode company-auctex chess calfw browse-at-remote auto-highlight-symbol auto-complete-auctex alert adaptive-wrap))
  
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  ;; (add-to-list 'package-archives '("elpa" . "https://elpa.gnu.org/packages/") t )

  (package-refresh-contents)
  (package-initialize)  

  (package-install-selected-packages))

;; AUTO MODE, PARA QUE SE ABRAN COMO TEXTO LOS SVG
(add-to-list 'auto-mode-alist '("\\.svg$" . text-mode))

;; PREVIEW DE TIKZ
;; https://www.gnu.org/software/auctex/manual/preview-latex.html
(eval-after-load "preview"
  '(add-to-list 'preview-default-preamble "\\PreviewEnvironment{tikzpicture}" t)
  )
(eval-after-load "preview"
  '(add-to-list 'preview-default-preamble "\\PreviewEnvironment{tabular}" t)
  )




;; EXPERIMENTOS
(defun url-decode-region (start end)
  "Replace a region with the same contents, only URL decoded."
  (interactive "r")
  (let ((text (url-unhex-string (buffer-substring start end))))
    (delete-region start end)
    (insert text)))

(defun horario()
  (interactive)
  (cfw:open-ical-calendar "https://calendar.google.com/calendar/ical/ags.iesavellaneda%40gmail.com/private-8d8f10c04ef7daee164d8d8a8f4707d5/basic.ics"))

(defun quitar-proxy()
  (interactive)
  (setq url-proxy-services '()))

(defun proxy-educamadrid()
  (interactive)
  (setq url-proxy-services
        '(("no_proxy" . "^\\(localhost\\|10\\.*|192\\.*\\)")
          ("http" . "213.0.88.85:8080")
          ("https" . "213.0.88.85:8080"))))

(defun org-insert-clipboard-image()
  "Save the image in the clipboard  into a time stamped unique-named file in the same directory as the org-buffer and inserta link to this file."
  (interactive)
  ; (setq tilde-buffer-filename (replace-regexp-in-string "/" "\\" (buffer-file-name) t t))
  (setq filename
        (concat
         (make-temp-name
          (concat buffer-file-name
                  "_"
                  (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
  ;; Linux: ImageMagick:
  (setq save-image-process (concat "-c \"xclip -selection clipboard -t image/png -o >  '" filename "' \"") )
  (message save-image-process)
  (call-process "/bin/sh" nil nil nil save-image-process)
  ;; Windows: Irfanview
  ;;(call-process "c:\\Programme\\IrfanView\\i_view32.exe" nil nil nil (concat "/clippaste /convert=" filename))
  (insert (concat "[[file:" filename "]]"))
  (org-display-inline-images))

;; ORG-WEBPAGE
(require 'org-webpage)
(setq owp/always-use-relative-url t)
(setq owp/last-web-server-docroot "/home/alvaro/.emacs.d/owp-temp.d/alvarogonzalezsotillo.github.io/export")
(setq owp/last-web-server-port 12345)
(owp/add-project-config
 '("alvarogonzalezsotillo.github.io"
   :repository-directory "/home/alvaro/github/alvarogonzalezsotillo.github.io"
   :remote (git "https://github.com/alvarogonzalezsotillo/alvarogonzalezsotillo.github.io.git" "master")
   ;; you can use `rclone` with `:remote (rclone "remote-name" "/remote/path/location")` instead.
   :site-domain "https://alvarogonzalezsotillo.github.io/"
   :site-main-title "Álvaro González Sotillo"
   :site-sub-title ""
   :force-absolute-url nil
   :theme-root-directory "/home/alvaro/github/alvarogonzalezsotillo.github.io/themes"
   :theme (alvaro)
   ;; :source-browse-url ("Github" "https://github.com/alvarogonzalezsotillo/alvarogonzalezsotillo.github.io"
   ))

;; RESALTAR LA INDENTACION
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(setq highlight-indent-guides-method 'character)

;; SELECCION TRAS COPIAR
(defadvice kill-ring-save (after keep-transient-mark-active ())
  "Override the deactivation of the mark."
  (setq deactivate-mark nil))
(ad-activate 'kill-ring-save)

;; VISIBLE BOOKMARKS
(require 'bm)
(global-set-key (kbd "<C-f2>") 'bm-toggle)
(global-set-key (kbd "<f2>")   'bm-next)
(global-set-key (kbd "<S-f2>") 'bm-previous)

;; MAGIT STATUS
(global-set-key (kbd "<f9>") 'magit-status)

;; DIRECTORIOS DE BACKUP
(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; WINNER MODE
(winner-mode 1)

;; NO CORTAR LAS LÍNEAS
(toggle-truncate-lines -1)


;; PARA PRESENTACIONES DEL ORG-MODE
(defun bonito-para-proyector()
  (interactive)
  (toggle-truncate-lines -1)
  (adaptive-wrap-prefix-mode 1)
  (toggle-word-wrap 1)
  (org-display-inline-images))

(add-hook 'org-present-mode-hook
          (lambda ()
            (bonito-para-proyector)
            (org-present-big)
            (setq mode-line-format nil)
            (linum-mode -1)))
            
(add-hook 'epresent-start-presentation-hook
          (lambda()
            (bonito-para-proyector)
            (setq mode-line-format nil)
            (linum-mode -1)))

;; CALENDARIOS
(require 'calfw)



;; TRANSPOSE FRAME
(require 'transpose-frame)
(global-set-key (kbd "<f5>") 'transpose-frame)


;; VALIDACIONES
(add-hook 'after-init-hook #'global-flycheck-mode)

;; EXPORTAR A REVEAL.JS
(require 'ox-reveal)


;; CAMBIAR DE FORMA VISUAL A UNA VENTANA
(require 'switch-window)
(global-set-key (kbd "C-x o") 'switch-window)

;; GUIA DE TECLAS, TODAS LAS TECLAS
;(require 'guide-key)
;(guide-key-mode 1) ; Enable guide-key-mode
;(setq guide-key/guide-key-sequence t)
;(require 'guide-key-tip)
;(setq guide-key-tip/enabled t)
(which-key-mode t)

;; NO PREGUNTAR CUANDO SE CIERRA EL BUFFER
(setq kill-this-buffer-enabled-p t)
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; MULTIPLE CURSORS
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)
(global-set-key (kbd "C-S-c C-S-v") 'mc/mark-all-like-this)

;; HABILITAR EL MODO ELECTRICO, CERRANDO AUTOMATICAMENTE DELIMITADORES.
;; AHORA USO SMARTPARENTS
;; (electric-pair-mode 1)
(require 'smartparens-config)
(smartparens-global-mode 1)


;;^L BONITOS
(require 'page-break-lines)
(global-page-break-lines-mode)

;; RESALTAR EL SIMBOLO ACTUAL
(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode t)

         
;; YAFOLDING
(require 'yafolding)
(define-globalized-minor-mode my-global-yafolding-mode yafolding-mode
  (lambda () (yafolding-mode 1)))
(my-global-yafolding-mode 1)

;; TRANSIENT MARK MODE, PARA C-X TAB
(transient-mark-mode 1)

;; SCROLL SUAVE
(setq redisplay-dont-pause t
      scroll-margin 3
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

;; HELM
(require 'helm)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "<f6>") 'helm-mini)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(helm-mode 1)

;; PROJECTILE
(require 'projectile)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

;; EXPAND REGION
(require 'expand-region)
(global-set-key (kbd "C-e") 'er/expand-region)
(global-set-key (kbd "C-S-e") 'er/contract-region)

;; QUITAR LA TOOLBAR
(tool-bar-mode -1)

;; ANCHURA DE PAGINAS DEL MAN
(setenv "MANWIDTH" "80")

;; COMPANY
(add-hook 'after-init-hook 'global-company-mode)
(company-auctex-init)
(add-to-list 'company-backends 'company-c-headers)
(add-to-list 'company-backends 'company-emoji)
(add-to-list 'company-backends 'company-web-html)
(add-to-list 'company-backends 'company-web-jade)
(add-to-list 'company-backends 'company-web-slim)
(global-set-key (kbd "C-.") 'company-complete)
(company-quickhelp-mode 1)
(defun my-org-mode-hook-for-company ()
  (add-hook 'completion-at-point-functions 'pcomplete-completions-at-point nil t))
(add-hook 'org-mode-hook #'my-org-mode-hook-for-company)




;; MOSTRAR LOS PARENTESIS ASOCIADOS
(show-paren-mode)

;; INDENTACIONES
(setq-default indent-tabs-mode nil)
(setq tab-width 2)

;; PARA FUNCIONAR CON AUCTEX
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq TeX-PDF-mode t)

;; NUMEROS DE LINEA
(global-linum-mode t)
;;(global-linum-mode nil)

;; QUITAR PANTALLA DE INICIO Y MENU
(setq inhibit-startup-message t)
(menu-bar-mode -1)

;; MODO SERVIDOR
(server-force-delete)
(server-start)

;; F8 PARA NEOTREE
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; imagex PARA HACER ZOOM EN IMÁGENES
(imagex-global-sticky-mode)
(imagex-auto-adjust-mode)

;; YASNIPPET
(require 'yasnippet)
(yas-global-mode 1)
;; Remove Yasnippet's default tab key binding
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
;; Alternatively use Control-c + tab
(define-key yas-minor-mode-map (kbd "\C-c TAB") 'yas-expand)


;; MIS TECLAS
(defvar mis-teclas-minor-mode-map
  (let ((map (make-sparse-keymap)))
    ;(define-key map (kbd "C-i") 'some-function)
    (define-key map (kbd "C-e") 'er/expand-region)
    (define-key map (kbd "C-S-e") 'er/contract-region)
    (define-key map (kbd "C-z") 'undo )
    (define-key map (kbd "C-x C-d") 'dired)
    (define-key map (kbd "C-x C-b") 'ibuffer)
    (define-key map (kbd "C-f") 'swiper)
    map)
  "mis-teclas-minor-mode keymap")

(define-minor-mode mis-teclas-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  :init-value t
  :lighter "mis-teclas")

(mis-teclas-minor-mode 1)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command-style
   (quote
    (("" "%(PDF)%(latex) %(file-line-error) -shell-escape %(extraopts) %S%(PDFout)"))))
 '(LaTeX-verbatim-environments
   (quote
    ("verbatim" "verbatim*" "listadotxt" "PantallazoTexto" "listadosql")))
 '(TeX-source-correlate-mode t)
 '(TeX-source-correlate-start-server t)
 '(ac-ignore-case nil)
 '(ac-trigger-key "S-<spc>")
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#ad7fa8" "#8cc4ff" "#eeeeec"])
 '(chess-default-display (quote (chess-images chess-ics1 chess-plain)))
 '(company-backends
   (quote
    (company-web-slim company-web-jade company-web-html company-emoji company-c-headers
                      (company-auctex-macros company-auctex-symbols company-auctex-environments)
                      company-auctex-bibs company-auctex-labels company-bbdb company-nxml company-css company-eclim company-semantic company-clang company-xcode company-cmake company-capf company-files
                      (company-dabbrev-code company-gtags company-etags company-keywords)
                      company-oddmuse company-dabbrev)))
 '(company-show-numbers t)
 '(custom-enabled-themes (quote (alvaro-emacs-theme)))
 '(custom-safe-themes
   (quote
    ("fb2f0a401501100076f32b6e4ca8cdc9c7d943a7099f2085323ffa1a460819f6" "12cd2ff2db62c2fe561fa6148e5438c6e0eebb9daa7b46c69931ffacfee1521d" "3a0083b2db70cff2c828d59c37973384a9d2f07b3911e8292c19b3c701552804" "c8bb12b86341bfdc154664bf93fc0753ba2ea91c85b9f678e664288c1dd74d05" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "36d92f830c21797ce34896a4cf074ce25dbe0dabe77603876d1b42316530c99d" "b04425cc726711a6c91e8ebc20cf5a3927160681941e06bc7900a5a5bfe1a77f" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(delete-selection-mode t)
 '(desktop-save t)
 '(desktop-save-mode t)
 '(fill-column 120)
 '(global-company-mode t)
 '(global-hl-line-mode t)
 '(hl-line-overlay-priority -100050)
 '(line-number-mode nil)
 '(linum-mode 1 t)
 '(mc/always-run-for-all t)
 '(neo-autorefresh nil)
 '(org-format-latex-options
   (quote
    (:foreground default :background default :scale 2.0 :html-foreground "Black" :html-background "Transparent" :html-scale 2.0 :matchers
                 ("begin" "$1" "$" "$$" "\\(" "\\["))))
 '(org-html-table-caption-above nil)
 '(org-latex-default-table-environment "longtable")
 '(org-latex-images-centered nil)
 '(org-src-block-faces (quote (("sql" default) ("shell" default) ("js" default))))
 '(org-support-shift-select t)
 '(package-selected-packages
   (quote
    (transmission hl-line+ treemacs paradox gift-mode org-webpage plsql org-page company-web company-shell company-quickhelp company-emoji company-c-headers company company-auctex helm-company highlight-indent-guides which-key dumb-jump dired-narrow org markdown-mode magit popup-complete scad-preview scad-mode org-attach-screenshot bm yafolding web-mode transpose-frame tablist switch-window swiper sr-speedbar smartparens scala-outline-popup request-deferred rectangle-utils rainbow-delimiters php-mode page-break-lines ox-reveal org-present neotree multiple-cursors image+ htmlize helm-projectile github-browse-file git-timemachine git-link flycheck find-file-in-project expand-region epresent ensime discover diffview crappy-jsp-mode chess calfw browse-at-remote auto-highlight-symbol alert adaptive-wrap)))
 '(paradox-github-token t)
 '(preview-TeX-style-dir "/home/alvaro/.emacs.d/elpa/auctex-11.89.6/latex")
 '(preview-default-preamble
   (quote
    ("\\RequirePackage["
     ("," . preview-default-option-list)
     "]{preview}[2004/11/05]" "\\PreviewEnvironment{tikzpicture}" "\\PreviewEnvironment{tabular}")))
 '(preview-image-type (quote dvipng))
 '(sml/mode-width
   (if
       (eq
        (powerline-current-separator)
        (quote arrow))
       (quote right)
     (quote full)))
 '(sml/pos-id-separator
   (quote
    (""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (car powerline-default-separator-dir)))
                   (quote powerline-active1)
                   (quote powerline-active2))))
     (:propertize " " face powerline-active2))))
 '(sml/pos-minor-modes-separator
   (quote
    (""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (cdr powerline-default-separator-dir)))
                   (quote powerline-active1)
                   nil)))
     (:propertize " " face sml/global))))
 '(sml/pre-id-separator
   (quote
    (""
     (:propertize " " face sml/global)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (car powerline-default-separator-dir)))
                   nil
                   (quote powerline-active1))))
     (:propertize " " face powerline-active1))))
 '(sml/pre-minor-modes-separator
   (quote
    (""
     (:propertize " " face powerline-active2)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (cdr powerline-default-separator-dir)))
                   (quote powerline-active2)
                   (quote powerline-active1))))
     (:propertize " " face powerline-active1))))
 '(sml/pre-modes-separator (propertize " " (quote face) (quote sml/modes)))
 '(smooth-scroll-margin 5)
 '(smooth-scroll-mode t)
 '(smooth-scroll/vscroll-step-size 10)
 '(smooth-scrolling-mode t)
 '(tramp-copy-size-limit nil)
 '(transmission-host "192.168.1.100")
 '(transmission-rpc-auth (quote (:username "transmission" :password "tiratio0")))
 '(treemacs-header-function (quote treemacs--create-header-projectile)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white smoke" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "SWAP"))))
 '(font-lock-comment-face ((t (:foreground "peru"))))
 '(hl-line ((t (:background "gray30"))))
 '(neo-dir-link-face ((t (:height 0.8))))
 '(neo-file-link-face ((t (:foreground "White" :height 0.8))))
 '(org-block ((t (:inherit shadow :background "gray10"))))
 '(org-level-1 ((t (:inherit outline-1 :box (:line-width 2 :color "grey75" :style released-button) :height 2.0))))
 '(org-level-2 ((t (:inherit outline-2 :box nil :height 1.5))))
 '(org-meta-line ((t (:inherit font-lock-comment-face :height 1.0))))
 '(preview-reference-face ((t (:background "magenta")))))
(put 'LaTeX-narrow-to-environment 'disabled nil)
(put 'TeX-narrow-to-group 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)






(put 'upcase-region 'disabled nil)
