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
(setq doom-font (font-spec :family "Iosevka Nerd Font Mono" :size 16)
      doom-variable-pitch-font (font-spec :family "Overpass" :weight 'normal :size 16))

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

(defvar dark-themes '(doom-one doom-gruvbox doom-solarized-dark doom-spacegrey doom-monokai-pro doom-tomorrow-night)
  "Set of dark themes to choose from.")

(defvar light-themes '(doom-gruvbox-light doom-solarized-light doom-flatwhite)
  "Set of light themes to choose from.")

;; Eager loading
(setq-default tab-width 2
              standard-indent 2
              org-download-image-dir "./images"
              org-download-heading-lvl 'nil
              ispell-dictionary "en-custom"
              ispell-personal-dictionary (expand-file-name ".ispell_personal" doom-private-dir)
              )

(custom-set-faces! '(font-lock-comment-face :slant italic))

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
  (smart-tabs-add-language-support py python-mode-hook
    ((python-indent-line-function . standard-indent)))
  (smart-tabs-insinuate 'c 'c++ 'py))

;; Deferred loading

(use-package! org
  :defer t
  :config
  (setq org-default-notes-file (concat org-directory "inbox.org")
        org-refile-use-outline-path 'file
        org-outline-path-complete-in-steps nil
        org-refile-allow-creating-parent-nodes 'confirm
        org-catch-invisible-edits 'show
        org-startup-folded 'content
        org-log-done 'time
        org-log-into-drawer t
        org-log-state-notes-insert-after-drawers nil
        org-export-preserve-breaks t
        org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
          (sequence "WAITING(w@)" "DEFERRED(f)" "|" "CANCEL(x@)"))
        org-todo-keyword-faces
        (quote (("NEXT" . org-level-7)
                ("WAITING" . org-level-7)
                ("DEFERRED" . org-level-7)))
        org-capture-templates
        '(("t" "Todo" entry (file+headline org-default-notes-file "Tasks")
           "* TODO %? %^G\n %i\n")
          ("l" "org-protocol-capture" entry (file+headline org-default-notes-file "Reading")
           "* TODO [[%:link][%:description]]\n\n %i"
           :immediate-finish t)
          ("k" "Cliplink capture task" entry (file+headline org-default-notes-file "Reading")
           "* TODO %(org-cliplink-capture)\n" :immediate-finish t))
        )
  (with-eval-after-load 'flycheck
    (flycheck-add-mode 'proselint 'org-mode))
  (org-wild-notifier-mode)
  )
(add-hook! 'org-mode-hook 'org-fragtog-mode)

(use-package! org-agenda
  :defer t
  :config
  (setq org-agenda-files (directory-files-recursively org-directory "\.org$")
        org-columns-default-format "%40ITEM(Task) %Effort(EE){:} %CLOCKSUM(Time Spent) %SCHEDULED(Scheduled) %DEADLINE(Deadline)"
        org-agenda-skip-scheduled-if-done t
        org-agenda-skip-deadline-if-done t)
  (setq org-agenda-custom-commands `((" " "Agenda"
                                      ((agenda ""
                                               ((org-agenda-overriding-header "Weekly Agenda")
                                                (org-agenda-span 'week)
                                                (org-deadline-warning-days 365)))
                                       (tags-todo "CATEGORY=\"refile\""
                                                  ((org-agenda-overriding-header "To Refile")
                                                   (org-agenda-files (list (concat org-directory "inbox.org")))))
                                       (todo "NEXT"
                                             ((org-agenda-overriding-header "In Progress")
                                              (org-agenda-files (append (list
                                                                         (concat org-directory "projects.org")
                                                                         (concat org-directory "tasks.org")
                                                                         (concat org-directory "inbox.org")))
                                                                )))
                                       (todo "TODO"
                                             ((org-agenda-overriding-header "Projects")
                                              (org-agenda-files (append (list (concat org-directory "projects.org"))))
                                              ))
                                       (todo "TODO"
                                             ((org-agenda-overriding-header "Tasks")
                                              (org-agenda-files (list (concat org-directory "tasks.org")))
                                              (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'scheduled))))))))

  (setq org-refile-targets '((nil :maxlevel . 3)
                             (org-agenda-files :maxlevel . 3))))


(use-package! org-projectile
  :after org
  :config
  (progn
    (setq
     org-projectile-capture-template "* TODO %?"
     org-projectile-projects-file (concat org-directory "projects.org"))
    (add-to-list 'org-capture-templates
                 (org-projectile-project-todo-entry
                  :capture-character "p"))
    (setq org-link-elisp-confirm-function nil)))

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
  :init
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

(use-package auto-activating-snippets
  :hook (LaTeX-mode . auto-activating-snippets-mode)
  :hook (org-mode . auto-activating-snippets-mode)
  :config
  (aas-set-snippets 'org-mode
                    "**" (lambda () (interactive)
                           (yas-expand-snippet "*$0*"))
                    "$$" (lambda () (interactive)
                           (yas-expand-snippet "\$$0\$"))
                    "//" (lambda () (interactive)
                           (yas-expand-snippet "/$0/"))))

(use-package! latex-auto-activating-snippets
  :after latex ; auctex's LaTeX package
  :config ; do whatever here
  (aas-set-snippets 'latex-mode
                    ;; set condition!
                    :cond #'texmathp ; expand only while in math
                    "supp" "\\supp"
                    "On" "O(n)"
                    "O1" "O(1)"
                    "Olog" "O(\\log n)"
                    "Olon" "O(n \\log n)"))

(use-package! counsel-gtags
  :init
  (map! :leader :prefix "c" (:prefix ("g" . "gtags")
                             :desc "Goto definition" "d" 'counsel-gtags-find-definition
                             :desc "Find symbol" "s" 'counsel-gtags-dwim
                             :desc "Goto reference" "r" 'counsel-gtags-find-reference))
  :commands (counsel-gtags-dwim counsel-gtags-find-definition counsel-gtags-find-reference))

(use-package! ivy-posframe
  :defer t
  :config
  (setq ivy-posframe-display-functions-alist '((counsel-M-x . nil)
                                               (swiper . nil)
                                               (t . ivy-posframe-display-at-frame-center))
        ivy-posframe-height-alist '((t . 10))
        ivy-posframe-parameters '((internal-border-width . 6))
        ivy-posframe-width 100))

(use-package! org-download
  :config
  (setq
   org-download-method 'directory
   org-download-timestamp "%Y%m%d-%H%M%S_"
   org-download-link-format "[[file:%s]]\n"
   org-download-link-format-function
   (lambda (filename)
     (format (concat (unless (image-type-from-file-name filename)
                       (concat (+org-attach-icon-for filename)
                               " "))
                     org-download-link-format)
             (org-link-escape (file-relative-name filename))))
   org-image-actual-width 400))

(after! org-archive
  (defun ani/org-archive-done-tasks ()
    (interactive)
    (org-map-entries 'org-archive-subtree "/DONE" 'file)
    (org-map-entries 'org-archive-subtree "/CANCEL" 'file))
  (defadvice org-archive-subtree (around my-org-archive-subtree activate)
    (let ((org-archive-location
           (if (save-excursion (org-back-to-heading)
                               (> (org-outline-level) 1))
               (concat (car (split-string org-archive-location "::"))
                       "::* "
                       (car (org-get-outline-path)))
             org-archive-location)))
      ad-do-it))
  )

(use-package! org-wild-notifier
  :config
  (setq org-wild-notifier-alert-time '(60 30 15 5))
  (org-wild-notifier-mode))

(after! latex-mode (auto-latex-snippets-mode t))

(add-hook! 'prog-mode-hook (lambda ()(modify-syntax-entry ?_ "w")))

(add-hook! 'after-init-hook '+ani/my-init-func)

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
  (setq-default uniquify-buffer-name-style 'forward
                window-combination-resize t
                x-stretch-cursor t)
  (setq lsp-signature-doc-lines 1
        company-idle-delay nil
        evil-want-fine-undo t
        inhibit-compacting-font-caches t
        evil-vsplit-window-right t
        evil-split-window-below t
        doom-fallback-buffer-name "► Doom"
        +doom-dashboard-name "► Doom"
        +evil-want-o/O-to-continue-comments nil
        alert-default-style 'libnotify)
  (map! :nv "C-a" 'evil-numbers/inc-at-pt
        :nv "C-S-x" 'evil-numbers/dec-at-pt
        :v "g C-a" 'evil-numbers/inc-at-pt-incremental
        :v "g C-S-x" 'evil-numbers/dec-at-pt-incremental
        :nv "M-j" 'drag-stuff-down
        :nv "M-k" 'drag-stuff-up
        :v "o" "$"
        :desc "Transpose function argument to the right"
        :n "g>" '(lambda () (interactive) (transpose-args-direction t))
        :desc "Transpose function argument to the left"
        :n "g<" '(lambda () (interactive) (transpose-args-direction nil))
        :n "]p" 'unimpaired-paste-below
        :n "[p" 'unimpaired-paste-above
        :desc "Paste in insert mode"
        :i "C-v" "C-r +"
        :desc "Set random theme"
        :n "<f12>" 'ani/set-random-theme
        :n "S-<f12>" (λ! () (ani/set-random-theme 't))
        ))


(defun ani/set-random-theme (&optional light)
  "Set the theme to a random dark theme.
If LIGHT is non-nil, use a random light theme instead."
  (interactive)
  (random t)
  (let ((themes (if light light-themes dark-themes)))
    (load-theme (nth (random (length themes)) themes) t))
  (princ (cdr custom-enabled-themes)))
