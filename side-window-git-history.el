
;; git log --all --branches --remotes --format=oneline --abbrev-commit --date=human pruebas-oracle-common.sh


(defvar history-of-file--current-buffer nil "The buffer which history is currently shown")
(defvar history-of-file--current-window nil "The window where `history-of-file--current-buffer' is shown")
(defvar history-of-file--history-buffer nil "The buffer where the history is shown")
(defvar history-of-file--history-window nil "The window where `history-of-file--history-buffer' is shown'")


(defun history-of-file--string(buffer)
  (with-current-buffer buffer 
    (let* ((file buffer-file-name)
           (command (format "git log --all --branches --remotes --format=oneline --abbrev-commit --date=human '%s'"
                            file)))
      (concat (shell-command-to-string command) "\n"))))

(defun history-of-file--internal (buffer window)
  (with-current-buffer buffer
    (if (string-equal (vc-backend buffer-file-name) "Git")
        (progn
          (setq history-of-file--current-buffer buffer)
          (setq history-of-file--current-window window)
          
          (let* ((history (history-of-file--string history-of-file--current-buffer))
                 (history-buffer (get-buffer-create "*History of file*"))
                 (history-window (display-buffer-in-side-window history-buffer `((side . left) (slot . 0)))))
            (setq history-of-file--history-buffer history-buffer)
            (setq history-of-file--history-window history-window)
            (window-resize history-window (- 0 (- (window-width history-window) 30)) t)
            (with-current-buffer history-buffer
              (setq buffer-read-only nil)
              (erase-buffer)
              (insert history)
              (history-of-file-mode))))
      (message "Current buffer %s is not under git version control" buffer))))

(defun history-of-file()
  (interactive)

  (history-of-file--internal (current-buffer) (selected-window)))


(defun history-of-file--do (file-name prev-hash hash next-hash)
  (message "history-of-file--do: file-name:%s prev-hash:%s hash:%s next-hash:%s" file-name prev-hash hash next-hash)
  ;; (diff-hl-set-reference-rev hash)
  (select-window history-of-file--current-window)
  (let* ((reva prev-hash)
         (revb hash)
         (filea file-name)
         (fileb file-name))
    (vdiff-magit-compare reva revb filea fileb))
)


(defun history-of-file--keyboard-rev-selected()
  (interactive)
  (with-current-buffer "*History of file*"
    (let* ((file-name (with-current-buffer history-of-file--current-buffer buffer-file-name))
           (line (thing-at-point 'line t))
           (prev-line (save-excursion (forward-line -1) (thing-at-point 'line t)))
           (next-line (save-excursion (forward-line 1) (thing-at-point 'line t)))
           (hash (progn
                   (string-match "\\(^[^ ]*\\)" line)
                   (match-string 1 line)))
           (prev-hash (progn
                   (string-match "\\(^[^ ]*\\)" prev-line)
                   (match-string 1 prev-line)))
           (next-hash (progn
                   (string-match "\\(^[^ ]*\\)" next-line)
                   (match-string 1 next-line))))
      
      (message "file-name:%s prev-hash:%s hash:%s next-hash:%s" file-name prev-hash hash next-hash)
      (if (and hash (not (string-equal hash "")) (not (string-equal hash "\n")))
          (with-current-buffer history-of-file--current-buffer
            (history-of-file--do file-name prev-hash hash next-hash))
        (message "Not in a revision")))))
      





(define-derived-mode history-of-file-mode fundamental-mode "history"
  (define-key history-of-file-mode-map (kbd "<return>") #'history-of-file--keyboard-rev-selected)
  (setq history-of-file-highlights
        '(("^[^ ]*" . 'font-lock-function-name-face)
          (" .*$" . 'font-lock-constant-face)))
  (setq buffer-read-only t)
  (setq font-lock-defaults '(history-of-file-highlights)))


   


;; MIGUEL ANGEL MARTINEZ DIAZ	miguel.martinez181@educa.madrid.org
;; María Ángeles Del Agua Carreño	maria.del136@educa.madrid.org
