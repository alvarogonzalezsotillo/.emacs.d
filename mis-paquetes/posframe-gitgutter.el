;;; Code:

;;; HACER MENUS POPUP
;;; https://stackoverflow.com/questions/16454838/yasnippet-how-to-create-a-right-click-context-menu-popup-menu


(require 'posframe)
(require 'git-gutter)

(defvar posframe-gitgutter-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key global-map (kbd "<left-margin> <mouse-1>") 'posframe-gitgutter--click)
    (define-key global-map (kbd "<right-margin> <mouse-1>") 'posframe-gitgutter--click)
    map)
  "Keymap for posframe-gitgutter-mode.")

(defvar posframe-gitgutter-buffer-name "*posframe-gitgutter-hunk*" "Name of the posframe used by posframe-gitgutter.")

(defvar posframe-gitgutter-textscale 2 "Decrease of the posframe-gitgutter font.")


(defun posframe-gitgutter--post-command-hook ()
  "Post command hook to delete the posframe."
  (when (not (string= this-command "posframe-gitgutter--click"))
    (posframe-delete posframe-gitgutter-buffer-name)
    (remove-hook 'post-command-hook 'posframe-gitgutter--post-command-hook t)))


(defun posframe-gitgutter--click (event)
  "Called when user clicks on margins.  EVENT holds click information."
  (interactive "event")

  (add-hook 'post-command-hook 'posframe-gitgutter--post-command-hook t t)
  (when (posframe-workable-p)
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
        (posframe-show  posframe-gitgutter-buffer-name
                        :string content
                        :position position
                        :internal-border-width 2
                        :internal-border-color "#00FFFF")


        (with-current-buffer posframe-gitgutter-buffer-name
          (diff-mode)
          (text-scale-decrease posframe-gitgutter-textscale)
          
          )

        
        )
      
      (add-hook 'post-command-hook 'posframe-gitgutter--post-command-hook t t)


      )
    ))


;;;###autoload
(define-minor-mode posframe-gitgutter-mode
  "Enables the margin to show a posframe with git diffs when clicked."
  :group posframe-gitgutter-group

  (setq posframe-mouse-banish nil))


(provide 'posframe-gitgutter)
;;; posframe-gitgutter.el ends here


