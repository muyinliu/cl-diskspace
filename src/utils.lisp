;;;; utils.lisp

(in-package #:cl-diskspace)

(defun size-in-human-readable (number)
  (check-type number integer)
  (loop for size in '(80 70 60 50 40 30 20 10)
     and unit in '("YB" "ZB" "EB" "PB" "TB" "GB" "MB" "KB")
     when (> (ash number (- size)) 0)
     do (return-from size-in-human-readable
          (format nil "~,2F ~A"
                  (float (/ number (ash 1 size)))
                  unit))))
