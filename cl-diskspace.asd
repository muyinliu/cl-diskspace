;;;; cl-diskspace.asd

(asdf:defsystem "cl-diskspace"
  :name "diskspace"
  :description "List disks, get disk total/free/usable space information."
  :version "0.3.1"
  :author "Muyinliu Xing <muyinliu@gmail.com>"
  :license "ISC"
  :defsystem-depends-on ("cffi-grovel")
  :depends-on ("cffi"
               #+(or bsd freebsd linux)
               "cl-ppcre"
               "uiop")
  :serial t
  :components
  ((:module "src"
            :serial t
            :components
            ((:file "packages")
             (:file "utils")
             #+(or bsd freebsd linux)
             (:module "unix"
                      :serial t
                      :components
                      ((:cffi-grovel-file "grovel-statvfs")
                       (:file "cl-diskspace-list-all-disks-with-df")
                       (:file "cl-diskspace-statvfs")))
             #+win32
             (:module "win32"
                      :serial t
                      :components
                      ((:file "cl-diskspace-load-foreign-library")
                       (:file "cl-diskspace-get-logical-drives")
                       (:file "cl-diskspace-get-disk-free-space")))
             (:file "common")))))
