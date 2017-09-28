(deftheme alvaro
  "Created 2016-11-24.")

(custom-theme-set-variables
 'alvaro
 '(LaTeX-command-style (quote (("" "%(PDF)%(latex) %(file-line-error) -shell-escape %(extraopts) %S%(PDFout)"))))
 '(LaTeX-verbatim-environments (quote ("verbatim" "verbatim*" "PantallazoTexto")))
 '(TeX-source-correlate-start-server t)
 '(ac-ignore-case nil)
 '(ansi-color-names-vector ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#ad7fa8" "#8cc4ff" "#eeeeec"])
 '(custom-safe-themes (quote ("12cd2ff2db62c2fe561fa6148e5438c6e0eebb9daa7b46c69931ffacfee1521d" "3a0083b2db70cff2c828d59c37973384a9d2f07b3911e8292c19b3c701552804" "c8bb12b86341bfdc154664bf93fc0753ba2ea91c85b9f678e664288c1dd74d05" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "36d92f830c21797ce34896a4cf074ce25dbe0dabe77603876d1b42316530c99d" "b04425cc726711a6c91e8ebc20cf5a3927160681941e06bc7900a5a5bfe1a77f" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(desktop-save t)
 '(fill-column 120)
 '(linum-mode 1)
 '(mc/always-run-for-all t)
 '(org-format-latex-options (quote (:foreground default :background "White" :scale 1.0 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers ("begin" "$1" "$" "$$" "\\(" "\\["))))
 '(org-latex-default-table-environment "longtable")
 '(org-latex-images-centered nil)
 '(org-src-block-faces (quote (("js" default))))
 '(package-selected-packages (quote (org markdown-mode magit popup-complete scad-preview scad-mode org-attach-screenshot bm yafolding web-mode transpose-frame tablist switch-window swiper sr-speedbar smartparens scala-outline-popup request-deferred rectangle-utils rainbow-delimiters php-mode page-break-lines ox-reveal org-present org-ac neotree multiple-cursors image+ htmlize helm-projectile guide-key-tip github-browse-file git-timemachine git-link flycheck find-file-in-project expand-region epresent ensime discover diffview crappy-jsp-mode company-auctex chess calfw browse-at-remote auto-highlight-symbol auto-complete-auctex alert adaptive-wrap)))
 '(preview-TeX-style-dir "/home/alvaro/.emacs.d/elpa/auctex-11.89.6/latex"))

(custom-theme-set-faces
 'alvaro
 '(font-lock-comment-face ((t (:foreground "peru"))))
 '(neo-dir-link-face ((t (:height 0.8))))
 '(neo-file-link-face ((t (:foreground "White" :height 0.8))))
 '(org-block ((t (:inherit shadow :background "gray10"))))
 '(org-level-1 ((t (:inherit outline-1 :box (:line-width 2 :color "grey75" :style released-button) :height 2.0))))
 '(org-level-2 ((t (:inherit outline-2 :box nil :height 1.5))))
 '(org-meta-line ((t (:inherit font-lock-comment-face)))))

(provide-theme 'alvaro)
