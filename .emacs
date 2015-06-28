;; ESTO ERA PARA LOS PAQUETES
(require 'package)
(add-to-list 'package-archives
'("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
;; For important compatibility libraries like cl-lib
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)


;; ESTO ES PARA EL AUTOCOMPLETE
(add-to-list 'load-path "~/.emacs.d/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)
(global-auto-complete-mode t)
(add-to-list 'ac-modes 'sql-mode 'tex-mode)

;; ESTO ES PARA VER SI AUTOCOMPLETA TEX
(require 'auto-complete-auctex)


;; INDENTACIONES
(setq-default indent-tabs-mode nil)
(setq tab-width 2)

;; PARA FUNCIONAR CON AUCTEX
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq TeX-PDF-mode t)

;; BUSCAR FICHERO EN PROYECTO .git
(global-set-key (kbd "C-x F") 'find-file-in-project)

;; ECB
(require 'ecb-autoloads)

;; QUITAR PANTALLA DE INICIO
(setq inhibit-startup-message t)

;; TABBAR
(setq tabbar-buffer-groups-function
      (lambda ()
        (list "All")))


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
 '(ansi-color-names-vector ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#ad7fa8" "#8cc4ff" "#eeeeec"])
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(fill-column 120)
 '(linum-mode 1)
 '(tabbar-mode 1)
 '(line-number-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'LaTeX-narrow-to-environment 'disabled nil)
(put 'TeX-narrow-to-group 'disabled nil)
