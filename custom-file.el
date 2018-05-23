(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command-style
   (quote
    (("" "%(PDF)%(latex) %(file-line-error) -shell-escape %(extraopts) %S%(PDFout)"))))
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#424242" "#d54e53" "#b9ca4a" "#e7c547" "#7aa6da" "#c397d8" "#70c0b1" "#eaeaea"))
 '(chess-default-display (quote (chess-images chess-ics1 chess-plain)))
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(company-show-numbers t)
 '(compilation-message-face (quote default))
 '(custom-safe-themes
   (quote
    ("8a7da2a2959207dbeb974196e9e6d78a6f45996d1f5534c310fe60b7c8680c85" "f3eb3e0e5fe336c2c4044bef9d79e57a6618fc2d00790fd8b5149fe97e64160a" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "d9a6956fc8b56fdf3cacdb818482b7b7692366f12576801319eabd4a79414729" "e95c1353f3825d5086aa9d9c773492171aa29f79b1ad1d5904be7081be1e6fbe" "fb2f0a401501100076f32b6e4ca8cdc9c7d943a7099f2085323ffa1a460819f6" "12cd2ff2db62c2fe561fa6148e5438c6e0eebb9daa7b46c69931ffacfee1521d" "3a0083b2db70cff2c828d59c37973384a9d2f07b3911e8292c19b3c701552804" "c8bb12b86341bfdc154664bf93fc0753ba2ea91c85b9f678e664288c1dd74d05" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "36d92f830c21797ce34896a4cf074ce25dbe0dabe77603876d1b42316530c99d" "b04425cc726711a6c91e8ebc20cf5a3927160681941e06bc7900a5a5bfe1a77f" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(electric-pair-mode t)
 '(fci-rule-color "#424242")
 '(fill-column 120)
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(grep-find-ignored-files
   (quote
    (".#*" "*.o" "*~" "*.bin" "*.lbin" "*.so" "*.a" "*.ln" "*.blg" "*.bbl" "*.elc" "*.lof" "*.glo" "*.idx" "*.lot" "*.fmt" "*.tfm" "*.class" "*.fas" "*.lib" "*.mem" "*.x86f" "*.sparcf" "*.dfsl" "*.pfsl" "*.d64fsl" "*.p64fsl" "*.lx64fsl" "*.lx32fsl" "*.dx64fsl" "*.dx32fsl" "*.fx64fsl" "*.fx32fsl" "*.sx64fsl" "*.sx32fsl" "*.wx64fsl" "*.wx32fsl" "*.fasl" "*.ufsl" "*.fsl" "*.dxl" "*.lo" "*.la" "*.gmo" "*.mo" "*.toc" "*.aux" "*.cp" "*.fn" "*.ky" "*.pg" "*.tp" "*.vr" "*.cps" "*.fns" "*.kys" "*.pgs" "*.tps" "*.vrs" "*.pyc" "*.pyo" "*.pdf" "*.zip")))
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-tail-colors
   (quote
    (("#3C3D37" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#3C3D37" . 100))))
 '(hl-line-overlay-priority -100050)
 '(imenu-list-size 0.2)
 '(magit-diff-use-overlays nil)
 '(mc/always-run-for-all t)
 '(neo-autorefresh nil)
 '(neo-hidden-regexp-list (quote ("^\\." "\\.pyc$" "~$" "^#.*#$" "\\.elc$" ".git")))
 '(neo-smart-open t)
 '(neo-theme (quote nerd))
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(org-babel-load-languages (quote ((emacs-lisp . t) (shell . t))))
 '(org-format-latex-options
   (quote
    (:foreground default :background default :scale 2.0 :html-foreground "Black" :html-background "Transparent" :html-scale 2.0 :matchers
                 ("begin" "$1" "$" "$$" "\\(" "\\["))))
 '(org-html-link-org-files-as-html nil)
 '(org-html-mathjax-options
   (quote
    ((path "//cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML")
     (scale "100")
     (align "center")
     (font "TeX")
     (linebreaks "false")
     (autonumber "AMS")
     (indent "0em")
     (multlinewidth "85%")
     (tagindent ".8em")
     (tagside "right"))))
 '(org-html-table-caption-above nil)
 '(org-latex-default-table-environment "longtable")
 '(org-latex-image-default-width "0.6\\textwidth")
 '(org-latex-inline-image-rules
   (quote
    (("file" . "\\(?:eps\\|jp\\(?:e?g\\)\\|p\\(?:df\\|gf\\|ng\\|s\\)\\|svg\\|tikz\\|gif\\)"))))
 '(org-latex-listings t)
 '(org-list-allow-alphabetical t)
 '(org-src-block-faces (quote (("sql" default) ("shell" default) ("js" default))))
 '(org-support-shift-select t)
 '(package-selected-packages
   (quote
    (scala-mode gradle-mode imenu-list git-messenger wgrep-helm git-link wgrep volatile-highlights lsp-javascript-typescript company-lsp popwin sublimity sr-speedbar graphviz-dot-mode graphql-mode sudoku slime-volleyball mines sokoban ducpel color-theme-sanityinc-tomorrow monokai-theme zenburn-theme skewer-mode helm-gitignore ag fill-column-indicator color-identifiers-mode git-gutter howdoi kodi-remote helm-google latex-preview-pane markdown-preview-mode helm-ag dumb-jump lorem-ipsum calfw-ical web-beautify gitignore-mode use-package company-restclient ob-restclient restclient-helm restclient transmission hl-line+ paradox gift-mode org-webpage plsql org-page company-web company-shell company-quickhelp company-emoji company-c-headers company company-auctex helm-company highlight-indent-guides which-key dired-narrow org markdown-mode magit popup-complete scad-preview scad-mode org-attach-screenshot bm yafolding web-mode transpose-frame tablist switch-window swiper smartparens scala-outline-popup request-deferred rectangle-utils php-mode page-break-lines ox-reveal org-present neotree multiple-cursors image+ htmlize helm-projectile git-timemachine flycheck expand-region diffview crappy-jsp-mode chess calfw auto-highlight-symbol alert adaptive-wrap)))
 '(paradox-github-token t)
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(pos-tip-background-color "#FFFACE")
 '(pos-tip-foreground-color "#272822")
 '(preview-TeX-style-dir "/home/alvaro/.emacs.d/elpa/auctex-11.89.6/latex")
 '(preview-default-preamble
   (quote
    ("\\RequirePackage["
     ("," . preview-default-option-list)
     "]{preview}[2004/11/05]" "\\PreviewEnvironment{tikzpicture}" "\\PreviewEnvironment{tabular}")))
 '(preview-image-type (quote dvipng))
 '(send-mail-function (quote sendmail-send-it))
 '(tramp-copy-size-limit nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#d54e53")
     (40 . "#e78c45")
     (60 . "#e7c547")
     (80 . "#b9ca4a")
     (100 . "#70c0b1")
     (120 . "#7aa6da")
     (140 . "#c397d8")
     (160 . "#d54e53")
     (180 . "#e78c45")
     (200 . "#e7c547")
     (220 . "#b9ca4a")
     (240 . "#70c0b1")
     (260 . "#7aa6da")
     (280 . "#c397d8")
     (300 . "#d54e53")
     (320 . "#e78c45")
     (340 . "#e7c547")
     (360 . "#b9ca4a"))))
 '(vc-annotate-very-old-color nil)
 '(volatile-highlights-mode t)
 '(weechat-color-list
   (unspecified "#272822" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0")))

(put 'LaTeX-narrow-to-environment 'disabled nil)
(put 'TeX-narrow-to-group 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(imenu-list-entry-face ((t (:height 0.9))))
 '(tabbar-default ((t (:background "gray50" :foreground "grey75"))))
 '(tabbar-selected ((t (:inherit tabbar-default :foreground "white" :box (:line-width 1 :color "white" :style pressed-button))))))
