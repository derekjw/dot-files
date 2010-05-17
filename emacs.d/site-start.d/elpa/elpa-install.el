(require 'cl)

(defvar elpa-packages (list 'clojure-mode
                            'css-mode
                            'haml-mode
                            'js2-mode
                            'json
                            'magit)
  "Libraries that should be installed by default.")

(defun elpa-install ()
  "Install all packages that aren't installed."
  (interactive)
  (dolist (package elpa-packages)
    (unless (or (member package package-activated-list)
                (functionp package))
      (message "Installing %s" (symbol-name package))
      (package-install package))))

(defun elpa-online? ()
  "See if we're online.

Windows does not have the network-interface-list function, so we
just have to assume it's online."
  ;; TODO how could this work on Windows?
  (if (and (functionp 'network-interface-list)
           (network-interface-list))
      (some (lambda (iface) (unless (equal "lo" (car iface))
                         (member 'up (first (last (network-interface-info
                                                   (car iface)))))))
            (network-interface-list))
    t))

;; On your first run, this should pull in all the base packages.
(when (elpa-online?)
  (unless package-archive-contents (package-refresh-contents))
  (elpa-install))

(provide 'elpa-install)
