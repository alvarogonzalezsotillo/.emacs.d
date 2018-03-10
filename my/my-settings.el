;;; Package --- my-settings
;;
;;; Commentary:
;;
;;; Code:

(provide 'my-settings)

;; AYUDA DE TECLAS
(which-key-mode t)

;; PARENTESIS AUTOCERRABLES
(smartparens-global-mode 1)

;; MOSTRAR ^L BONITOS
(global-page-break-lines-mode)

;; RESALTAR SIMBOLO ACTUAL
(global-auto-highlight-symbol-mode t)

;; PROJECTILE
(require 'projectile)
(projectile-mode 1)

;; RECORDAR DISPOSICION DE VENTANAS
(winner-mode 1)

;; YASNIPPET
(yas-global-mode 1)


;; HELM
(require 'helm)
(require 'helm-config)
(require 'tramp) ;; Symbol’s value as variable is void: tramp-methods
(setq helm-split-window-inside-p t)
(setq helm-display-header-line nil)
(setq helm-autoresize-max-height 30)
(setq helm-autoresize-min-height 30)
(setq projectile-completion-system 'helm)
(helm-autoresize-mode 1)
(helm-mode 1)
(helm-projectile-on)

;; https://writequit.org/org/settings.html#sec-1-33
;; No perder el portapapeles del sistema
(setq save-interprogram-paste-before-kill t)

;; RECARGAR FICHEROS AUTOMATICAMENTE
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

;; AUTO MODE, PARA QUE SE ABRAN COMO TEXTO LOS SVG
(add-to-list 'auto-mode-alist '("\\.svg$" . text-mode))

;; GIT GUTTER
(global-git-gutter-mode +1)



;; LATEX
(require 'tex)
(require 'latex)
(setq LaTeX-verbatim-environments
      '("verbatim" "verbatim*" "listadotxt" "PantallazoTexto" "listadosql"))
(setq TeX-source-correlate-mode t)
(setq TeX-source-correlate-start-server t)
(setq LaTeX-command-style
      '("" "%(PDF)%(latex) %(file-line-error) -shell-escape %(extraopts) %S%(PDFout)"))


;; PREVIEW DE TIKZ
;; https://www.gnu.org/software/auctex/manual/preview-latex.html
(require 'preview)
(eval-after-load "preview"
  '(add-to-list 'preview-default-preamble "\\PreviewEnvironment{tikzpicture}" t) )
(eval-after-load "preview"
  '(add-to-list 'preview-default-preamble "\\PreviewEnvironment{tabular}" t) )

;; BORRAR LA SELECCION AL ESCRIBIR
(delete-selection-mode 1)

;; GRABAR EL ESCRITORIO
(require 'desktop)
(setq desktop-save t)
(desktop-save-mode)


;; RESALTAR LINEA ACTUAL
(global-hl-line-mode t)

;; SIN RUIDO
(setq visible-bell 1)

;; RESALTAR LA INDENTACION
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(setq highlight-indent-guides-method 'fill)

;; SELECCION TRAS COPIAR
(defadvice kill-ring-save (after keep-transient-mark-active ())
  "Override the deactivation of the mark."
  (setq deactivate-mark nil))
(ad-activate 'kill-ring-save)


;; DIRECTORIOS DE BACKUP
(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)


;; VISUALIZACIÓN AGRADABLE
(defun bonito-para-proyector()
  (interactive)
  (bonito-para-codigo)
  (toggle-truncate-lines 1)
  (toggle-word-wrap 1)
  (org-display-inline-images))

(defun bonito-para-codigo()
  (interactive)
  (electric-pair-mode 1)
  (toggle-truncate-lines -1)
  (yafolding-mode 1)
  (adaptive-wrap-prefix-mode 1))

(add-hook 'prog-mode-hook 'bonito-para-codigo)
(add-hook 'text-mode-hook 'bonito-para-proyector)
(add-hook 'org-mode-hook 'bonito-para-codigo)
(add-hook 'tex-mode-hook 'bonito-para-codigo)


;; VALIDACIONES
(add-hook 'after-init-hook #'global-flycheck-mode)

;; NO PREGUNTAR CUANDO SE CIERRA EL BUFFER
(defun kill-this-buffer-dont-ask ()
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-x k") 'kill-this-buffer-dont-ask)


;; TRANSIENT MARK MODE, PARA C-X TAB
(transient-mark-mode 1)

;; SCROLL SUAVE
(setq scroll-margin 3
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

;; POPWIN
(popwin-mode 1)

;; QUITAR LA TOOLBAR
(tool-bar-mode -1)

;; ANCHURA DE PAGINAS DEL MAN
(setenv "MANWIDTH" "80")

;; INDENTACIONES
(setq-default indent-tabs-mode nil)
(setq tab-width 2)

;; PARA FUNCIONAR CON AUCTEX
(require 'tex)
(require 'tex-buf)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq TeX-PDF-mode t)


;; MOSTRAR LOS PARENTESIS ASOCIADOS
(show-paren-mode)

;; QUITAR PANTALLA DE INICIO Y MENU
(setq inhibit-startup-message t)
(menu-bar-mode -1)

;; MODO SERVIDOR
(server-force-delete)
(server-start)

;; imagex PARA HACER ZOOM EN IMÁGENES
(imagex-global-sticky-mode)
(imagex-auto-adjust-mode)


;; ORG MODE, PARA EL electric-pair-mode
(require 'org)
(modify-syntax-entry ?~ "(~" org-mode-syntax-table)
(modify-syntax-entry ?= "(=" org-mode-syntax-table)
(modify-syntax-entry ?* "(*" org-mode-syntax-table)
(modify-syntax-entry ?/ "(/" org-mode-syntax-table)



;; MODELINE
(setq-default mode-line-format
              (list
               " "
               mode-line-modified
               " %[" mode-line-buffer-identification " %] "
               " | " '(vc-mode vc-mode)
               " | %m "
               " | %n "
               " |" mode-line-coding-system-map
               " |" mode-line-misc-info
               " | %IB %Z"
               " | %l:%c "
               mode-line-end-spaces
               ) )

;; PARA EL MINIMAP
(require 'sublimity)
(require 'sublimity-map)
(require 'sublimity-attractive)
(sublimity-map-set-delay nil)


;; RATON EN MODO TEXTO
(xterm-mouse-mode)

;;; my-settings.el ends here
