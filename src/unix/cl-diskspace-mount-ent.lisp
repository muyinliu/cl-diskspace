(in-package #:cl-diskspace)

(cffi:defcstruct mntent
  (mnt_fsname :string)
  (mnt_dir    :string)
  (mnt_type   :string)
  (mnt_opts   :string)
  (mnt_freq   :int)
  (mnt_passno :int))

(cffi:defcfun (set-mntent "setmntent") :pointer (filename :string) (type :string))

(cffi:defcfun (get-mntent "getmntent") :pointer (stream :pointer))

(cffi:defcfun (end-mntent "endmntent") :int (stream :pointer))

(defun lispify-plist-mntent (struct-as-plist)
  (mapcar (lambda (a)
            (if (symbolp a)
                (cffi:translate-underscore-separated-name (symbol-name a))
                a))
          struct-as-plist))
