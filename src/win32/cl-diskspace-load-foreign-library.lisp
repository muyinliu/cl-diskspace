;;;; cl-diskspace-load-foreign-library.lisp

(in-package :diskspace)

(define-foreign-library kernel32
  (:windows "C:/WINDOWS/system32/kernel32.dll"))

(use-foreign-library kernel32)

