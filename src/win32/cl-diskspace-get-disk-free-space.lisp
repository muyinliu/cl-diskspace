;;;; cl-diskspace-get-disk-free-space-ex.lisp

(in-package :diskspace)

;; C++ Syntax from https://msdn.microsoft.com/en-us/library/windows/desktop/aa364935(v=vs.85).aspx
;; BOOL WINAPI GetDiskFreeSpace(
;;   _In_  LPCTSTR lpRootPathName,
;;   _Out_ LPDWORD lpSectorsPerCluster,
;;   _Out_ LPDWORD lpBytesPerSector,
;;   _Out_ LPDWORD lpNumberOfFreeClusters,
;;   _Out_ LPDWORD lpTotalNumberOfClusters
;; );

(defcfun ("GetDiskFreeSpaceA" %GetDiskFreeSpace)
    :boolean
  (lpRootPathName :string)
  (lpSectorsPerCluster :pointer)
  (lpBytesPerSector :pointer)
  (lpNumberOfFreeClusters :pointer)
  (lpTotalNumberOfClusters :pointer))

(defun GetDiskFreeSpace (path)
  (with-foreign-string (lpRootPathName path)
    (with-foreign-pointer (lpSectorsPerCluster 32)
      (with-foreign-pointer (lpBytesPerSector 32)
        (with-foreign-pointer (lpNumberOfFreeClusters 32)
          (with-foreign-pointer (lpTotalNumberOfClusters 32)
            (funcall #'%GetDiskFreeSpace lpRootPathName lpSectorsPerCluster
                     lpBytesPerSector lpNumberOfFreeClusters lpTotalNumberOfClusters)
            (values (mem-ref lpSectorsPerCluster :int)
                    (mem-ref lpBytesPerSector :int)
                    (mem-ref lpNumberOfFreeClusters :int)
                    (mem-ref lpTotalNumberOfClusters :int))))))))

;;; High level API

(defun disk-space (path &optional human-readable-p)
  "Disk space information include total/free/available space."
  (multiple-value-bind (sectorsPerCluster bytesPerSector numberOfFreeClusters
                                          totalNumberOfClusters)
      (GetDiskFreeSpace path)
    (if human-readable-p
        (values (size-in-human-readable (* sectorsPerCluster
                                           bytesPerSector
                                           totalNumberOfClusters))
                (size-in-human-readable (* sectorsPerCluster
                                           bytesPerSector
                                           numberOfFreeClusters))
                (size-in-human-readable (* sectorsPerCluster
                                           bytesPerSector
                                           numberOfFreeClusters)))
        (values (* sectorsPerCluster bytesPerSector totalNumberOfClusters)
                (* sectorsPerCluster bytesPerSector numberOfFreeClusters)
                (* sectorsPerCluster bytesPerSector numberOfFreeClusters)))))

(defun disk-total-space (path &optional human-readable-p)
  (multiple-value-bind (sectorsPerCluster bytesPerSector numberOfFreeClusters
                                          totalNumberOfClusters)
      (GetDiskFreeSpace path)
    (if human-readable-p
        (size-in-human-readable (* sectorsPerCluster bytesPerSector totalNumberOfClusters))
        (* sectorsPerCluster bytesPerSector totalNumberOfClusters))))

(defun disk-free-space (path &optional human-readable-p)
  (multiple-value-bind (sectorsPerCluster bytesPerSector numberOfFreeClusters
                                          totalNumberOfClusters)
      (GetDiskFreeSpace path)
    (if human-readable-p
        (size-in-human-readable (* sectorsPerCluster bytesPerSector numberOfFreeClusters))
        (* sectorsPerCluster bytesPerSector numberOfFreeClusters))))

(defun disk-available-space (path &optional human-readable-p)
  (multiple-value-bind (sectorsPerCluster bytesPerSector numberOfFreeClusters
                                          totalNumberOfClusters)
      (GetDiskFreeSpace path)
    (if human-readable-p
        (size-in-human-readable (* sectorsPerCluster bytesPerSector numberOfFreeClusters))
        (* sectorsPerCluster bytesPerSector numberOfFreeClusters))))
