;;; ansi-colorful.el --- Toggle render ansi-color  -*- lexical-binding: t; -*-

;; Copyright (C) 2024  Shen, Jen-Chieh

;; Author: Shen, Jen-Chieh <jcs090218@gmail.com>
;; Maintainer: Shen, Jen-Chieh <jcs090218@gmail.com>
;; URL: https://github.com/jcs-elpa/ansi-colorful
;; Version: 0.1.0
;; Package-Requires: ((emacs "26.1"))
;; Keywords: faces

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Toggle render `ansi-color'.
;;

;;; Code:

(require 'ansi-color)
(require 'cl-lib)

(defgroup ansi-colorful nil
  "Toggle render `ansi-color'."
  :prefix "ansi-colorful-"
  :group 'tool
  :link '(url-link :tag "Repository" "https://github.com/jcs-elpa/ansi-colorful"))

(defvar-local ansi-colorful--ovs nil
  "Overlays created by `ansi-color'.")

(defun ansi-colorful--remove-ovs ()
  "Remove `ansi-color' overlays."
  (mapc #'delete-overlay ansi-colorful--ovs))

(defun ansi-colorful--enable ()
  "Enable `ansi-colorful-mode'."
  (let ((buffer-read-only)
        (ovs (overlays-in (point-min) (point-max))))
    (ansi-color-apply-on-region (point-min) (point-max) t)
    (dolist (ov (overlays-in (point-min) (point-max)))
      (unless (cl-some (lambda (this-ov) (equal this-ov ov)) ovs)
        (push ov ansi-colorful--ovs)))))

(defun ansi-colorful--disable ()
  "Disable `ansi-colorful-mode'."
  (ansi-colorful--remove-ovs))

;;;###autoload
(define-minor-mode ansi-colorful-mode
  "Minor mode `ansi-colorful-mode'."
  :lighter " ANSI-Colorful"
  :group ansi-colorful
  (if ansi-colorful-mode (ansi-colorful--enable) (ansi-colorful--disable)))

(provide 'ansi-colorful)
;;; ansi-colorful.el ends here
