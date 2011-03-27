 (defun terminal-init-putty ()
  "Terminal initialization function for putty."
  ;; Use the xterm color initialization code.
  (load "term/xterm")
  (xterm-register-default-colors)
  (tty-set-up-initial-frame-faces))
