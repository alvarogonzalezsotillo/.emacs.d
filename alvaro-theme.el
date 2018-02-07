(deftheme alvaro
  "Created 2018-02-07.")


(custom-theme-set-faces
 'alvaro
 '(cursor ((t (:background "gray"))))
 '(font-lock-comment-face ((t (:foreground "peru"))))
 '(hl-line ((t (:background "gray10"))))
 '(magit-branch-local ((t (:background "dark red" :foreground "LightSkyBlue1"))))
 '(magit-branch-remote ((t (:background "dark magenta" :foreground "DarkSeaGreen2"))))
 '(neo-dir-link-face ((t (:height 0.8))))
 '(neo-file-link-face ((t (:foreground "White" :height 0.8))))
 '(org-block ((t (:inherit shadow :background "gray10"))))
 '(org-level-1 ((t (:inherit outline-1 :box (:line-width 2 :color "grey75" :style released-button) :height 2.0))))
 '(org-level-2 ((t (:inherit outline-2 :box nil :height 1.5))))
 '(org-meta-line ((t (:inherit font-lock-comment-face :height 1.0))))
 '(preview-reference-face ((t (:background "magenta")))))

(provide-theme 'alvaro)
