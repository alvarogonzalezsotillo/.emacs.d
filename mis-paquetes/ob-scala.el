;;; ob-scala.el --- org-babel functions for scala evaluation

;; Copyright (C) Simon Hafner

;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:
(require 'ob)
(require 'ob-ref)
(require 'ob-comint)
(require 'ob-eval)
;; possibly require modes required for your language

;; optionally define a file extension for this language
(add-to-list 'org-babel-tangle-lang-exts '("scala" . "scala"))

;; optionally declare default header arguments for this language
(defvar org-babel-default-header-args:scala '())

(defun org-babel-expand-body:scala (body params &optional processed-params)
  "Expand BODY according to PARAMS, return the expanded body."
  (let ((vars (assoc-default :vars (or processed-params (org-babel-process-params params)))))
    (concat
     (mapconcat ;; define any variables
      (lambda (pair)
	(format "val %s=%S"
		(car pair) (org-babel-scala-var-to-scala (cdr pair)))) vars "\n")
     "\n" body "\nprint(\"\\nob_scala_eol\")")))


;; This is the main function which is called to evaluate a code
;; block.
;;
;; So far, only result :output is supported.
(defun org-babel-execute:scala (body params)
  "Execute a block of Scalacode with org-babel.
  This function is called by `org-babel-execute-src-block'"
  (message "executing Scala source code block")
  (let* ((processed-params (org-babel-process-params params))
	 ;; variables assigned for use in the block
	 (vars (assoc-default :vars processed-params))
	 (result-params (assoc-default :result-params processed-params))
	 ;; either OUTPUT or VALUE which should behave as described above
	 (result-type (assoc-default :result-type processed-params))
	 ;; expand the body with `org-babel-expand-body:scala'
	 (full-body (org-babel-expand-body:scala
		     body params processed-params)))
    (let ((temp-file (make-temp-file "scala-eval")))
      (message temp-file)
      (with-temp-file temp-file
	(insert full-body))
      (let ((output
	     (org-babel-comint-with-output (ensime-inf-buffer-name "ob_scala_eol")
	       (ensime-inf-send-string (concat ":load " temp-file))
	       (comint-send-input nil t )
	       (sleep-for 0 5))))
	(delete-file temp-file)
	output))))

(defun org-babel-scala-var-to-scala (var)
  "Convert an elisp var into a string of scala source code
  specifying a var of the same value."
  (format "%S" var))



(provide 'ob-scala)
;;; ob-scala.el ends here

