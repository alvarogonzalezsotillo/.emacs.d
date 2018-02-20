;;; Package --- my-shortcuts
;;
;;; Commentary:
;;
;;; Code:

(provide 'my-shortcuts)


(global-set-key (kbd "<f5>") 'transpose-frame)

(global-set-key (kbd "<f9>") 'magit-status)

(global-set-key (kbd "<C-f2>") 'bm-toggle)
(global-set-key (kbd "<f2>")   'bm-next)
(global-set-key (kbd "<S-f2>") 'bm-previous)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)
(global-set-key (kbd "C-S-c C-S-v") 'mc/mark-all-like-this)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "<menu>") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "<f6>") 'helm-mini)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x r b") 'helm-filtered-bookmarks)

(global-set-key (kbd "<f8>") 'neotree-toggle)

(global-set-key (kbd "C-x o") 'switch-window)

(global-set-key (kbd "C-o") 'dumb-jump-go)

(global-set-key (kbd "C-.") 'company-complete)


;; Remove Yasnippet's default tab key binding
(require 'yasnippet)
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
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
    (define-key map (kbd "C-x b") 'ibuffer)
    (define-key map (kbd "C-f") 'swiper-helm)
    (define-key map (kbd "C-<f5>") 'reveal-y-pdf)
    (define-key map (kbd "M-I") 'helm-imenu)

    map)
  "mis-teclas-minor-mode keymap")

(define-minor-mode mis-teclas-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  :init-value t
  :lighter "mis-teclas")

(mis-teclas-minor-mode 1)



;;; my-shortcuts.el ends here
