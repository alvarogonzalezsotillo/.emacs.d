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
(defvar diff-hl-posframe-hunk-boundary "^@@.*@@" "Regex that marks the boundary of a hunk.")
(defvar diff-hl-posframe-frame nil "The postframe frame.")
(defvar diff-hl-posframe-textscale 2 "Decrease of the diff-hl-posframe font.")


(defun diff-hl-posframe--post-command-hook ()
  "Post command hook to delete the posframe."
  (when (not (string= this-command "diff-hl-posframe--click"))
    (posframe-delete diff-hl-posframe-buffer-name)
    (remove-hook 'post-command-hook 'diff-hl-posframe--post-command-hook t)))


(defun diff-hl-posframe--hide-handler  (_info)
  "Hide the posframe if the event is outside the posframe (after the posframe has been opened)."

  (defun w (msg)
    ;;(warn msg)
    )
  (if (not (frame-visible-p diff-hl-posframe-frame))
      t

    (w (format "************"))
    (w (format "this-command:%s %s" this-command (type-of this-command)))
    (w (format "dif-hl-postrame-frame: %s last-event-frame:%s" diff-hl-posframe-frame last-event-frame))
    
    (let* ((invoking-command-p (eq this-command 'diff-hl-posframe--click))
           (ignore-command-p (eq this-command 'ignore))
           (command-in-posframe-p (eq last-event-frame diff-hl-posframe-frame))
           (keep-open-p (or invoking-command-p command-in-posframe-p ignore-command-p)))
      (w (format "invoking:%s  ignore:%s inposframe:%s  keep:%s"
            invoking-command-p ignore-command-p command-in-posframe-p keep-open-p))
      (not keep-open-p))))

(defun diff-hl-posframe-poshandler (info)
  "Posframe's position handler.  INFO has window sizes.  The posframe is positioned vertically centered."
  (let* ((window-left (plist-get info :parent-window-left))
         (window-top (plist-get info :parent-window-top))
         (window-width (plist-get info :parent-window-width))
         (window-height (plist-get info :parent-window-height))
         (posframe-width (plist-get info :posframe-width))
         (posframe-height (plist-get info :posframe-height)))
    (cons (+ window-left (- window-width posframe-width))
          (+ window-top (/ (- window-height posframe-height) 2)))))


(defun diff-hl-posframe-buffer ()
  "Create the buffer with the contents of the hunk at point.  The buffer has the point in the corresponding line of the hunk."

  (unless (diff-hl-hunk-overlay-at (point))
    (error "There is no modified hunk at pos %s" (point)))

  (let ((content)
        (point-in-buffer)
        (overlay)
        (buffer (get-buffer-create diff-hl-posframe-buffer-name)))

    
    
    (save-window-excursion
      (save-excursion
        (diff-hl-diff-goto-hunk)
        (with-current-buffer "*vc-diff*"
          (setq content (buffer-string))
          (setq point-in-buffer (point)))))

    (with-current-buffer buffer

      (erase-buffer)
      (insert content)
      
      ;; Highlight the clicked line
      (goto-char point-in-buffer)
      (setq overlay (make-overlay (point-at-bol) (1+ (point-at-eol))))
      (overlay-put overlay 'face bm-face)
      
      ;; diff-mode, highlight hunks boundaries
      (diff-mode)
      (highlight-regexp diff-hl-posframe-hunk-boundary)
      (message "a")
      

      ;; Change face size
      (text-scale-decrease diff-hl-posframe-textscale)
      (message "b")
      
      

      ;;  Find the hunk and narrow to it
      (re-search-backward diff-hl-posframe-hunk-boundary nil 1)
      (forward-line 1)
      (message "c")
      
      
      (let* ((start (point)))

        (re-search-forward diff-hl-posframe-hunk-boundary nil 1)
        (move-beginning-of-line nil)
        (narrow-to-region start (point)))
      (message "d")
      

      ;; Come back to the clicked line
      ;; (goto-char (overlay-start overlay))
      )
    buffer))


(defun diff-hl-posframe--click (event)
  "Called when user clicks on margins.  EVENT is click information."
  (interactive "event")

  ;;(kill-buffer "*Warnings*")
  
  (when (posframe-workable-p)

    (let* ((window) (buffer)
           (start (event-start event))
           (position (posn-point start)))

      ;;; Move to the click nearest position
      (posn-set-point (event-start event))
      (setq buffer (diff-hl-posframe-buffer))

      
      ;;; Show posframe
      (setq posframe-mouse-banish nil)
      (setq
       diff-hl-posframe-frame
       (posframe-show buffer
                      :position (point)
                      ;:poshandler 'diff-hl-posframe-poshandler
                      :internal-border-width 2
                      :accept-focus nil
                      :internal-border-color "#00FFFF"
                      :hidehandler 'diff-hl-posframe--hide-handler))
      (setq window (window-main-window diff-hl-posframe-frame))

      ;;; Recenter arround point
      (select-frame diff-hl-posframe-frame)
      (select-window window)
      (recenter)
  )))




;;;###autoload
(define-minor-mode diff-hl-posframe-mode
  "Enables the margin and fringe to show a posframe with vc diffs when clicked."
  :group diff-hl-posframe-group
  )

(provide 'diff-hl-posframe)
;;; diff-hl-posframe.el ends here


