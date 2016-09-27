;;;; cl-diskspace-list-all-disks-with-df.lisp

(in-package :diskspace)

#+(or linux bsd freebsd)
(defun list-all-disks ()
  "List all physical disk use command line tool df. note: size in KB."
  (let ((disk-info-string (with-output-to-string (stream)
                            (uiop/run-program:run-program
                             #+linux
                             "df | grep ^/dev"
                             #+bsd
                             "df -k | grep ^/dev"
                             :output stream))))
    (loop for disk-info in (ppcre:split "\\n" disk-info-string)
       collect
         #+linux
         (ppcre:register-groups-bind (filesystem size used available use-percent mounted-on)
             ("^(.+)\\s+(\\d+)\\s+(\\d+)\\s+(\\d+)\\s+(\\d+)%\\s+(.+)$"
              disk-info)
           (declare (ignore filesystem size used available use-percent))
           (string-trim '(#\Space) mounted-on))
         ;; for Mac OS X
         #+bsd
         (ppcre:register-groups-bind (filesystem size used available use-percent
                                                 iused ifree iuse-percent mounted-on)
             ("^(.+)\\s+(\\d+)\\s+(\\d+)\\s+(\\d+)\\s+(\\d+)%\\s+(\\d+)\\s+(\\d+)\\s+(\\d+)%\\s+(.+)$"
              disk-info)
           (declare (ignore filesystem size used available use-percent
                            iused ifree iuse-percent))
           (string-trim '(#\Space) mounted-on)))))
