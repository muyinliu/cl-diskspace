;;;; packages.lisp

(defpackage #:cl-diskspace
  (:use #:cl
        #:cffi
        #:cffi-grovel)
  (:nicknames :diskspace)
  (:export #:disk-space
           #:disk-total-space
           #:disk-free-space
           #:disk-available-space))
