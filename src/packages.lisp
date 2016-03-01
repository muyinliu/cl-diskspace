;;;; packages.lisp

(defpackage #:cl-diskspace
  (:use #:cl
        #:cffi
        #:cffi-grovel)
  (:nicknames :diskspace :ds)
  (:export #:list-all-disks
           #:list-all-disk-info
           #:disk-space
           #:disk-total-space
           #:disk-free-space
           #:disk-available-space
           #:size-in-human-readable))
