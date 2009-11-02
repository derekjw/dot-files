(add-to-list 'load-path (file-name-directory
                         (or (buffer-file-name) load-file-name))) 

(load "themes/tango")
(color-theme-tango)

(load "defuns")
(load "bindings")
(load "scala-mode")
(load "sbt")
