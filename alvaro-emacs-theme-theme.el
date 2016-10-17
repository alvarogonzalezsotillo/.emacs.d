(deftheme alvaro-emacs-theme
  "Created 2016-10-17.")

(custom-theme-set-variables
 'alvaro-emacs-theme
 '(TeX-source-correlate-start-server t)
 '(ac-ignore-case nil)
 '(ansi-color-names-vector ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#ad7fa8" "#8cc4ff" "#eeeeec"])
 '(custom-safe-themes (quote ("c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "36d92f830c21797ce34896a4cf074ce25dbe0dabe77603876d1b42316530c99d" "b04425cc726711a6c91e8ebc20cf5a3927160681941e06bc7900a5a5bfe1a77f" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(desktop-save t)
 '(fill-column 120)
 '(linum-mode 1)
 '(neo-hidden-regexp-list (quote ("^\\." "\\.pyc$" "~$" "^#.*#$" "\\.elc$" ".git")))
 '(neo-smart-open t)
 '(neo-theme (quote nerd))
 '(org-babel-load-languages (quote ((emacs-lisp . t) (shell . t))))
 '(org-html-mathjax-options (quote ((path "//cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML") (scale "100") (align "center") (font "TeX") (linebreaks "false") (autonumber "AMS") (indent "0em") (multlinewidth "85%") (tagindent ".8em") (tagside "right"))))
 '(org-latex-image-default-width "1cm")
 '(org-latex-listings t)
 '(package-selected-packages (quote (markdown-mode magit popup-complete scad-preview scad-mode org-attach-screenshot bm yafolding web-mode transpose-frame tablist switch-window swiper sr-speedbar smartparens scala-outline-popup request-deferred rectangle-utils rainbow-delimiters php-mode page-break-lines ox-reveal org-present org-ac neotree multiple-cursors image+ htmlize helm-projectile guide-key-tip github-browse-file git-timemachine git-link flycheck find-file-in-project expand-region epresent ensime discover diffview crappy-jsp-mode company-auctex chess calfw browse-at-remote auto-highlight-symbol auto-complete-auctex alert adaptive-wrap)))
 '(send-mail-function (quote sendmail-send-it)))

(custom-theme-set-faces
 'alvaro-emacs-theme
 '(font-lock-comment-face ((t (:foreground "peru"))))
 '(neo-dir-link-face ((t (:height 0.8))))
 '(neo-file-link-face ((t (:foreground "White" :height 0.8))))
 '(org-block ((t (:inherit shadow :inverse-video t :family "courier"))))
 '(org-level-1 ((t (:inherit outline-1 :box (:line-width 2 :color "grey75" :style released-button) :height 2.0))))
 '(org-level-2 ((t (:inherit outline-2 :box nil :height 1.5))))
 '(org-meta-line ((t (:inherit font-lock-comment-face :height 0.4))))
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white smoke" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "unknown" :family "Ubuntu Mono")))))

(provide-theme 'alvaro-emacs-theme)
