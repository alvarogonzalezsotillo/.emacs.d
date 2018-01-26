
;; ESTO ES PARA LOS PAQUETES
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)  

;; REINSTALAR LOS PAQUETES (SI ES UN EMACS NUEVO)
(defun reinstalar-paquetes-en-emacs-nuevo() 

  (interactive) 
  ;; LISTA DE PAQUETES INSTALADOS (C-h v package-selected-packages)
  (setq package-selected-packages '(helm-google howdoi latex-preview-pane markdown-preview-mode helm-ag dumb-jump lorem-ipsum calfw-ical web-beautify gitignore-mode use-package company-restclient ob-restclient restclient-helm restclient transmission hl-line+ paradox gift-mode org-webpage plsql org-page company-web company-shell company-quickhelp company-emoji company-c-headers company company-auctex helm-company highlight-indent-guides which-key dired-narrow org markdown-mode magit popup-complete scad-preview scad-mode org-attach-screenshot bm yafolding web-mode transpose-frame tablist switch-window swiper smartparens scala-outline-popup request-deferred rectangle-utils php-mode page-break-lines ox-reveal org-present neotree multiple-cursors image+ htmlize helm-projectile git-timemachine flycheck expand-region ensime diffview crappy-jsp-mode chess calfw auto-highlight-symbol alert adaptive-wrap))
  
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
  '(add-to-list 'preview-default-preamble "\\PreviewEnvironment{tikzpicture}" t) )
(eval-after-load "preview"
  '(add-to-list 'preview-default-preamble "\\PreviewEnvironment{tabular}" t) )

;; REVEAL Y PDF A LA VEZ
(defun reveal-y-pdf ()
  "Crea transparencias de reveal y hace el pdf a la vez."
  (interactive)
  (org-html-export-to-html)
  (let* (
        (filename (buffer-file-name))
        (html-filename (concat (file-name-sans-extension filename) ".html"))
        (html-wp-filename (concat (file-name-sans-extension filename) ".wp.html")) )
    (message "renombrando fichero: %s -> %s" html-filename html-wp-filename)
    (rename-file html-filename html-wp-filename t) )
  
  (org-reveal-export-to-html)

  (org-latex-export-to-pdf)
  (let* (
        (filename (buffer-file-name))
        (tex-filename (concat (file-name-sans-extension filename) ".tex")) )
    (message "Borrando fichero: %s" tex-filename)
    (delete-file tex-filename) )
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
  ;(call-process "/bin/bash" nil (list filename "kk") nil "-c" "xclip -selection clipboard -t image/png -o")
  (call-process "xclip" nil (list :file filename) nil "-selection"  "clipboard" "-t" "image/png" "-o")
  (insert (concat "[[file:" filename "]]"))
  (org-display-inline-images))


