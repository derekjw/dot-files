(setq custom-dir (file-name-directory
                  (or (buffer-file-name) load-file-name)))
(add-to-list 'load-path custom-dir)
(add-to-list 'load-path (concat custom-dir "scala-mode"))

(load "themes/tango")
(color-theme-tango)

(load "defuns")
(load "bindings")
(load "sbt")

(require 'scala-mode-auto)

