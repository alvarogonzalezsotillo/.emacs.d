(deftheme alvaro
  "Created 2018-02-07.")


(custom-theme-set-faces
 'alvaro
 '(minimap-active-region-background ((t (:inverse-video t))))
 '(magit-branch-local ((t (:background "dark red" :foreground "LightSkyBlue1"))))
 '(magit-branch-remote ((t (:background "dark magenta" :foreground "DarkSeaGreen2"))))
 '(helm-bookmark-file-not-found ((t (:extend t :foreground "spring green"))))
 '(neo-dir-link-face ((t (:height 0.8))))
 '(neo-file-link-face ((t (:height 0.8))))
 '(org-level-1 ((t (:inherit outline-1 :box nil :height 2.0))))
 '(org-level-2 ((t (:inherit outline-2 :box nil :height 1.5))))
 '(org-block-begin-line ((t (:inherit org-meta-line :underline t))))
 '(org-block-end-line ((t (:inherit org-block-begin-line :overline t :underline nil))))
 '(org-meta-line ((t (:inherit font-lock-comment-face :height 0.9)))))


(provide-theme 'alvaro)
