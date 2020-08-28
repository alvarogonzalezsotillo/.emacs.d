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
(defvar diff-hl-posframe-hunk-boundary "^@@.*@@$" "Regex that marks the boundary of a hunk.")
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

(defun diff-hl-posframe--click (event)
  "Called when user clicks on margins.  EVENT is click information."
  (interactive "event")
  
  (when (posframe-workable-p)

    (let* ((content) (point-in-buffer) (frame) (window) (marker)
           (start (event-start event))
           (position (posn-point start)))

      ;;; Move to the click nearest position
      (posn-set-point (event-start event))

      
      ;;; Use diff-hl to get the *vc-diff* content
      (save-window-excursion
        (save-excursion
          (diff-hl-diff-goto-hunk)
          (with-current-buffer "*vc-diff*"
            (setq content (buffer-string))
            (setq point-in-buffer (point)))
          
          ))

      ;;; Show posframe
      (setq posframe-mouse-banish nil)
      (setq
       diff-hl-posframe-frame
       (posframe-show  diff-hl-posframe-buffer-name
                       :string content
                       :position position
                       :internal-border-width 2
                       :accept-focus t
                       :internal-border-color "#00FFFF"
                       :hidehandler 'diff-hl-posframe--hide-handler))
      (setq window (window-main-window diff-hl-posframe-frame))
      
      
      ;;; Change the font size of the posframe
      (with-current-buffer diff-hl-posframe-buffer-name
        (diff-mode)
        (highlight-regexp diff-hl-posframe-hunk-boundary
                          (text-scale-decrease diff-hl-posframe-textscale)))

      ;;; Narrow the content to the current hunk
      (save-window-excursion
        (select-window window)
        ;;;(set-marker 'marker point-in-buffer)



          ;;; Highlight the clicked line
        (goto-char point-in-buffer)
        (let ((overlay (make-overlay (point-at-bol) (1+ (point-at-eol)))))
          (overlay-put overlay 'face bm-face))
        ;;;(recenter)
        
        (let ((start (or (re-search-backward diff-hl-posframe-hunk-boundary nil 1) 0))
              (dummy (forward-line))
              (end (or (re-search-forward diff-hl-posframe-hunk-boundary nil 1) 100000)))
          (narrow-to-region start end))
        

        
        )
      )
    )
  )



;;;###autoload
  (define-minor-mode diff-hl-posframe-mode
    "Enables the margin and fringe to show a posframe with vc diffs when clicked."
    :group diff-hl-posframe-group
    )

  (provide 'diff-hl-posframe)
;;; diff-hl-posframe.el ends here


