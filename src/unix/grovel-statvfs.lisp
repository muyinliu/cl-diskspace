;;;; grovel-statvfs.lisp

(in-package #:cl-diskspace)

(cc-flags "-I/usr/include")

(include "sys/statvfs.h")

;;; from sys/statvfs.h (/usr/include/sys/statvfs.h)
;; struct statvfs {
;;     unsigned long  f_bsize;    /* filesystem block size */
;;     unsigned long  f_frsize;   /* fragment size */
;;     fsblkcnt_t     f_blocks;   /* size of fs in f_frsize units */
;;     fsblkcnt_t     f_bfree;    /* # free blocks */
;;     fsblkcnt_t     f_bavail;   /* # free blocks for unprivileged users */
;;     fsfilcnt_t     f_files;    /* # inodes */
;;     fsfilcnt_t     f_ffree;    /* # free inodes */
;;     fsfilcnt_t     f_favail;   /* # free inodes for unprivileged users */
;;     unsigned long  f_fsid;     /* filesystem ID */
;;     unsigned long  f_flag;     /* mount flags */
;;     unsigned long  f_namemax;  /* maximum filename length */
;; };

(ctype fsblkcnt "fsblkcnt_t")
(ctype fsfilcnt "fsfilcnt_t")

(cstruct statvfs "struct statvfs"
	 (bsize   "f_bsize"   :type :unsigned-long)
	 (frsize  "f_frsize"  :type :unsigned-long)
	 (blocks  "f_blocks"  :type fsblkcnt)
	 (bfree   "f_bfree"   :type fsblkcnt)
	 (bavail  "f_bavail"  :type fsblkcnt)
	 (files   "f_files"   :type fsfilcnt)
	 (ffree   "f_ffree"   :type fsfilcnt)
	 (favail  "f_favail"  :type fsfilcnt)
	 (fsig    "f_fsid"    :type :unsigned-long)
	 (flag    "f_flag"    :type :unsigned-long)
	 (namemax "f_namemax" :type :unsigned-long))

(constant (st-rdonly "ST_RDONLY"))
(constant (st-nosuid "ST_NOSUID"))
