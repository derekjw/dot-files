;; Before anything else happens, cleanup gui
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

(autoload 'my-site-start (concat dotfiles-dir "my-site-start") nil t)
(my-site-start (concat dotfiles-dir "/site-start.d/"))
