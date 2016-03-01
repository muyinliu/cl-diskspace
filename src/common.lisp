;;;; common.lisp

(in-package #:cl-diskspace)

(defun list-all-disk-info (&optional human-readable-p)
  "List disk information. example result: 
\(\(:DISK \"/\" :TOTAL 19993329664 :FREE 6154420224 :AVAILABLE 6154420224
  :USE-PERCENT 69)
 \(:DISK \"/mnt\" :TOTAL 21136445440 :FREE 2048335872 :AVAILABLE 974667776
  :USE-PERCENT 95))

\(\(:DISK \"/\" :TOTAL \"18.62 GB\" :FREE \"5.73 GB\" :AVAILABLE \"5.73 GB\" :USE-PERCENT
  69)
 \(:DISK \"/mnt\" :TOTAL \"19.68 GB\" :FREE \"1.91 GB\" :AVAILABLE \"929.52 MB\"
  :USE-PERCENT 95))"
  (loop for disk in (list-all-disks)
     collect (multiple-value-bind (total free available)
                 (disk-space disk)
               (if human-readable-p
                   (list :disk disk
                         :total (size-in-human-readable total)
                         :free (size-in-human-readable free)
                         :available (size-in-human-readable available)
                         :use-percent (truncate (/ (* (- total available) 100) total)))
                   (list :disk disk
                         :total total
                         :free free
                         :available available
                         :use-percent (truncate (/ (* (- total available) 100) total)))))))
