;;; Package --- my-shortcuts
;;
;;; Commentary:
;;
;;; Code:

(provide 'my-shortcuts)





(define-key global-map [escape] 'keyboard-escape-quit)
;; (define-key key-translation-map (kbd "ESC") (kbd "C-g")) // PROBLEMAS CON EL TERMINAL

;; Remove Yasnippet's default tab key binding
(require 'yasnippet)
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "C-c TAB") 'yas-expand)

;; MIS TECLAS
(defvar mis-teclas-minor-mode-map
  (let ((map (make-sparse-keymap)))
    ;(define-key map (kbd "C-i") 'some-function)
    (define-key map (kbd "C-e") 'er/expand-region)
    (define-key map (kbd "C-S-e") 'er/contract-region)
    (define-key map (kbd "C-z") 'undo )
    (define-key map (kbd "C-x C-d") 'dired)
    (define-key map (kbd "C-x d") 'dired-other-frame)
    (define-key map (kbd "C-x C-b") 'ibuffer)
    (define-key map (kbd "C-x b") 'ibuffer)
    (define-key map (kbd "C-f") 'swiper-helm)
    (define-key map (kbd "C-<f5>") 'reveal-y-pdf)
    (define-key map (kbd "<backtab>") 'psw-switch-buffer)
    (define-key map (kbd "M-I") 'popup-imenu)
    (define-key map (kbd "<f7>") 'imenu-list-smart-toggle)

    (define-key map (kbd "M-S-<up>") 'enlarge-window)
    (define-key map (kbd "M-S-<down>") 'shrink-window)
    (define-key map (kbd "M-S-<left>") 'shrink-window-horizontally)
    (define-key map (kbd "M-S-<right>") 'enlarge-window-horizontally)

    (define-key map (kbd "<f5>") 'transpose-frame)

    (define-key map (kbd "<f9>") 'magit-status)

    (define-key map (kbd "<C-f2>") 'bm-toggle)
    (define-key map (kbd "<f2>")   'bm-next)
    (define-key map (kbd "<S-f2>") 'bm-previous)

    (define-key map (kbd "C-S-c C-S-c") 'mc/edit-lines)
    (define-key map (kbd "C->") 'mc/mark-next-like-this)
    (define-key map (kbd "C-<") 'mc/mark-previous-like-this)
    (define-key map (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)
    (define-key map (kbd "C-S-c C-S-v") 'mc/mark-all-like-this)

    (define-key map (kbd "M-x") 'helm-M-x)
    (define-key map (kbd "C-x M-x") 'execute-extended-command)

    (define-key map (kbd "<menu>") 'helm-M-x)
    (define-key map (kbd "C-x C-f") 'helm-find-files)
    (define-key map (kbd "<f6>") 'helm-mini)
    (define-key map (kbd "M-y") 'helm-show-kill-ring)
    (define-key map (kbd "C-x r b") 'helm-filtered-bookmarks)

    (define-key map (kbd "<f8>") 'neotree-toggle)

    (define-key map (kbd "C-x o") 'switch-window)

    (define-key map (kbd "C-o") 'dumb-jump-go)

    (define-key map (kbd "C-.") 'company-complete)

    (define-key map (kbd "C-S-l") 'toggle-truncate-lines)

    
    map)
  "mis-teclas-minor-mode keymap")


(define-minor-mode mis-teclas-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  :init-value t
  :lighter "mis-teclas")

(mis-teclas-minor-mode 1)



;;; my-shortcuts.el ends here
