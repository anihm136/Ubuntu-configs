;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
(setq user-full-name "Anirudh H M"
      user-mail-address "anisupremeg136@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; test
(setq doom-font (font-spec :family "Iosevka" :size 16))
;; doom-variable-pitch-font (font-spec "sans"))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-one)

;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/org/")

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.
(load! "private/evil-unimpaired")

(setq-default +evil-want-o/O-to-continue-comments nil)

(setq-default evil-escape-key-sequence "fd"
              evil-escape-delay 0.3)

(setq-default company-idle-delay 0
              company-minimum-prefix-length 1)
;; (company-tng-configure-default)
(eval-after-load 'company
  '(progn
     (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
     (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)))
(setq-default company-frontends
              '(company-tng-frontend
                company-pseudo-tooltip-unless-just-one-frontend
                company-echo-metadata-frontend))
(map! :mode prog-mode "C-s" 'company-yasnippet)


(require 'doom-modeline)
(doom-modeline-mode 1)
(setq doom-modeline-modal-icon nil
      doom-modeline-persp-name nil
      doom-modeline-unicode-fallback t
      doom-modeline-major-mode-color-icon nil
      doom-modeline-buffer-modification-icon nil
      doom-modeline-column-zero-based t)

(setq projectile-project-search-path '("~/Projects"))

(global-git-commit-mode t)

(map! :map global-map :desc "ace-window" :leader "ww" 'ace-window)
(map! :map global-map :desc "Toggle treemacs" :leader "0" 'treemacs-select-window)

(add-hook 'eshell-mode-hook (lambda() (setq-local company-mode nil)))

(add-hook 'treemacs-mode-hook (lambda()
                                (setq-local golden-ratio-mode nil)
                                (treemacs-set-width 35)))
(add-hook 'treemacs-select-hook (lambda()
                                (treemacs-set-width 35)))

(use-package! golden-ratio
  :after-call pre-command-hook
  :config
  (golden-ratio-mode +1)
  ;; Using this hook for resizing windows is less precise than
  ;; `doom-switch-window-hook'.
  ;; (remove-hook 'window-configuration-change-hook #'golden-ratio))
  (add-hook 'doom-switch-window-hook #'golden-ratio))
