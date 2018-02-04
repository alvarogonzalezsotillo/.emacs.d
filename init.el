;;; Package --- Mi init.el
;;
;;; Commentary:
;;
;;; Code:


;; POR SI FALLA ALGO DURANTE LA CARGA
(setq debug-on-error t)
(setq debug-on-quit t)

(add-to-list 'load-path "~/.emacs.d/my/")

;; PAQUETES
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

(require 'my-packages)
(reinstalar-paquetes-en-emacs-nuevo)

(require 'transmission)

(require 'my-utils)

(require 'bm)

(require 'magit)

(require 'tramp)

(require 'calfw)

(require 'transpose-frame)

(require 'ox-reveal)

(require 'switch-window)

(require 'which-key)

(require 'multiple-cursors)

(require 'smartparens-config)

(require 'page-break-lines)
(require 'auto-highlight-symbol)

         
(require 'yafolding)
(add-hook 'prog-mode-hook
          (lambda () (yafolding-mode)))

(require 'helm)

(require 'projectile)
(setq projectile-completion-system 'helm)


(require 'expand-region)


(require 'my-company)


(require 'neotree)


(require 'yasnippet)



(require 'my-parches)
(require 'my-settings)
(require 'my-shortcuts)


;; DESACTIVAR EL DEBUG, LO QUE QUEDA YA ES DE CUSTOMIZE
(setq debug-on-error nil)
(setq debug-on-quit nil)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command-style
   (quote
    (("" "%(PDF)%(latex) %(file-line-error) -shell-escape %(extraopts) %S%(PDFout)"))))
 '(LaTeX-verbatim-environments
   (quote
    ("verbatim" "verbatim*" "listadotxt" "PantallazoTexto" "listadosql")))
 '(TeX-source-correlate-mode t)
 '(TeX-source-correlate-start-server t)
 '(ac-ignore-case nil)
 '(ac-trigger-key "S-<spc>")
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#ad7fa8" "#8cc4ff" "#eeeeec"])
 '(chess-default-display (quote (chess-images chess-ics1 chess-plain)))
 '(company-backends
   (quote
    (company-web-slim company-web-jade company-web-html company-emoji company-c-headers
                      (company-auctex-macros company-auctex-symbols company-auctex-environments)
                      company-auctex-bibs company-auctex-labels company-bbdb company-nxml company-css company-eclim company-semantic company-clang company-xcode company-cmake company-capf company-files
                      (company-dabbrev-code company-gtags company-etags company-keywords)
                      company-oddmuse company-dabbrev)))
 '(company-show-numbers t)
 '(custom-safe-themes
   (quote
    ("fb2f0a401501100076f32b6e4ca8cdc9c7d943a7099f2085323ffa1a460819f6" "12cd2ff2db62c2fe561fa6148e5438c6e0eebb9daa7b46c69931ffacfee1521d" "3a0083b2db70cff2c828d59c37973384a9d2f07b3911e8292c19b3c701552804" "c8bb12b86341bfdc154664bf93fc0753ba2ea91c85b9f678e664288c1dd74d05" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "36d92f830c21797ce34896a4cf074ce25dbe0dabe77603876d1b42316530c99d" "b04425cc726711a6c91e8ebc20cf5a3927160681941e06bc7900a5a5bfe1a77f" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(delete-selection-mode t)
 '(desktop-save t)
 '(desktop-save-mode t)
 '(fill-column 120)
 '(global-company-mode t)
 '(global-hl-line-mode t)
 '(grep-find-ignored-files
   (quote
    (".#*" "*.o" "*~" "*.bin" "*.lbin" "*.so" "*.a" "*.ln" "*.blg" "*.bbl" "*.elc" "*.lof" "*.glo" "*.idx" "*.lot" "*.fmt" "*.tfm" "*.class" "*.fas" "*.lib" "*.mem" "*.x86f" "*.sparcf" "*.dfsl" "*.pfsl" "*.d64fsl" "*.p64fsl" "*.lx64fsl" "*.lx32fsl" "*.dx64fsl" "*.dx32fsl" "*.fx64fsl" "*.fx32fsl" "*.sx64fsl" "*.sx32fsl" "*.wx64fsl" "*.wx32fsl" "*.fasl" "*.ufsl" "*.fsl" "*.dxl" "*.lo" "*.la" "*.gmo" "*.mo" "*.toc" "*.aux" "*.cp" "*.fn" "*.ky" "*.pg" "*.tp" "*.vr" "*.cps" "*.fns" "*.kys" "*.pgs" "*.tps" "*.vrs" "*.pyc" "*.pyo" "*.pdf" "*.zip")))
 '(hl-line-overlay-priority -100050)
 '(line-number-mode nil)
 '(linum-mode 1 t)
 '(mc/always-run-for-all t)
 '(neo-autorefresh nil)
 '(neo-hidden-regexp-list (quote ("^\\." "\\.pyc$" "~$" "^#.*#$" "\\.elc$" ".git")))
 '(neo-smart-open t)
 '(neo-theme (quote nerd))
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
    (fill-column-indicator color-identifiers-mode  git-gutter howdoi kodi-remote helm-google latex-preview-pane markdown-preview-mode helm-ag dumb-jump lorem-ipsum calfw-ical web-beautify gitignore-mode use-package company-restclient ob-restclient restclient-helm restclient transmission hl-line+ paradox gift-mode org-webpage plsql org-page company-web company-shell company-quickhelp company-emoji company-c-headers company company-auctex helm-company highlight-indent-guides which-key dired-narrow org markdown-mode magit popup-complete scad-preview scad-mode org-attach-screenshot bm yafolding web-mode transpose-frame tablist switch-window swiper smartparens scala-outline-popup request-deferred rectangle-utils php-mode page-break-lines ox-reveal org-present neotree multiple-cursors image+ htmlize helm-projectile git-timemachine flycheck expand-region ensime diffview crappy-jsp-mode chess calfw auto-highlight-symbol alert adaptive-wrap)))
 '(paradox-github-token t)
 '(preview-TeX-style-dir "/home/alvaro/.emacs.d/elpa/auctex-11.89.6/latex")
 '(preview-default-preamble
   (quote
    ("\\RequirePackage["
     ("," . preview-default-option-list)
     "]{preview}[2004/11/05]" "\\PreviewEnvironment{tikzpicture}" "\\PreviewEnvironment{tabular}")))
 '(preview-image-type (quote dvipng))
 '(send-mail-function (quote sendmail-send-it))
 '(sml/mode-width
   (if
       (eq
        (powerline-current-separator)
        (quote arrow))
       (quote right)
     (quote full)))
 '(sml/pos-id-separator
   (quote
    (""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (car powerline-default-separator-dir)))
                   (quote powerline-active1)
                   (quote powerline-active2))))
     (:propertize " " face powerline-active2))))
 '(sml/pos-minor-modes-separator
   (quote
    (""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (cdr powerline-default-separator-dir)))
                   (quote powerline-active1)
                   nil)))
     (:propertize " " face sml/global))))
 '(sml/pre-id-separator
   (quote
    (""
     (:propertize " " face sml/global)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (car powerline-default-separator-dir)))
                   nil
                   (quote powerline-active1))))
     (:propertize " " face powerline-active1))))
 '(sml/pre-minor-modes-separator
   (quote
    (""
     (:propertize " " face powerline-active2)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (cdr powerline-default-separator-dir)))
                   (quote powerline-active2)
                   (quote powerline-active1))))
     (:propertize " " face powerline-active1))))
 '(sml/pre-modes-separator (propertize " " (quote face) (quote sml/modes)))
 '(tramp-copy-size-limit nil)
 '(transmission-host "192.168.1.100")
 '(transmission-rpc-auth (quote (:username "transmission" :password ""))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white smoke" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "unknown" :family "Ubuntu Mono"))))
 '(font-lock-comment-face ((t (:foreground "peru"))))
 '(hl-line ((t (:background "gray30"))))
 '(magit-branch-local ((t (:background "dark red" :foreground "LightSkyBlue1"))))
 '(magit-branch-remote ((t (:background "dark magenta" :foreground "DarkSeaGreen2"))))
 '(neo-dir-link-face ((t (:height 0.8))))
 '(neo-file-link-face ((t (:foreground "White" :height 0.8))))
 '(org-block ((t (:inherit shadow :background "gray10"))))
 '(org-level-1 ((t (:inherit outline-1 :box (:line-width 2 :color "grey75" :style released-button) :height 2.0))))
 '(org-level-2 ((t (:inherit outline-2 :box nil :height 1.5))))
 '(org-meta-line ((t (:inherit font-lock-comment-face :height 1.0))))
 '(preview-reference-face ((t (:background "magenta")))))

(put 'LaTeX-narrow-to-environment 'disabled nil)
(put 'TeX-narrow-to-group 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

