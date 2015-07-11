#cl-diskspace

cl-diskspace is a Common Lisp feature to get disk space information using statvfs, supports Unix/Linux/Mac/Windows.


##License
Copyright (c) 2015 Muyinliu Xing
Released under the ISC License.

##Compatibility
|  Common Lisp  |  Linux  |  Mac |  Unix | Windows |
|-------------|------|-----|-----|-------|
|  SBCL           |    Yes   |   Yes  |         |  Yes  |

##Install
```
$ git clone https://github.com/muyinliu/cl-diskspace.git
$ cp -r cl-diskspace ~/quicklisp/local-projects/
```

##Load
Using QuickLisp to load cl-diskspace.
```
(ql:quickload 'cl-diskspace)
```

##Usage
###Get disk space information
```
(diskspace:disk-space "/")
```
Will get something like this:
```
127175917568
16509661184
16247517184
```
Means that the total space is 118.44G, free space is 15.38G and available space is 15.13G

###Get disk total space
```
(diskspace:disk-total-space "/")
```
Will get something like this:
```
127175917568
```

###Get disk free space
```
(diskspace:disk-free-space "/")
```
Will get something like this:
```
16509661184
```

###Get disk available space
```
(diskspace:disk-available-space "/")
```
Will get something like this:
```
16247517184
```
