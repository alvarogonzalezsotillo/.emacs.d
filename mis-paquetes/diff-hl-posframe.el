;;; Code:

;;; HACER MENUS POPUP
;;; https://stackoverflow.com/questions/16454838/yasnippet-how-to-create-a-right-click-context-menu-popup-menu


(require 'posframe)
(require 'diff-hl)

(defvar diff-hl-posframe-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key global-map (kbd "<left-margin> <mouse-1>") 'diff-hl-posframe--click)
    (define-key global-map (kbd "<right-margin> <mouse-1>") 'diff-hl-posframe--click)
    (define-key global-map (kbd "<left-fringe> <mouse-1>") 'diff-hl-posframe--click)
    (define-key global-map (kbd "<right-fringe> <mouse-1>") 'diff-hl-posframe--click)
    map)
  "Keymap for diff-hl-posframe-mode.")

(defvar diff-hl-posframe-buffer-name "*diff-hl-posframe-hunk*" "Name of the posframe used by diff-hl-posframe.")
(defvar diff-hl-posframe-frame nil "The postframe frame.")
(defvar diff-hl-posframe-textscale 2 "Decrease of the diff-hl-posframe font.")


(defun diff-hl-posframe--post-command-hook ()
  "Post command hook to delete the posframe."
  (when (not (string= this-command "diff-hl-posframe--click"))
    (posframe-delete diff-hl-posframe-buffer-name)
    (remove-hook 'post-command-hook 'diff-hl-posframe--post-command-hook t)))


(defun diff-hl-posframe--hide-handler  (_info)
  "Hide the posframe if the event is outside the posframe (after the posframe has been opened)."
  ;(warn "this-command:%s %s" this-command (type-of this-command))
  ;(warn "dif-hl-postrame-frame: %s last-event-frame:%s" diff-hl-posframe-frame last-event-frame)
  (and
   (not (eq this-command 'diff-hl-posframe--click))
   (not (eq last-event-frame diff-hl-posframe-frame))
   )
  )

(defun posframe-hidehandler-when-buffer-switch-kk (info)
  (posframe-hidehandler-when-buffer-switch info)
  (diff-hl-posframe--hide-handler info))

(defun diff-hl-posframe--click (event)
  "Called when user clicks on margins.  EVENT holds click information."
  (interactive "event")

  ;(add-hook 'post-command-hook 'diff-hl-posframe--post-command-hook t t)

  
  (when (posframe-workable-p)
    (let*
        ((start (event-start event))
         (position (posn-point start))
         (window (posn-window start)))
      
      (posn-set-point start)
      (let ((content) (point-in-buffer) (frame) (window))
        (save-window-excursion
          (save-excursion
            (diff-hl-diff-goto-hunk)
            (with-current-buffer "*vc-diff*"
              (setq content (buffer-string))
              (setq point-in-buffer (point)))
            
            ))

        (setq posframe-mouse-banish nil)
        (setq
         diff-hl-posframe-frame
         (posframe-show  diff-hl-posframe-buffer-name
                        :string content
                        :position position
                        :internal-border-width 2
                        :internal-border-color "#00FFFF"
                        :hidehandler 'diff-hl-posframe--hide-handler))

        (setq window (window-main-window diff-hl-posframe-frame))
        
        

        (with-current-buffer diff-hl-posframe-buffer-name
          (diff-mode)
          (text-scale-decrease diff-hl-posframe-textscale))

        
        (save-window-excursion
          (select-window window)
          (goto-char point-in-buffer)
          (recenter))
        

    
        )
      )
    )
  )

(defun diff-hl-posframe--after-delete-frame (frame)
  "Hook on `after-delete-frame-functions`, to kill the buffer diff-hl-posframe-buffer-name if FRAME is the posframe."
  ; disabled
  ;(message "after-delete-frame:%s %s" frame diff-hl-posframe-frame)
  ;(when (eq frame diff-hl-posframe-frame)
  ;  (kill-buffer diff-hl-posframe-buffer-name))
  )

;;;###autoload
(define-minor-mode diff-hl-posframe-mode
  "Enables the margin and fringe to show a posframe with vc diffs when clicked."
  :group diff-hl-posframe-group

  (if diff-hl-posframe-mode
      (add-hook 'after-delete-frame-functions  #'diff-hl-posframe--after-delete-frame)
    (remove-hook 'after-delete-frame-functions #'diff-hl-posframe--after-delete-frame)
  )
)

(provide 'diff-hl-posframe)
;;; diff-hl-posframe.el ends here


