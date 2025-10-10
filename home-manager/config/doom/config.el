;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Vedant Pandey"
      user-mail-address "vedantpandey46@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(map! "C-k" #'evil-window-up
      "C-j" #'evil-window-down
      "C-h" #'evil-window-left
      "C-l" #'evil-window-right)

;; (map! :n "-" #'find-
;; (map! :v :leader "/" #'evilnc-comment-operator)
;; (map! :n :leader "/" #'comment-line)

(after! evil-escape
  (setq evil-escape-key-sequence "jk")
  (setq evil-escape-delay 0.2)
  (setq evil-escape-unordered-key-sequence t))

(after! evil-escape
  (setq evil-escape-key-sequence "jk")
  (setq evil-escape-delay 0.2)
  (setq evil-escape-unordered-key-sequence t))

(global-visual-line-mode t)

;; (after! evil-escape
;;   (setq evil-escape-key-sequence ""))
;;; project-sessionizer.el --- Project sessionizer for Doom Emacs -*- lexical-binding: t; -*-

;; Add this to your Doom Emacs config.el file

;;; project-sessionizer.el --- Project sessionizer for Doom Emacs -*- lexical-binding: t; -*-

;; Add this to your Doom Emacs config.el file

(defcustom project-sessionizer-dirs
  '("~/work" "~/ws" "~/personal" "~/personal/opensource" "~/personal/dotfiles")
  "List of directories to search for projects."
  :type '(repeat string)
  :group 'project-sessionizer)

(defcustom project-sessionizer-max-depth 1
  "Maximum depth to search for projects."
  :type 'integer
  :group 'project-sessionizer)

(defun project-sessionizer--get-all-projects ()
  "Get all projects from configured directories."
  (let ((projects '()))
    (dolist (dir project-sessionizer-dirs)
      (when (file-directory-p dir)
        (let ((expanded-dir (expand-file-name dir)))
          ;; Add the base directory itself
          (push expanded-dir projects)
          ;; Add subdirectories up to max-depth
          (when (> project-sessionizer-max-depth 0)
            (dolist (subdir (directory-files expanded-dir t "^[^.]"))
              (when (and (file-directory-p subdir)
                         (not (string-match-p "/\\." subdir)))
                (push subdir projects)))))))
    (reverse projects)))

(defun project-sessionizer--workspace-exists-p (name)
  "Check if a workspace with NAME already exists."
  (member name (persp-names)))

(defun project-sessionizer--switch-to-project-workspace (project-dir)
  "Switch to or create a workspace for PROJECT-DIR."
  (let* ((project-name (file-name-nondirectory (directory-file-name project-dir)))
         (workspace-name (replace-regexp-in-string "\\." "-" project-name)))

    ;; Check if workspace exists and switch to it, or create new
    (if (member workspace-name (persp-names))
        (progn
          (persp-switch workspace-name)
          (message "Switched to existing workspace: %s" workspace-name))
      (progn
        (persp-switch workspace-name)  ; This creates if doesn't exist
        (message "Created new workspace: %s" workspace-name)
        ;; Set default directory for new workspace
        (setq default-directory project-dir)
        ;; Open project in new workspace
        (projectile-switch-project-by-name project-dir)
        ;; Open a file or dired in new workspaces only
        (unless (buffer-file-name)
          (if (projectile-project-p)
              (projectile-find-file)
            (dired project-dir)))))))

(defun project-sessionizer--create-new-project ()
  "Create a new project directory."
  (let* ((parent-options '(("work" . "~/work")
                          ("personal" . "~/personal")
                          ("opensource" . "~/personal/opensource")))
         (parent-choice (completing-read "Parent directory: "
                                        (mapcar #'car parent-options)))
         (parent-dir (cdr (assoc parent-choice parent-options)))
         (project-name (read-string "Project name: "))
         (project-dir (expand-file-name project-name parent-dir)))

    ;; Create directory if it doesn't exist
    (unless (file-directory-p project-dir)
      (make-directory project-dir t)
      (message "Created directory: %s" project-dir))

    project-dir))

(defun project-sessionizer ()
  "Select a project directory and switch to its workspace.
Similar to tmux-sessionizer but for Doom Emacs workspaces."
  (interactive)
  (require 'projectile)

  (let* ((all-projects (project-sessionizer--get-all-projects))
         (create-option "[Create new project]")
         (choices (cons create-option all-projects))
         (selected (completing-read "Select project: " choices nil nil)))

    (if (string= selected create-option)
        (let ((new-project (project-sessionizer--create-new-project)))
          (project-sessionizer--switch-to-project-workspace new-project))
      (project-sessionizer--switch-to-project-workspace selected))))

(defun project-sessionizer-switch-workspace ()
  "Quick switch between existing project workspaces."
  (interactive)
  (+workspace/switch-to nil))

(defun project-sessionizer-kill-workspace ()
  "Kill current workspace and switch to previous."
  (interactive)
  (when (> (length (persp-names)) 1)
    (+workspace/delete (persp-current-name))
    (message "Workspace killed")))

;; Key bindings - add these to your config
(map! :leader
      (:prefix ("p" . "project")
       :desc "Project sessionizer" "s" #'project-sessionizer
       :desc "Switch workspace" "w" #'project-sessionizer-switch-workspace
       :desc "Kill workspace" "k" #'project-sessionizer-kill-workspace))

;; Alternative global keybindings (similar to tmux prefix)
(map! "C-x p s" #'project-sessionizer
      "C-x p w" #'project-sessionizer-switch-workspace
      "C-x p k" #'project-sessionizer-kill-workspace)

;; Bind C-f globally (unbind forward-char first)
(map! :n "C-f" nil  ; Unbind in normal mode
      :i "C-f" nil  ; Unbind in insert mode
      :v "C-f" nil  ; Unbind in visual mode
      :e "C-f" nil) ; Unbind in emacs mode

;; Now bind C-f to project-sessionizer
(map! "C-f" #'project-sessionizer)

;; Optional: Show workspace name in modeline (add to config.el)
(after! doom-modeline
  (setq doom-modeline-persp-name t))

;; Optional: Save and restore workspaces between sessions
(after! persp-mode
  (setq persp-save-dir (concat doom-cache-dir "workspaces/")
        persp-auto-save-opt 1  ; Auto-save on switch
        persp-auto-resume-time 1  ; Auto-resume on startup
        persp-auto-save-fname "autosave"
        persp-save-position t))

;; Optional: Ivy/Helm enhancement for better project selection
(when (modulep! :completion ivy)
  (defun project-sessionizer-ivy ()
    "Project sessionizer with ivy interface."
    (interactive)
    (require 'projectile)
    (ivy-read "Select project: "
              (cons "[Create new project]" (project-sessionizer--get-all-projects))
              :action (lambda (x)
                        (if (string= x "[Create new project]")
                            (let ((new-project (project-sessionizer--create-new-project)))
                              (project-sessionizer--switch-to-project-workspace new-project))
                          (project-sessionizer--switch-to-project-workspace x)))
              :caller 'project-sessionizer-ivy))

  (map! :leader "p s" #'project-sessionizer-ivy))


(map! "C-b C-n" #'+workspace/switch-right
      "C-b C-p" #'+workspace/switch-left
      "C-b C-c" #'+workspace:new)
