;;; Code:
(require 'posframe)
(require 'git-gutter)


(defun posframe-gitgutter--post-command-hook ()
  (message "this-command:%s" this-command)
  (when (not (string= this-command "posframe-gitgutter--click"))
    (posframe-gitgutter--delete-posframe)
    (posframe-delete "*posframe-gitgutter-hunk*")
    (remove-hook 'post-command-hook 'posframe-gitgutter--post-command-hook t)))


(defun posframe-gitgutter--click (event)
  "Called when user clicks on margins.  EVENT holds click information."
  (interactive "event")
  
  (let*
      ((start (event-start event))
       (position (posn-point start))
       (window (posn-window start)))
    
    (posn-set-point start)

    (let*
        (
         (info (git-gutter:search-here-diffinfo git-gutter:diffinfos))
         (raw-content (git-gutter-hunk-content info))
         (content (mapconcat 'identity (cdr (split-string raw-content "\n")) "\n"))
         )
      (posframe-show  "*posframe-gitgutter-hunk*"
                      :string content
                      :position position
                      :internal-border-width 10
                      :internal-border-color "#00FFFF"
                      :foreground-color "#ff00ff"
                      :background-color "#00ff00")

      (add-hook 'post-command-hook 'posframe-gitgutter--post-command-hook t)
      )


    )
  )





(defvar posframe-gitgutter-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key global-map (kbd "<left-margin> <mouse-1>") 'posframe-gitgutter--click')
    (define-key global-map (kbd "<right-margin> <mouse-1>") 'posframe-gitgutter--click')
    map)
  "Keymap for posframe-gitgutter-mode.")


;;;###autoload
(define-minor-mode posframe-gitgutter-mode
  "Enables the margin to show a posframe with git diffs when clicked."
  :group posframe-gitgutter-group

  
  (setq posframe-mouse-banish nil))


(provide 'posframe-gitgutter)
;;; posframe-gitgutter.el ends here