;; RESALTAR LA INDENTACION
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(setq highlight-indent-guides-method 'column)

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
;(setenv "GIT_TRACE" "1")
;(setenv "GIT_CURL_VERBOSE" "1")
;(setenv "GIT_TRACE_PACKET" "1")

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


;; TRAMP
; Si no, helm-ff--get-host-from-tramp-invalid-fname: Symbol’s value as variable is void: tramp-methods
(require 'tramp)

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

;; QUITAR LA TOOLBAR
(tool-bar-mode -1)

;; ANCHURA DE PAGINAS DEL MAN
(setenv "MANWIDTH" "80")

;; COMPANY
(require 'company)
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
    (define-key map (kbd "C-<f5>") 'reveal-y-pdf)
    (define-key map (kbd "M-I") 'helm-imenu)

    map)
  "mis-teclas-minor-mode keymap")

(define-minor-mode mis-teclas-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  :init-value t
  :lighter "mis-teclas")

(mis-teclas-minor-mode 1)


;; PARCHES
(defvar gift-mode-map (make-sparse-keymap))

(setq mi-org-html-protect-char-alist
  '(("&" . "&amp;")
    ("<" . "&lt;")
    (">" . "&gt;")
    ("\\%" . "&#37;")))

(defun mi-org-html-encode-plain-text (text)
  "Convert plain text characters from TEXT to HTML equivalent.
Possible conversions are set in `org-html-protect-char-alist'."
  (dolist (pair org-html-protect-char-alist text)
    (setq text (replace-regexp-in-string (car pair) (cdr pair) text t t))))


(defun org-reveal-src-block (src-block contents info)
  "Transcode a SRC-BLOCK element from Org to Reveal.
CONTENTS holds the contents of the item.  INFO is a plist holding
contextual information."
  (if (org-export-read-attribute :attr_html src-block :textarea)
      (org-html--textarea-block src-block)
    (let* ((use-highlight (org-reveal--using-highlight.js info))
           (lang (org-element-property :language src-block))
           (caption (org-export-get-caption src-block))
           (not-escaped-code (if (not use-highlight)
                     (org-html-format-code src-block info)
                   (cl-letf (((symbol-function 'org-html-htmlize-region-for-paste)
                              #'buffer-substring))
                     (org-html-format-code src-block info))))
           (code (mi-org-html-encode-plain-text not-escaped-code))

           (frag (org-export-read-attribute :attr_reveal src-block :frag))
	   (code-attribs (or (org-export-read-attribute
			 :attr_reveal src-block :code_attribs) ""))
           (label (let ((lbl (org-element-property :name src-block)))
                    (if (not lbl) ""
                      (format " id=\"%s\"" lbl)))))
      (if (not lang)
          (format "<pre %s%s>\n%s</pre>"
                  (or (frag-class frag info) " class=\"example\"")
                  label
                  code)
        (format
         "<div class=\"org-src-container\">\n%s%s\n</div>"
         (if (not caption) ""
           (format "<label class=\"org-src-name\">%s</label>"
                   (org-export-data caption info)))
         (if use-highlight
             (format "\n<pre%s%s><code class=\"%s\" %s>%s</code></pre>"
                     (or (frag-class frag info) "")
                     label lang code-attribs code)
           (format "\n<pre %s%s>%s</pre>"
                   (or (frag-class frag info)
                       (format " class=\"src src-%s\"" lang))
                   label code)))))))


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
 '(custom-safe-themes
   (quote
    ("fb2f0a401501100076f32b6e4ca8cdc9c7d943a7099f2085323ffa1a460819f6" "12cd2ff2db62c2fe561fa6148e5438c6e0eebb9daa7b46c69931ffacfee1521d" "3a0083b2db70cff2c828d59c37973384a9d2f07b3911e8292c19b3c701552804" "c8bb12b86341bfdc154664bf93fc0753ba2ea91c85b9f678e664288c1dd74d05" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "36d92f830c21797ce34896a4cf074ce25dbe0dabe77603876d1b42316530c99d" "b04425cc726711a6c91e8ebc20cf5a3927160681941e06bc7900a5a5bfe1a77f" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(delete-selection-mode t)
 '(desktop-save t)
 '(desktop-save-mode t)
 '(fill-column 120)
 '(global-company-mode t)
 '(global-hl-line-mode t)
 '(grep-find-ignored-files
   (quote
    (".#*" "*.o" "*~" "*.bin" "*.lbin" "*.so" "*.a" "*.ln" "*.blg" "*.bbl" "*.elc" "*.lof" "*.glo" "*.idx" "*.lot" "*.fmt" "*.tfm" "*.class" "*.fas" "*.lib" "*.mem" "*.x86f" "*.sparcf" "*.dfsl" "*.pfsl" "*.d64fsl" "*.p64fsl" "*.lx64fsl" "*.lx32fsl" "*.dx64fsl" "*.dx32fsl" "*.fx64fsl" "*.fx32fsl" "*.sx64fsl" "*.sx32fsl" "*.wx64fsl" "*.wx32fsl" "*.fasl" "*.ufsl" "*.fsl" "*.dxl" "*.lo" "*.la" "*.gmo" "*.mo" "*.toc" "*.aux" "*.cp" "*.fn" "*.ky" "*.pg" "*.tp" "*.vr" "*.cps" "*.fns" "*.kys" "*.pgs" "*.tps" "*.vrs" "*.pyc" "*.pyo" "*.pdf" "*.zip")))
 '(hl-line-overlay-priority -100050)
 '(line-number-mode nil)
 '(linum-mode 1 t)
 '(mc/always-run-for-all t)
 '(neo-autorefresh nil)
 '(neo-hidden-regexp-list (quote ("^\\." "\\.pyc$" "~$" "^#.*#$" "\\.elc$" ".git")))
 '(neo-smart-open t)
 '(neo-theme (quote nerd))
 '(org-babel-load-languages (quote ((emacs-lisp . t) (shell . t))))
 '(org-format-latex-options
   (quote
    (:foreground default :background default :scale 2.0 :html-foreground "Black" :html-background "Transparent" :html-scale 2.0 :matchers
                 ("begin" "$1" "$" "$$" "\\(" "\\["))))
 '(org-html-link-org-files-as-html nil)
 '(org-html-mathjax-options
   (quote
    ((path "//cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML")
     (scale "100")
     (align "center")
     (font "TeX")
     (linebreaks "false")
     (autonumber "AMS")
     (indent "0em")
     (multlinewidth "85%")
     (tagindent ".8em")
     (tagside "right"))))
 '(org-html-table-caption-above nil)
 '(org-latex-default-table-environment "longtable")
 '(org-latex-image-default-width "0.6\\textwidth")
 '(org-latex-inline-image-rules
   (quote
    (("file" . "\\(?:eps\\|jp\\(?:e?g\\)\\|p\\(?:df\\|gf\\|ng\\|s\\)\\|svg\\|tikz\\|gif\\)"))))
 '(org-latex-listings t)
 '(org-list-allow-alphabetical t)
 '(org-src-block-faces (quote (("sql" default) ("shell" default) ("js" default))))
 '(org-support-shift-select t)
 '(package-selected-packages
   (quote
    (howdoi kodi-remote helm-google latex-preview-pane markdown-preview-mode helm-ag dumb-jump lorem-ipsum calfw-ical web-beautify gitignore-mode use-package company-restclient ob-restclient restclient-helm restclient transmission hl-line+ paradox gift-mode org-webpage plsql org-page company-web company-shell company-quickhelp company-emoji company-c-headers company company-auctex helm-company highlight-indent-guides which-key dired-narrow org markdown-mode magit popup-complete scad-preview scad-mode org-attach-screenshot bm yafolding web-mode transpose-frame tablist switch-window swiper smartparens scala-outline-popup request-deferred rectangle-utils php-mode page-break-lines ox-reveal org-present neotree multiple-cursors image+ htmlize helm-projectile git-timemachine flycheck expand-region ensime diffview crappy-jsp-mode chess calfw auto-highlight-symbol alert adaptive-wrap)))
 '(paradox-github-token t)
 '(preview-TeX-style-dir "/home/alvaro/.emacs.d/elpa/auctex-11.89.6/latex" t)
 '(preview-default-preamble
   (quote
    ("\\RequirePackage["
     ("," . preview-default-option-list)
     "]{preview}[2004/11/05]" "\\PreviewEnvironment{tikzpicture}" "\\PreviewEnvironment{tabular}")))
 '(preview-image-type (quote dvipng))
 '(send-mail-function (quote sendmail-send-it))
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
 '(transmission-rpc-auth (quote (:username "transmission" :password "")))
 '(treemacs-header-function (quote treemacs--create-header-projectile)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white smoke" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "unknown" :family "Ubuntu Mono"))))
 '(font-lock-comment-face ((t (:foreground "peru"))))
 '(hl-line ((t (:background "gray30"))))
 '(magit-branch-local ((t (:background "dark red" :foreground "LightSkyBlue1"))))
 '(magit-branch-remote ((t (:background "dark magenta" :foreground "DarkSeaGreen2"))))
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
