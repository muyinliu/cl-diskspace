;;;; cl-diskspace-get-logical-drives.lisp

(in-package :diskspace)

;; C++ Syntax from https://msdn.microsoft.com/en-us/library/windows/desktop/aa364972(v=vs.85).aspx
;; DWORD WINAPI GetLogicalDrives(void);
;; Return value
;; If the function succeeds, the return value is a bitmask representing the currently available disk drives. Bit position 0 (the least-significant bit) is drive A, bit position 1 is drive B, bit position 2 is drive C, and so on.
;; If the function fails, the return value is zero. To get extended error information, call GetLastError.
(defcfun ("GetLogicalDrives" %GetLogicalDrives)
    :int)

(defun GetLogicalDrives ()
  "Get logical drivers, return example: (\"C:\\\" \"D:\\\" \"W:\\\" \"Y:\\\" \"Z:\\\")."
  (let ((number (funcall #'%GetLogicalDrives))
        drive-list)
    (do ((index 0 (+ index 1)))
        ((<= (ash number (- index)) 0))
      (when (equal 1 (logand (ash number (- index)) 1))
        (push (format nil "~A:\\" (code-char (+ 65 index))) drive-list)))
    (reverse drive-list)))

(defun list-all-disks ()
  "List all logical drivers, return example: (\"C:\\\" \"D:\\\" \"W:\\\" \"Y:\\\" \"Z:\\\")."
  (GetLogicalDrives))
