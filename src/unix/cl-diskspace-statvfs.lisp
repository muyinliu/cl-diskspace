;;;; cl-diskinfo-statvfs.lisp

(in-package #:cl-diskspace)

;; int statvfs(const char *path, struct statvfs *buf);
(defcfun ("statvfs" %statvfs)
    :int
  (path :string)
  (buf :pointer))

;;;; sys/statvfs.h

(defun statvfs (path)
  (with-foreign-object (buf '(:struct statvfs))
    (funcall #'%statvfs path buf)
    (with-foreign-slots ((bsize frsize blocks bfree bavail files
                          ffree favail fsig flag namemax)
                         buf (:struct statvfs))
      (values bsize frsize blocks bfree bavail files
              ffree favail fsig flag namemax))))

;;;; High level APIs

(defun disk-space (path &optional human-readable-p)
  "Disk space information include total/free/available space."
  (multiple-value-bind (bsize frsize blocks bfree bavail files
                              ffree favail fsig flag namemax)
      (statvfs path)
    (declare (ignore bsize files ffree favail fsig flag namemax))
    (if human-readable-p
        (values (size-in-human-readable (* frsize blocks))
                (size-in-human-readable (* frsize bfree))
                (size-in-human-readable (* frsize bavail)))
        (values (* frsize blocks) (* frsize bfree) (* frsize bavail)))))

(defun disk-total-space (path &optional human-readable-p)
  "Disk total space."
  (multiple-value-bind (bsize frsize blocks bfree bavail files
			      ffree favail fsig flag namemax)
      (statvfs path)
    (declare (ignore bsize bfree bavail files ffree favail fsig flag namemax))
    (if human-readable-p
        (size-in-human-readable (* frsize blocks))
        (* frsize blocks))))

(defun disk-free-space (path &optional human-readable-p)
  "Disk free space."
  (multiple-value-bind (bsize frsize blocks bfree bavail files
			      ffree favail fsig flag namemax)
      (statvfs path)
    (declare (ignore bsize blocks bavail files ffree favail fsig flag namemax))
    (if human-readable-p
        (size-in-human-readable (* frsize bfree))
        (* frsize bfree))))

(defun disk-available-space (path &optional human-readable-p)
  "Disk available space."
  (multiple-value-bind (bsize frsize blocks bfree bavail files
			      ffree favail fsig flag namemax)
      (statvfs path)
    (declare (ignore bsize blocks bfree files ffree favail fsig flag namemax))
    (if human-readable-p
        (size-in-human-readable (* frsize bavail))
        (* frsize bavail))))
