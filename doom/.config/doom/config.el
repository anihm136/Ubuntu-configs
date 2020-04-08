;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Anirudh H M"
      user-mail-address "anihm136@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "mononoki Nerd Font" :size 16))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.


;; Eager loading

(define-derived-mode tsx-mode web-mode "TSX mode")
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-mode))
(after! flycheck
  (flycheck-add-mode 'javascript-eslint 'tsx-mode)
  (add-hook 'tsx-mode-hook (lambda () (flycheck-add-next-checker 'lsp 'javascript-eslint))))

(setq-default tab-width 2
              standard-indent 2)

(setq lsp-auto-guess-root nil)

(add-hook! 'prog-mode-hook (lambda ()(modify-syntax-entry ?_ "w")))

(use-package! evil-escape
  :config
  (setq evil-escape-key-sequence "fd"
        evil-escape-delay 0.3))

(use-package! org-wild-notifier
  :commands org-wild-notifier-mode)

(use-package! aggressive-indent
  :config
  (aggressive-indent-global-mode))

(use-package! doom-modeline
  :config
  (setq doom-modeline-indent-info t
        doom-modeline-unicode-fallback t
        doom-modeline-buffer-file-name-style 'truncate-upto-root))

;; Deferred loading

(use-package! org
  :defer t
  :config
  (setq org-directory "~/Documents/org/"
        org-default-notes-file (concat org-directory "/default.org")
        org-agenda-files (list org-directory)
        org-refile-targets '((org-agenda-files :maxlevel . 2))
        org-refile-use-outline-path 'file
        org-outline-path-complete-in-steps nil
        org-refile-allow-creating-parent-nodes 'confirm
        org-startup-folded 'content
        org-log-done 'time
        org-log-into-drawer t
        org-log-state-notes-insert-after-drawers nil
        org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
          (sequence "|" "[X](x@)"))
        org-todo-keyword-faces
        (quote (("NEXT" :foreground "orange" :weight bold)
                ("[X]" :foreground "red" :weight bold)))
        org-capture-templates
        '(("t" "Todo" entry (file+headline org-default-notes-file "Tasks")
           "* TODO %? %^G\n U\n %i\n")
          ("n" "Note" entry (file+headline org-default-notes-file "Notes")
           "* %? %^G\n %U\n %i\n"))
        )
  (org-wild-notifier-mode)
  (with-eval-after-load 'flycheck
    (flycheck-add-mode 'proselint 'org-mode)))

(use-package! projectile
  :defer t
  :config
  (setq projectile-project-search-path '("~/Projects" "~/Projects/forks"))
  )

(use-package! magit
  :defer t
  :config
  (setq magit-repository-directories '(("~/Projects/" . 2))
        git-magit-status-fullscreen t
        global-git-commit-mode t))

(use-package! company
  :defer t
  :config
  (setq company-frontends '(company-pseudo-tooltip-unless-just-one-frontend
                            company-preview-if-just-one-frontend
                            company-echo-metadata-frontend)))

(use-package! python
  :defer t
  :hook (python-mode . importmagic-mode))

(after! (:any js rjsx-mode typescript-mode tsx-mode)
  (setq flycheck-javascript-eslint-executable "eslint_d"))

(after! typescript-mode
  (setq typescript-indent-level standard-indent))

(after! (rjsx-mode js2-mode)
  (setq js-indent-level standard-indent))

(map! :localleader
      (:after rjsx-mode
        :map rjsx-mode-map
        "f" 'eslintd-fix)
      (:after js2-mode
        :map js2-mode-map
        "f" 'eslintd-fix)
      (:after typescript-mode
        :map typescript-mode-map
        "f" 'eslintd-fix)
      (:after tsx-mode
        :map tsx-mode-map
        "f" 'eslintd-fix))

;; Utility functions and keymaps

(defun forward-to-argsep ()
  (interactive)
  (while (progn (comment-forward most-positive-fixnum)
                (looking-at "[^,)]"))
    (condition-case ex (forward-sexp)
      ('scan-error (if (looking-at "[<>]")
                       (forward-char)
                     (throw ex nil)))))
  (point))

(defun backward-to-argsep ()
  (interactive)
  (let ((pt (point)) cur)
    (up-list -1)
    (while (looking-at "<")
      (up-list -1))
    (forward-char)
    (while (progn (setq cur (point))
                  (> pt (forward-to-argsep)))
      (forward-char))
    (goto-char cur)))

(defun transpose-args-direction (is_forward)
  (interactive)
  (let* ((pt-original (point))
         (pt (progn (when (not is_forward)
                      (goto-char (- (backward-to-argsep) 1))
                      (unless (looking-at ",")
                        (goto-char pt-original)
                        (user-error "Argument separator not found")))
                    (point)))
         (b (backward-to-argsep))
         (sep (progn (goto-char pt)
                     (forward-to-argsep)))
         (e (progn (unless (looking-at ",")
                     (goto-char pt-original)
                     (user-error "Argument separator not found"))
                   (forward-char)
                   (forward-to-argsep)))
         (ws-first (buffer-substring-no-properties
                    (goto-char b)
                    (progn (skip-chars-forward "[[:space:]\n]")
                           (point))))
         (first (buffer-substring-no-properties (point) sep))
         (ws-second (buffer-substring-no-properties
                     (goto-char (1+ sep))
                     (progn (skip-chars-forward "[[:space:]\n]")
                            (point))))
         (second (buffer-substring-no-properties (point) e)))
    (delete-region b e)
    (insert ws-first second "," ws-second first)

    (if is_forward
        (goto-char (+ (- (point) (length first))
                      (- pt b (length ws-first))))
      (goto-char (+ b (length ws-first)
                    (- pt-original (+ pt 1 (length ws-second))))))))

(map! :nv "C-a" 'evil-numbers/inc-at-pt
      :nv "C-S-x" 'evil-numbers/dec-at-pt
      :v "R" 'evil-multiedit-match-all
      :n "g=" "mmgg=G'm"
      :n "g>" '(lambda () (interactive) (transpose-args-direction t))
      :n "g<" '(lambda () (interactive) (transpose-args-direction nil))
      :i "C-v" "C-r +")
