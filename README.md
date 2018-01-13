# cl-diskspace

cl-diskspace is a Common Lisp feature to list disks with command line tool `df`(Linux/Mac) or `GetLogicalDrives`(Windows), and get disk space information using `statvfs`(Unix/Linux/Mac) or `GetDiskFreeSpace`(Windows), supports Unix/Linux/Mac/Windows.


## License

Copyright (c) 2015 Muyinliu Xing
Released under the ISC License.

## Compatibility

|  Common Lisp  |  Linux  |  Mac |  Unix | Windows |
|---------------|:-------:|:----:|:-----:|:-------:|
|  SBCL         |   Yes   |  Yes |       |   Yes   |

Note: I don't have Unix system so haven't test on Unix yet.

Note: Have test in Windows XP/Windows 7/Windows 8.1/Windows 10

Note: Welcome to reply test results in other Common Lisp implements.

## Install and load with QuickLisp

In shell:
```shell
git clone https://github.com/muyinliu/cl-diskspace.git
cp -r cl-diskspace ~/quicklisp/local-projects/
```
In Common Lisp: 
```lisp
(ql:quickload 'cl-diskspace)
```

## Usage

### List all disks

```lisp
(diskspace:list-all-disks)
```
Will get something like this:
```=>
("/" "/Volumes/Seagate1T")
```
Note: result in Mac

```lisp
(diskspace:list-all-disks)
```
Will get something like this:
```=>
("C:\\" "D:\\")
```
Note: result in Windows

### Get all disk space information

```lisp
(diskspace:list-all-disk-info)
```
Will get something like this:
```=>
((:DISK "/" :TOTAL 127175917568 :FREE 16509661184 :AVAILABLE
16247517184 :USE-PERCENT 87))
```

### Get all disk space information in human-readable

```lisp
(diskspace:list-all-disk-info t)
```
Will get something like this:
```=>
((:DISK "/" :TOTAL "118.44G" :FREE "15.38G" :AVAILABLE
"15.13G" :USE-PERCENT 87))
```

### Get disk space information

```lisp
(diskspace:disk-space "/")
```
Will get something like this:
```
127175917568
16509661184
16247517184
```
Note: the total space is 118.44G, free space is 15.38G and available space is 15.13G

### Get disk space information in human-readable

```lisp
(diskspace:disk-space "/" t)
```
Will get something like this:
```
"118.44G"
"15.38G"
"15.13G"
```

### Get disk total space

```lisp
(diskspace:disk-total-space "/")
```
Will get something like this:
```
127175917568
```

### Get disk total space in human-readable

```lisp
(diskspace:disk-total-space "/" t)
```
Will get something like this:
```
"118.4G"
```

### Get disk free space

```lisp
(diskspace:disk-free-space "/")
```
Will get something like this:
```
16509661184
```

### Get disk free space in human-readable

```lisp
(diskspace:disk-free-space "/" t)
```
Will get something like this:
```
"15.38G"
```

### Get disk available space

```lisp
(diskspace:disk-available-space "/")
```
Will get something like this:
```
16247517184
```

### Get disk available space in human-readable

```lisp
(diskspace:disk-available-space "/" t)
```
Will get something like this:
```
"15.13G"
```
