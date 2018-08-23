;;; Package --- my-parches
;;
;;; Commentary:
;;
;;; Code:

(provide 'my-parches)


;; ADITIONAL DUMBJUMB RULES
(add-to-list 'dumb-jump-find-rules
  '(:type "something" :supports ("ag" "grep" "rg" "git-grep") :language "sql"
           :regex ": \\bJJJ\\j"))
(add-to-list 'dumb-jump-find-rules
  '(:type "something" :supports ("ag" "grep" "rg" "git-grep") :language "org"
           :regex ": \\bJJJ\\j"))


;; ESCAPE HTML IN REVEAL
(setq mi-org-html-protect-char-alist
  '(("&" . "&amp;")
    ("<" . "&lt;")
    (">" . "&gt;")
    ("\\%" . "&#37;")))

(defun mi-org-html-encode-plain-text (text)
  "Convert plain text characters from TEXT to HTML equivalent.
Possible conversions are set in `org-html-protect-char-alist'."
  (dolist (pair org-html-protect-char-alist text)
    (setq text (replace-regexp-in-string (car pair) (cdr pair) text t t))))


(defun org-reveal-src-block (src-block contents info)
  "Transcode a SRC-BLOCK element from Org to Reveal.
CONTENTS holds the contents of the item.  INFO is a plist holding
contextual information."
  (if (org-export-read-attribute :attr_html src-block :textarea)
      (org-html--textarea-block src-block)
    (let* ((use-highlight (org-reveal--using-highlight.js info))
           (lang (org-element-property :language src-block))
           (caption (org-export-get-caption src-block))
           (not-escaped-code (if (not use-highlight)
                     (org-html-format-code src-block info)
                   (cl-letf (((symbol-function 'org-html-htmlize-region-for-paste)
                              #'buffer-substring))
                     (org-html-format-code src-block info))))
           (code (mi-org-html-encode-plain-text not-escaped-code))
           ;(code  not-escaped-code)
           
           (frag (org-export-read-attribute :attr_reveal src-block :frag))
	   (code-attribs (or (org-export-read-attribute
			 :attr_reveal src-block :code_attribs) ""))
           (label (let ((lbl (org-element-property :name src-block)))
                    (if (not lbl) ""
                      (format " id=\"%s\"" lbl)))))
      (if (not lang)
          (format "<pre %s%s>\n%s</pre>"
                  (or (frag-class frag info) " class=\"example\"")
                  label
                  code)
        (format
         "<div class=\"org-src-container\">\n%s%s\n</div>"
         (if (not caption) ""
           (format "<label class=\"org-src-name\">%s</label>"
                   (org-export-data caption info)))
         (if use-highlight
             (format "\n<pre%s%s><code class=\"%s\" %s>%s</code></pre>"
                     (or (frag-class frag info) "")
                     label lang code-attribs code)
           (format "\n<pre %s%s>%s</pre>"
                   (or (frag-class frag info)
                       (format " class=\"src src-%s\"" lang))
                   label code)))))))


;;; my-parches.el ends here
