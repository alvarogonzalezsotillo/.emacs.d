;; ESTO ES PARA LOS PAQUETES
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(require 'calfw)
(require 'calfw-ical)

(defun kk ()
  (cfw:open-ical-calendar "https://calendar.google.com/calendar/ical/cmr6tlofr4j2dm3hfdql1nf98g%40group.calendar.google.com/public/basic.ics"))


;; GUIA DE TECLAS, TODAS LAS TECLAS
(require 'guide-key)
(guide-key-mode 1) ; Enable guide-key-mode
(setq guide-key/guide-key-sequence t)


;; NO PREGUNTAR CUANDO SE CIERRA EL BUFFER
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; MULTIPLE CURSORS
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)
(global-set-key (kbd "C-S-c C-S-v") 'mc/mark-all-like-this)

;; HABILITAR EL MODO ELECTRICO, CERRANDO AUTOMATICAMENTE DELIMITADORES
(electric-pair-mode 1)

;; YAFOLDING
(define-globalized-minor-mode my-global-yafolding-mode yafolding-mode
  (lambda () (yafolding-mode 1)))
(my-global-yafolding-mode 1)

;; TRANSIENT MARK MODE, PARA C-X TAB
(transient-mark-mode 1)

;; SCROLL SUAVE
(setq redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

;; HABILITAR EL MODO IDO, AHORA USO HELM
;;(require 'ido)
;;(ido-mode t)

;; HELM
(require 'helm)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-<f6>") 'helm-mini)
(helm-mode 1)

;; PROJECTILE
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

;; EXPAND REGION
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; QUITAR LA TOOLBAR
(tool-bar-mode -1)

;; ANCHURA DE PAGINAS DEL MAN
(setenv "MANWIDTH" "80")

;; ESTO ES PARA EL AUTOCOMPLETE
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict") 
(ac-config-default)
(global-auto-complete-mode t)
(add-to-list 'ac-modes 'sql-mode 'tex-mode)

;; ESTO ES PARA VER SI AUTOCOMPLETA TEX
(require 'auto-complete-auctex)

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
;;(global-linum-mode t)
;;(global-linum-mode nil)

;; QUITAR PANTALLA DE INICIO Y MENU
(setq inhibit-startup-message t)
(menu-bar-mode -1)

;; MODO SERVIDOR
;;(server-start)

;; kate-like line wrapping:
;; done by enabling adaptive-wrap minor mode in all buffers
;; globalized minor mode is required for this (hooks don't work)
(defun turn-on-adaptive-wrap-prefix-mode (&optional arg)
  (interactive)
  (adaptive-wrap-prefix-mode (or arg 1)))
(defun turn-off-adaptive-wrap-prefix-mode (&optional arg)
  (interactive)
  (adaptive-wrap-prefix-mode (or arg -1)))
(defun adaptive-wrap-initialize ()
  (unless (minibufferp)
    (progn
      (adaptive-wrap-prefix-mode 1)
      (setq word-wrap t))))
(define-globalized-minor-mode adaptive-wrap-mode
  adaptive-wrap-prefix-mode adaptive-wrap-initialize)
(adaptive-wrap-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#ad7fa8" "#8cc4ff" "#eeeeec"])
 '(chess-default-display (quote (chess-images chess-ics1 chess-plain)))
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(desktop-save t)
 '(desktop-save-mode t)
 '(fill-column 120)
 '(line-number-mode nil)
 '(linum-mode 1 t)
 '(neo-hidden-regexp-list (quote ("^\\." "\\.pyc$" "~$" "^#.*#$" "\\.elc$" ".git")))
 '(neo-smart-open t)
 '(neo-theme (quote nerd))
 '(send-mail-function (quote sendmail-send-it)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white smoke" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "unknown" :family "Ubuntu Mono"))))
 '(neo-dir-link-face ((t (:height 0.8))))
 '(neo-file-link-face ((t (:foreground "White" :height 0.8)))))
(put 'LaTeX-narrow-to-environment 'disabled nil)
(put 'TeX-narrow-to-group 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)


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





