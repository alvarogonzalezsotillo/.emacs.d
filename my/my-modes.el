;;; Package --- my-modes
;;
;;; Commentary:
;;
;;; Code:

(provide 'my-modes)



(which-key-mode t)
(smartparens-global-mode 1)
(global-page-break-lines-mode)
(global-auto-highlight-symbol-mode t)

(require 'projectile)
(projectile-mode 1)
(setq projectile-completion-system 'helm)

(winner-mode 1)

(helm-mode 1)
(helm-projectile-on)
(yas-global-mode 1)


(add-hook 'prog-mode-hook
          (lambda () (yafolding-mode)))




;;; my-modes.el ends here
