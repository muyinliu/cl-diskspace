(in-package #:cl-diskspace)

(defcstruct mntent
  (mnt_fsname :string)
  (mnt_dir    :string)
  (mnt_type   :string)
  (mnt_opts   :string)
  (mnt_freq   :int)
  (mnt_passno :int))

(defcfun (set-mntent "setmntent") :pointer (filename :string) (type :string))

(defcfun (get-mntent "getmntent") :pointer (stream :pointer))

(defcfun (end-mntent "endmntent") :int (stream :pointer))

(defun lispify-plist-mntent (struct-as-plist)
  (mapcar (lambda (a)
            (if (symbolp a)
                (translate-underscore-separated-name (symbol-name a))
                a))
          struct-as-plist))
