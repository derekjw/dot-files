;; Before anything else happens, cleanup gui
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(set-default-font "-unknown-DejaVu Sans Mono-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")
(set-frame-width (selected-frame) 160)
(set-frame-height (selected-frame) 40)

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

(require 'cl)
(require 'saveplace)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)

(autoload 'my-site-start (concat dotfiles-dir "my-site-start") nil t)
(my-site-start (concat dotfiles-dir "/site-start.d/"))
