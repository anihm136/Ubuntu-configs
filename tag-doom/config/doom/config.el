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

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

(setq org-directory "~/Documents/org/GTD/")

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


;; Utility variables

(defconst ani/org-directory "~/Documents/org/"
  "The default directory for org files.")

(defvar dark-themes '(doom-one doom-gruvbox doom-solarized-dark doom-spacegrey doom-monokai-pro doom-moonlight doom-tomorrow-night)
  "Set of dark themes to choose from.")

(defvar light-themes '(doom-gruvbox-light doom-solarized-light)
  "Set of light themes to choose from.")

;; Eager loading

(define-derived-mode tsx-mode web-mode "TSX mode")
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-mode))
(after! flycheck
  (flycheck-add-mode 'javascript-eslint 'tsx-mode)
  (add-hook! '(tsx-mode-local-vars-hook js2-mode-local-vars-hook typescript-mode-local-vars-hook) (lambda () (flycheck-add-next-checker 'lsp 'javascript-eslint))))

(setq-default tab-width 2
              standard-indent 2)

(use-package! evil-escape
  :config
  (setq evil-escape-key-sequence "fd"
        evil-escape-delay 0.3))

(use-package! aggressive-indent
  :config
  (aggressive-indent-global-mode))

(use-package! doom-modeline
  :config
  (setq doom-modeline-indent-info t
        doom-modeline-unicode-fallback t
        doom-modeline-buffer-file-name-style 'truncate-upto-root))

(use-package! smart-tabs-mode
  :config
  (smart-tabs-add-language-support jsx rjsx-mode-hook
    ((js2-jsx-indent-line . standard-indent)))
  (smart-tabs-add-language-support ts typescript-mode-hook
    ((typescript-indent-line . standard-indent)))
  (smart-tabs-add-language-support tsx tsx-mode-hook
    ((typescript-tsx-indent-line . standard-indent)))
  (smart-tabs-add-language-support py python-mode-hook
    ((python-indent-line-function . standard-indent)))
  (smart-tabs-insinuate 'c 'c++ 'java 'javascript 'jsx 'ts 'tsx 'py))

;; Deferred loading

(use-package! org
  :defer t
  :init
  :config
  (defun ani/org-archive-done-tasks ()
    (interactive)
    (org-map-entries 'org-archive-subtree "/DONE" 'file)
    (org-map-entries 'org-archive-subtree "/\[X\]" 'file))
  (map! :map org-mode-map
        :n "C-c A" 'ani/org-archive-done-tasks)
  (setq org-default-notes-file (concat org-directory "inbox.org")
        org-refile-use-outline-path 'file
        org-outline-path-complete-in-steps nil
        org-refile-allow-creating-parent-nodes 'confirm
        org-catch-invisible-edits 'show
        org-startup-folded 'content
        org-log-done 'time
        org-log-into-drawer t
        org-log-state-notes-insert-after-drawers nil
        org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)" "[X](x@)"))
        org-todo-keyword-faces
        (quote (("NEXT" :foreground "orange" :weight bold)
                ("[X]" :foreground "red" :weight bold)))
        org-capture-templates
        '(("t" "Todo" entry (file+headline org-default-notes-file "Tasks")
           "* TODO %? %^G\n %i\n")
          ("c" "org-protocol-capture" entry (file+headline org-default-notes-file "Reading")
           "* TODO [[%:link][%:description]]\n\n %i"
           :immediate-finish t)
          ("k" "Cliplink capture task" entry (file+headline org-default-notes-file "Reading")
           "* TODO %(org-cliplink-capture)\n" :immediate-finish t))
        )
  (with-eval-after-load 'flycheck
    (flycheck-add-mode 'proselint 'org-mode))
  (org-wild-notifier-mode))


(use-package! org-agenda
  :defer t
  :config
  (setq org-agenda-files (directory-files-recursively org-directory "\.org$")
        org-columns-default-format "%40ITEM(Task) %Effort(EE){:} %CLOCKSUM(Time Spent) %SCHEDULED(Scheduled) %DEADLINE(Deadline)"))

(use-package org-projectile
  :after org
  :config
  (defun org-projectile-get-project-todo-file (project-path)
    (concat
     (file-name-as-directory project-path) (concat
                                            (file-name-base (directory-file-name project-path))
                                            "_plan.org")))
  (progn
    (org-projectile-per-project)
    (setq org-projectile-capture-template "* TODO %?")
    (add-to-list 'org-capture-templates
                 (org-projectile-project-todo-entry
                  :capture-character "p"))
    (setq org-link-elisp-confirm-function nil)
    (setq org-agenda-custom-commands `((" " "Agenda"
                                        ((agenda ""
                                                 ((org-agenda-span 'week)
                                                  (org-deadline-warning-days 365)))
                                         (todo "TODO"
                                               ((org-agenda-overriding-header "To Refile")
                                                (org-agenda-files (list (concat org-directory "inbox.org")))))
                                         (todo "NEXT"
                                               ((org-agenda-overriding-header "In Progress")
                                                (org-agenda-files (append (list (concat org-directory "someday.org")
                                                                                (concat org-directory "projects.org")
                                                                                (concat org-directory "next.org")
                                                                                (concat org-directory "inbox.org"))
                                                                          (org-projectile-todo-files)))
                                                ))
                                         (todo "TODO"
                                               ((org-agenda-overriding-header "Projects")
                                                (org-agenda-files (append (list (concat org-directory "projects.org"))
                                                                          (org-projectile-todo-files)))
                                                ))
                                         (todo "TODO"
                                               ((org-agenda-overriding-header "One-off Tasks")
                                                (org-agenda-files (list (concat org-directory "next.org")))
                                                (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'scheduled))))))))
    (setq org-agenda-files (nconc org-agenda-files (org-projectile-todo-files)))
    (setq org-refile-targets '((nil :maxlevel . 3)
                               (org-agenda-files :maxlevel . 3)))))

(use-package! org-protocol
  :defer t
  :config
  (setq org-protocol-default-template-key "c"))

(use-package! org-roam
  :defer t
  :custom-face
  (org-roam-link ((t (:inherit org-link :foreground "#009600"))))
  :config
  (setq org-roam-directory (concat ani/org-directory "notes/")
        org-roam-db-location (concat org-roam-directory "org-roam.db")
        org-roam-completion-fuzzy-match t
        org-roam-capture-templates
        '(("d" "default" plain (function org-roam-capture--get-point)
           "%?"
           :file-name "${slug}"
           :head "#+TITLE: ${title}\n"
           :unnarrowed t))
        org-roam-buffer-width 0.25))

(use-package! projectile
  :defer t
  :config
  (setq projectile-project-search-path '("~/Projects" "~/Projects/forks"))
  )

(use-package! magit
  :defer t
  :config
  (setq magit-repository-directories '(("~/Projects/" . 2))
        global-git-commit-mode t))

(use-package! company
  :defer t
  :config
  (setq company-frontends '(company-pseudo-tooltip-unless-just-one-frontend
                            company-preview-if-just-one-frontend
                            company-echo-metadata-frontend)))

(use-package! counsel-gtags
  :init
  (map! :leader :prefix "c" (:prefix ("g" . "gtags")
                             :desc "Goto definition" "d" 'counsel-gtags-find-definition
                             :desc "Find symbol" "s" 'counsel-gtags-dwim
                             :desc "Goto reference" "r" 'counsel-gtags-find-reference))
  :commands (counsel-gtags-dwim counsel-gtags-find-definition counsel-gtags-find-reference))

(use-package! python
  :defer t
  :hook (python-mode . importmagic-mode)
  :config
  (after! lsp-python-ms
    (set-lsp-priority! 'mspyls 1))
  (with-eval-after-load 'lsp-ui
    (flycheck-add-next-checker 'lsp 'python-flake8)))

(use-package! jupyter
  :after python)

(after! (:any js rjsx-mode typescript-mode tsx-mode)
  (setq flycheck-javascript-eslint-executable "eslint_d")
  (with-eval-after-load 'lsp-ui
    (flycheck-add-next-checker 'lsp 'javascript-eslint)))

(after! typescript-mode
  (setq typescript-indent-level standard-indent))

(after! (rjsx-mode js2-mode)
  (setq js-indent-level standard-indent))

(use-package! org-wild-notifier
  :config
  (org-wild-notifier-mode))

(add-hook! 'prog-mode-hook (lambda ()(modify-syntax-entry ?_ "w")))

(add-hook! 'after-init-hook '+ani/my-init-func)

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

(defun unimpaired-paste-above ()
  (interactive)
  (evil-insert-newline-above)
  (evil-paste-after 1 evil-this-register))

(defun unimpaired-paste-below ()
  (interactive)
  (evil-insert-newline-below)
  (evil-paste-after 1 evil-this-register))

(defun +ani/my-init-func ()
  "Function to run on init"
  (global-subword-mode t)
  (ani/set-random-theme "dark")
  (setq lsp-auto-guess-root nil
        lsp-signature-doc-lines 1
        company-idle-delay nil
        +evil-want-o/O-to-continue-comments nil
        alert-default-style 'libnotify)
  (map! :nv "C-a" 'evil-numbers/inc-at-pt
        :nv "C-S-x" 'evil-numbers/dec-at-pt
        :v "g C-a" 'evil-numbers/inc-at-pt-incremental
        :v "g C-S-x" 'evil-numbers/dec-at-pt-incremental
        :v "R" 'evil-multiedit-match-all
        :n "g>" '(lambda () (interactive) (transpose-args-direction t))
        :n "g<" '(lambda () (interactive) (transpose-args-direction nil))
        :n "]p" 'unimpaired-paste-below
        :n "[p" 'unimpaired-paste-above
        :i "C-v" "C-r +"
        :n "<f12>" 'ani/set-random-theme))


(defun ani/set-random-theme (&optional color)
  "Set the theme to a random dark theme. If COLOR is provided (one of dark and light), set a random theme of that COLOR."
  (interactive)
  (random t)
  (if (string-equal (or color "dark") "light")
      (funcall 'load-theme (nth (random (length light-themes)) light-themes) t)
    (funcall 'load-theme (nth (random (length dark-themes)) dark-themes) t))
  (princ custom-enabled-themes))
