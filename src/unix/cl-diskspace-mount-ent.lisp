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

(defun mntent-all-infos (&optional (mount-info-file "/etc/mtab"))
  (let ((root-info (set-mntent mount-info-file "r"))
        (infos     '()))
    (if (not (cffi:null-pointer-p root-info))
        (labels ((get-info ()
                   (let ((info (get-mntent root-info)))
                     (if (not (cffi:null-pointer-p info))
                         (progn
                           (push (cffi:convert-from-foreign info '(:struct mntent))
                                 infos)
                           (get-info))
                         infos))))
          (mapcar #'lispify-plist-mntent (get-info)))
        (error (format nil "Can not open ~a" mount-info-file)))))

(defun mntent-info (mtab plist-key looking-for-value)
  (let ((all-infos (mntent-all-infos mtab)))
    (find-if (lambda (a)
               (let ((value-found (getf a plist-key nil)))
                 (and value-found
                      (string= value-found looking-for-value))))
             all-infos)))

(defun mountpoint-to->* (mount-info-file mountpoint key)
  (let ((infos (mntent-info mount-info-file 'mnt-dir mountpoint)))
    (and infos
         (getf infos key nil))))

(defun mountpoint->device (mountpoint &optional (mount-info-file "/etc/mtab"))
  (mountpoint-to->* mount-info-file mountpoint 'mnt-fsname))

(defun mountpoint->fstype (mountpoint &optional (mount-info-file "/etc/mtab"))
  (mountpoint-to->* mount-info-file mountpoint 'mnt-type))

(defun mountpoint->mnt-options (mountpoint &optional (mount-info-file "/etc/mtab"))
  (let* ((raw            (mountpoint-to->* mount-info-file mountpoint 'mnt-opts))
         (comma-splitted (cl-ppcre:split "," raw)))
    (loop for i in comma-splitted collect
         (if (cl-ppcre:scan "=" i)
             (cl-ppcre:split "=" i)
             i))))
