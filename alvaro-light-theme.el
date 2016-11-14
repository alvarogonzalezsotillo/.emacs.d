(deftheme alvaro-light
  "Created 2016-11-10.")

(custom-theme-set-variables
 'alvaro-light
 '(LaTeX-command-style (quote (("" "%(PDF)%(latex) %(file-line-error) -shell-escape %(extraopts) %S%(PDFout)"))))
 '(TeX-source-correlate-start-server t)
 '(ac-ignore-case nil)
 '(ansi-color-names-vector ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#ad7fa8" "#8cc4ff" "#eeeeec"])
 '(custom-safe-themes (quote ("c8bb12b86341bfdc154664bf93fc0753ba2ea91c85b9f678e664288c1dd74d05" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "36d92f830c21797ce34896a4cf074ce25dbe0dabe77603876d1b42316530c99d" "b04425cc726711a6c91e8ebc20cf5a3927160681941e06bc7900a5a5bfe1a77f" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(desktop-save t)
 '(fill-column 120)
 '(linum-mode 1)
 '(org-format-latex-options (quote (:foreground default :background "White" :scale 1.0 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers ("begin" "$1" "$" "$$" "\\(" "\\["))))
 '(org-latex-default-table-environment "longtable")
 '(org-latex-images-centered nil)
 '(package-selected-packages (quote (erc-image ox-qmd markdown-mode magit popup-complete scad-preview scad-mode org-attach-screenshot bm yafolding web-mode transpose-frame tablist switch-window swiper sr-speedbar smartparens scala-outline-popup request-deferred rectangle-utils rainbow-delimiters php-mode page-break-lines ox-reveal org-present org-ac neotree multiple-cursors image+ htmlize helm-projectile guide-key-tip github-browse-file git-timemachine git-link flycheck find-file-in-project expand-region epresent ensime discover diffview crappy-jsp-mode company-auctex chess calfw browse-at-remote auto-highlight-symbol auto-complete-auctex alert adaptive-wrap))))

(custom-theme-set-faces
 'alvaro-light
 '(font-lock-comment-face ((t (:foreground "peru"))))
 '(neo-dir-link-face ((t (:height 0.8))))
 '(neo-file-link-face ((t (:foreground "White" :height 0.8))))
 '(org-block ((t (:inherit shadow :inverse-video t :family "courier"))))
 '(org-level-1 ((t (:inherit outline-1 :box (:line-width 2 :color "grey75" :style released-button) :height 2.0))))
 '(org-level-2 ((t (:inherit outline-2 :box nil :height 1.5))))
 '(org-meta-line ((t (:inherit font-lock-comment-face :height 0.4)))))

(provide-theme 'alvaro-light)
