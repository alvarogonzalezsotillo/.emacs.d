;;; Package --- my-utils
;;
;;; Commentary:
;;
;;; Code:

(provide 'my-utils)


;; REABRIR COMO ROOT
(defun abrir-como-root ()
  "Find file as root"
  (interactive)
  (let*
    ((sudo (/= (call-process "sudo" nil nil "-n true") 0))
      (file-name
        (if (tramp-tramp-file-p buffer-file-name)
          (with-parsed-tramp-file-name buffer-file-name parsed
            (tramp-make-tramp-file-name
              (if sudo "sudo" "su")
              "root"
              parsed-host
              parsed-localname
              (let ((tramp-postfix-host-format "|")
                     (tramp-prefix-format))
                (tramp-make-tramp-file-name
                  parsed-method
                  parsed-user
                  parsed-host
                  ""
                  parsed-hop))))
          (concat (if sudo
                    "/sudo::"
                    "/su::")
            buffer-file-name))))
    (find-alternate-file file-name)))

;; EN .zshrc PARA QUE FUNCIONE tramp
;; if [[ "$TERM" == "dumb" ]]
;; then
;;   unsetopt zle
;;   unsetopt prompt_cr
;;   unsetopt prompt_subst
;;   unfunction precmd
;;   unfunction preexec
;;   PS1='$ '
;; fi


;; CONECTAR A TRANSMISSION
(defun conectar-a-transmission ()
  (interactive)

  (setq transmission-host (read-string "Transmission host: " "192.168.1.254" ))
  (setq transmission-user (read-string "Transmission user: " "transmission"))
  (setq transmission-pass (read-passwd "Transmission password: "))

  (message "Conectando a %s@%s" transmission-user transmission-host)
  
  (setq transmission-rpc-auth (list ':username transmission-user ':password transmission-pass))

  (transmission))



;; REVEAL, HTML Y PDF A LA VEZ
(defun reveal-y-pdf ()
  "Crea transparencias de reveal y hace el pdf a la vez."
  (interactive)
  (org-html-export-to-html)
  (let* (
         (filename (buffer-file-name))
         (html-filename (concat (file-name-sans-extension filename) ".html"))
         (html-wp-filename (concat (file-name-sans-extension filename) ".wp.html")) )
    (message "Copiando fichero: %s -> %s" html-filename html-wp-filename)
    (copy-file html-filename html-wp-filename t) )
  
  (org-reveal-export-to-html)
  (let* (
         (filename (buffer-file-name))
         (html-filename (concat (file-name-sans-extension filename) ".html"))
         (html-reveal-filename (concat (file-name-sans-extension filename) ".reveal.html")) )
    (message "renombrando fichero: %s -> %s" html-filename html-reveal-filename)
    (rename-file html-filename html-reveal-filename t))

  (org-latex-export-to-pdf)
  (let* (
         (filename (buffer-file-name))
         (tex-filename (concat (file-name-sans-extension filename) ".tex")))

    
    (message "Borrando fichero: %s" tex-filename)
    (delete-file tex-filename) ) )


;; EXPERIMENTOS
(defun url-decode-region (start end)
  "Replace a region with the same contents, only URL decoded."
  (interactive "r")
  (let ((text (url-unhex-string (buffer-substring start end))))
    (delete-region start end)
    (insert text)))

(defun horario()
  (interactive)
  (cfw:open-ical-calendar "https://calendar.google.com/calendar/ical/ags.iesavellaneda%40gmail.com/private-8d8f10c04ef7daee164d8d8a8f4707d5/basic.ics"))

(defun quitar-proxy()
  (interactive)
  (setq url-proxy-services '()))

(defun proxy-educamadrid()
  (interactive)
  (setq url-proxy-services
        '(("no_proxy" . "^\\(localhost\\|10\\.*|192\\.*\\)")
          ("http" . "213.0.88.85:8080")
          ("https" . "213.0.88.85:8080"))))

(defun org-insert-clipboard-image()
  "Save the image in the clipboard  into a time stamped unique-named file in the same directory as the org-buffer and insert a link to this file."
  (interactive)
  ; (setq tilde-buffer-filename (replace-regexp-in-string "/" "\\" (buffer-file-name) t t))
  (setq filename
        (concat
         (make-temp-name
          (concat buffer-file-name
                  "_"
                  (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
  ;; Linux: ImageMagick:
  ;(call-process "/bin/bash" nil (list filename "kk") nil "-c" "xclip -selection clipboard -t image/png -o")
  (call-process "xclip" nil (list :file filename) nil "-selection"  "clipboard" "-t" "image/png" "-o")
  (insert (concat "[[file:" filename "]]"))
  (org-display-inline-images))

(defun tema-oscuro()
  (interactive)
  (disable-theme 'intellij)
  (load-theme 'sanityinc-tomorrow-bright t)
  (load-theme 'alvaro t))

(defun tema-claro()
  (interactive)
  (disable-theme 'alvaro)
  (disable-theme 'sanityinc-tomorrow-bright)
  (load-theme 'intellij t))
  

(defun kill-other-buffers ()
  "Kill all otherbuffers."
  (interactive)
  (mapc
   'kill-buffer
   (delq (current-buffer)
         (remove-if-not
          '(lambda (x)
             (or (buffer-file-name x)
                 (eq 'dired-mode (buffer-local-value 'major-mode  x))))
          (buffer-list)))))

(defun org-code-block-from-region (beg end &optional results-switches inline)
  "Copiado de org-babel-examplify-region"
  (interactive "*r")
  (let ((maybe-cap
	 (lambda (str)
	   (if org-babel-uppercase-example-markers (upcase str) str))))
    (if inline
	(save-excursion
	  (goto-char beg)
	  (insert (format org-babel-inline-result-wrap
			  (delete-and-extract-region beg end))))
      (let ((size (count-lines beg end)))
	(save-excursion
	  (cond ((= size 0))	      ; do nothing for an empty result
		((< size org-babel-min-lines-for-block-output)
		 (goto-char beg)
		 (dotimes (_ size)
		   (beginning-of-line 1) (insert ": ") (forward-line 1)))
		(t
		 (goto-char beg)
		 (insert (if results-switches
			     (format "%s%s\n"
				     (funcall maybe-cap "#+begin_src")
				     results-switches)
			   (funcall maybe-cap "#+begin_src\n")))
		 (let ((p (point)))
		   (if (markerp end) (goto-char end) (forward-char (- end beg)))
		   (org-escape-code-in-region p (point)))
		 (insert (funcall maybe-cap "#+end_src\n")))))))))


;;; my-utils.el ends here
