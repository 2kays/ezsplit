;;; ezsplit.el --- a collection of window management functions.

;; Copyright (C) 2016 Kyle K

;; Author: 2kays
;; Version: 0.1
;; URL: http://github.com/2kays/ezsplit
;; Package-Requires: ((emacs "24"))
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:
;; Provides many functions for easily handling Emacs windows, emphasizing using
;; few keystrokes to make managing a number of use cases easy.
;; 

;;; Code:


(defun ez-fit-height (fraction)
  "Fits a window to 0.FRACTION of the height of the frame.  Accepts a numeric
prefix argument, otherwise asks the user."
  (interactive (list (if (and current-prefix-arg (numberp current-prefix-arg))
                         (number-to-string current-prefix-arg)
                       (read-string "Fit window height to 0."))))
  (let* ((dec (string-to-number (concat "0." fraction)))
         (fh (* (frame-height) dec))
         (h (window-height)))
    (message fraction)
    (enlarge-window (round (- fh h)))))

(defun ez-fit-width (fraction)
  "Fits a window to 0.FRACTION of the width of the frame.  Accepts a numeric
prefix argument, otherwise asks the user."
  (interactive (list (if (and current-prefix-arg (numberp current-prefix-arg))
                         (number-to-string current-prefix-arg)
                       (read-string "Fit window width to 0."))))
  (let* ((dec (string-to-number (concat "0." fraction)))
         (fh (* (frame-width) dec))
         (h (window-width)))
    (enlarge-window-horizontally (round (- fh h)))))

(defun ez-rotate (arg)
  "Rotates the current windows."
  (interactive "p")
  (if (eq (count-windows) 1)
      (message "Only one window!")
    (let ((winlist (if (< arg 0) (window-list) (reverse (window-list)))))
      (dotimes (i (1- (count-windows)))
        (let* ((w1 (elt winlist i))
               (w2 (elt winlist (1+ i)))
               (b1 (window-buffer w1))
               (b2 (window-buffer w2)))
          (set-window-buffer w1 b2)
          (set-window-buffer w2 b1))))))

(provide 'ezsplit)
;;; ezsplit.el ends here
