;;; Package --- my-settings
;;
;;; Commentary:
;;
;;; Code:

(provide 'my-settings)

;; https://writequit.org/org/settings.html#sec-1-33
;; No perder el portapapeles del sistema
(setq save-interprogram-paste-before-kill t)

;; RECARGAR FICHEROS AUTOMATICAMENTE
(global-auto-revert-mode 1)

;; AUTO MODE, PARA QUE SE ABRAN COMO TEXTO LOS SVG
(add-to-list 'auto-mode-alist '("\\.svg$" . text-mode))

;; GIT GUTTER
(global-git-gutter-mode +1)
(git-gutter:linum-setup)


;; PREVIEW DE TIKZ
;; https://www.gnu.org/software/auctex/manual/preview-latex.html
(require 'preview)
(eval-after-load "preview"
  '(add-to-list 'preview-default-preamble "\\PreviewEnvironment{tikzpicture}" t) )
(eval-after-load "preview"
  '(add-to-list 'preview-default-preamble "\\PreviewEnvironment{tabular}" t) )

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
  (toggle-truncate-lines -1)
  (adaptive-wrap-prefix-mode 1)
  (toggle-word-wrap 1)
  (org-display-inline-images))

(defun bonito-para-codigo()
  (interactive)
  (electric-pair-mode)
  (toggle-truncate-lines -1)
  (adaptive-wrap-prefix-mode 1)
  (toggle-word-wrap 1))

(add-hook 'prog-mode-hook 'bonito-para-codigo)
(add-hook 'text-mode-hook 'bonito-para-codigo)
(add-hook 'org-mode-hook 'bonito-para-codigo)


;; VALIDACIONES
(add-hook 'after-init-hook #'global-flycheck-mode)

;; NO PREGUNTAR CUANDO SE CIERRA EL BUFFER
(setq kill-this-buffer-enabled-p t)
(global-set-key (kbd "C-x k") 'kill-this-buffer)


;; TRANSIENT MARK MODE, PARA C-X TAB
(transient-mark-mode 1)

;; SCROLL SUAVE
(setq scroll-margin 3
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)


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

;; NUMEROS DE LINEA
(global-linum-mode t)

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
(modify-syntax-entry ?~ "(~" org-mode-syntax-table)
(modify-syntax-entry ?= "(=" org-mode-syntax-table)
(modify-syntax-entry ?* "(*" org-mode-syntax-table)
(modify-syntax-entry ?/ "(/" org-mode-syntax-table)





;;; my-settings.el ends here
