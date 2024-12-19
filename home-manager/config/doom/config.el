;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

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
;; (setq doom-theme 'doom-one)
(setq doom-theme 'catppuccin)

(setq mac-command-modifier 'meta) ; make cmd key do Meta
(setq mac-option-modifier 'super) ; make opt key do Super
(setq mac-control-modifier 'control)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type `relative)
(setq scroll-margin 16)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/personal/dotfiles/notes/orgmode/")
(setq select-enable-clipboard nil)
(setq! evil-want-Y-yank-to-eol nil)
(setq doom-font (font-spec :family "FiraCode Nerd Font Mono" :size 13)
      doom-big-font (font-spec :family "FiraCode Nerd Font Mono" :size 24))

(defun evil-operator-paste-before-from-clipboard ()
  :move-point nil
  (evil-paste-before 1 ?+))
(evil-define-operator evil-operator-paste-from-clipboard (beg end type)
  :move-point nil
  (evil-paste 1 ?+))
(evil-define-operator evil-operator-copy-to-clipboard (beg end type)
  "Copies text from BEG to END to system clipboard"
  :move-point nil
  (evil-yank beg end type ?+))
(map! :leader :desc "Clipboard yank" "y" #'evil-operator-copy-to-clipboard)
;; (map! :desc "Clipboard yank" "M-v" (defun temp (evil-paste-from-register ?+)))
(map! :leader :desc "Clipboard paste" "p" #'evil-operator-paste-from-clipboard)
(map! :leader :desc "Clipboard paste before" "P" #'evil-operator-paste-before-from-clipboard)

(tab-bar-mode 1)

(map! :n "C-p" #'previous-buffer)
(map! :n "C-n" #'next-buffer)
(map! :leader :desc "Save Buffer" "b w" #'save-buffer)
(map! :after evil-org :map evil-org-mode-map :ni "M-<return>" #'org-insert-heading-respect-content)
(map! :leader :desc "Comment lines" :v "/" (cmd! (evilnc-comment-or-uncomment-region) (evil-visual-restore)))
(map! :leader :desc "Comment lines" :n "/" #'evilnc-comment-or-uncomment-lines)
(map! :n "C-z" #'recenter-top-bottom)
;; (map! :leader :desc "Yank to clipboard" "y")
;; (map! :nvig  "C-b" #'+workspace/display)
(map! :prefix-map ("C-b" . "Workspace")
      :desc "Switch workspace right" :nvig "C-n" #'+workspace/switch-right
      :desc "Switch workspace right" :nvig "C-p" #'+workspace/switch-left
      :desc "Display all workspaces" :nvig "C-b" #'+workspace/display
      :desc "Rename current workspace" :nvig "," #'+workspace/rename
      :desc "New workspace" :nvig "C-c" #'+workspace/new
      :desc "Kill current workspace" :nvig "C-d" #'+workspace/kill
      :desc "Workspace switcher" :nvig "C-w" #'+workspace/switch-to
      :desc "Switch to 0 Workspace" :nvig "1" #'+workspace/switch-to-0
      :desc "Switch to 1 Workspace" :nvig "2" #'+workspace/switch-to-1
      :desc "Switch to 2 Workspace" :nvig "3" #'+workspace/switch-to-2
      :desc "Switch to 3 Workspace" :nvig "4" #'+workspace/switch-to-3
      :desc "Switch to 4 Workspace" :nvig "5" #'+workspace/switch-to-4
      :desc "Switch to 5 Workspace" :nvig "6" #'+workspace/switch-to-5
      :desc "Switch to 6 Workspace" :nvig "7" #'+workspace/switch-to-6
      :desc "Switch to 7 Workspace" :nvig "8" #'+workspace/switch-to-7
      :desc "Switch to 8 Workspace" :nvig "9" #'+workspace/switch-to-8
      :desc "Switch to final Workspace" :nvig "0" #'+workspace/switch-to-final)


(map! :n "C-h" #'evil-window-left)
(map! :n "C-h" #'evil-window-left)
(map! :n "C-j" #'evil-window-down)
(map! :n "C-k" #'evil-window-up)
;; (map! :vin "M-v" #'evil-command-window-execute)
(map!
 :v "s-j" (cmd! (evil-ex-execute "'<,'>m '>+1"))
 :v "s-k" (cmd! (evil-ex-execute "'<,'>m '<-2"))
 :n "s-j" (cmd! (evil-ex-execute "m .+1"))
 :n "s-k" (cmd! (evil-ex-execute "m .-2"))
 )

(map! :leader :desc "Quit window" :n "b q" #'evil-quit)
(map! :leader :desc "Quit All" :n "b a" #'evil-quit-all)

(map! :leader
      :prefix-map ("z" . "amazon")
      (:prefix ("b" . "browse")
       :desc "Browse source at point"  "s" #'amz-browse-source-at-point
       :desc "Browse git ref"          "g" #'amz-browse-git-ref-at-point
       :desc "Browse git ref at point" "r" #'amz-browse-git-ref
       :desc "Browse package at point" "p" #'amz-browse-package-at-point)
      (:prefix ("w" . "workspace")
       :desc "Create workspace"        "c" #'amz-workspace-create-workspace
       :desc "Delete workspace"        "d" #'amz-workspace-delete-workspace
       :desc "Add package"             "a" #'amz-workspace-add-package
       :desc "Use version set"         "u" #'amz-workspace-use-version-set
       :desc "Sync workspace"          "s" #'amz-workspace-sync-workspace))


(after! doom-modeline
  (setq doom-modeline-persp-name t))
















;;; -*- lexical-binding: t; -*-

(require 'projectile)
(require 'consult)
(require 'orderless)

(defvar project-dirs
  (list (expand-file-name "~/work")
        (expand-file-name "~/personal")
        (expand-file-name "~/personal/opensource")
        (expand-file-name "~/personal/onest"))
  "List of root directories to search for projects.")

(defvar create-new-project-text "Create New Project"
  "Text displayed in completion to create new project.")

;; Configure orderless for fuzzy matching
(setq completion-styles '(orderless basic)
      completion-category-defaults nil
      completion-category-overrides '((file (styles . (partial-completion)))))

;; Enhanced completion function with fuzzy matching
(defun fuzzy-completing-read (prompt candidates)
  "Read a string in the minibuffer with fuzzy matching."
  (let ((completion-styles '(orderless)))
    (completing-read prompt candidates
                     nil t nil 'file-name-history)))

(defun get-all-project-dirs ()
  "Get all immediate subdirectories from project-dirs."
  (let ((dirs '()))
    (dolist (dir project-dirs)
      (when (file-directory-p dir)
        (dolist (subdir (directory-files dir t))
          (when (and (file-directory-p subdir)
                     (not (string-match "/\\.$" subdir))
                     (not (string-match "/\\.\\.$" subdir)))
            (push subdir dirs)))))
    dirs))

(defun create-new-project (root-dir project-name)
  "Create a new project directory in ROOT-DIR with PROJECT-NAME."
  (let ((project-path (expand-file-name project-name root-dir)))
    (if (file-exists-p project-path)
        (message "Directory already exists: %s" project-path)
      (make-directory project-path t)
      project-path)))

(defun get-root-dir-selection ()
  "Prompt user to select a root directory from project-dirs."
  (fuzzy-completing-read
   "Select root directory: "
   (mapcar (lambda (dir)
             (file-name-nondirectory (directory-file-name dir)))
           project-dirs)))

(defun switch-to-project-dir ()
  (interactive)
  (let* ((projects (sort (cons create-new-project-text (get-all-project-dirs))))
         (selection (fuzzy-completing-read
                     "Select project: "
                     (mapcar (lambda (path)
                               (if (stringp path)
                                   (replace-regexp-in-string
                                    (regexp-quote (expand-file-name "~/"))
                                    "~/"
                                    path)
                                 path))
                             projects))))
    (if (string= selection create-new-project-text)
        (let* ((root-dir-name (get-root-dir-selection))
               (root-dir (car (cl-remove-if-not
                               (lambda (dir)
                                 (string= (file-name-nondirectory
                                           (directory-file-name dir))
                                          root-dir-name))
                               project-dirs)))
               (project-name (read-string "Project name: "))
               (project-path (create-new-project root-dir project-name)))
          (when project-path
            (projectile-switch-project-by-name project-path)))
      (let ((full-path (if (string-prefix-p "~/" selection)
                           (expand-file-name selection)
                         selection)))
        (projectile-switch-project-by-name full-path)))))

;; Bind the command to C-f
;; (map! :leader
;;       :desc "Switch/Create Project"
;;       "p s" #'switch-to-project-dir)

;; Optional: Also bind to C-f globally
(map! :nvig "C-f" #'switch-to-project-dir)
(setq doom-auto-restore-session t)

(use-package orderless
  :custom
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

;; Optional: Make the completion window more visually appealing
(after! vertico
  (setq vertico-count 20)
  (setq vertico-cycle t))

;; If you want to use vertico-posframe for a floating completion window
;; (use-package! vertico-posframe
;;   :config
;;   (vertico-posframe-mode 1)
;;   (setq vertico-posframe-parameters
;;         '((left-fringe . 8)
;;           (right-fringe . 8)))
;;   (setq vertico-posframe-border-width 2)
;;   (setq vertico-posframe-width 100)
;;   (setq vertico-posframe-height 20))


















;; Optional: Also bind to C-f globally
;; (map! :nvig "C-f" #'switch-to-project-dir)



;; Set env variables
(setenv "JAVA_HOME" "/Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home")
;; Add fnm node version to path
(when-let ((node-path (substitute-in-file-name "$HOME/.fnm")))
  (setenv "PATH" (concat (getenv "PATH") ":" node-path))
  (setq exec-path (append exec-path (list node-path))))

;; If you have a specific node version activated, also add its bin path
(when-let ((node-bin (substitute-in-file-name "$HOME/.fnm/current/bin")))
  (setenv "PATH" (concat (getenv "PATH") ":" node-bin))
  (setq exec-path (append exec-path (list node-bin))))

;; JAVA LSP CONFIG
(after! lsp-java
  (setq lsp-java-java-path "/Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home/bin/java"
        lsp-java-configuration-runtimes '[(:name "JavaSE-17"
                                           :path "/Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home/"
                                           :default t)]
        ;; Increase memory if needed
        lsp-java-vmargs '("-noverify"
                          "-Xmx1G"
                          "-XX:+UseG1GC"
                          "-XX:+UseStringDeduplication"
                          (concat "-javaagent:" (substitute-in-file-name "$HOME/bin/lombok.jar"))
                          ;; Add these additional settings
                          lsp-java-completion-overwrite t
                          lsp-java-format-on-type-enabled t
                          lsp-java-import-gradle-enabled t
                          lsp-java-import-maven-enabled t)))

;; If you want to show all buffers in tabs
(after! centaur-tabs
  (centaur-tabs-mode t)
  (setq centaur-tabs-height 32
        centaur-tabs-set-icons t
        centaur-tabs-set-bar 'under
        centaur-tabs-show-navigation-buttons t
        centaur-tabs-set-modified-marker t
        centaur-tabs-modified-marker "●"
        centaur-tabs-buffer-groups-function #'centaur-tabs-projectile-buffer-groups))

;; Optional: Customize which buffers to show/hide
;; (setq centaur-tabs-excluded-prefixes
;;       '("*Messages*" "*scratch*" "*doom*" "*Backtrace*" "*"))

;; AMAZON JAVA CONFIG
(use-package eglot
  :hook ((java-mode . eglot-ensure)
         (typescript-mode . eglot-ensure))
  :init
  :defer t
  :config

  (defun husain-eglot-generate-workspace-folders (server)
    "Generate the workspaceFolders value for the workspace.

This is implemented by returning the content of .bemol/ws_root_folders file"
    (let* ((root (project-root (project-current)))
           (ws-root (file-name-parent-directory
                     (file-name-parent-directory root)))
           (bemol-root (file-name-concat ws-root ".bemol/"))
           (bemol-ws-root-folders (file-name-concat bemol-root "ws_root_folders"))
           (ws-root-folders-content)
           (ws-folders-for-eglot))
      (if (not (file-exists-p bemol-ws-root-folders))
          (eglot-workspace-folders server))
      (setq ws-root-folders-content (with-temp-buffer
                                      (insert-file-contents bemol-ws-root-folders)
                                      (split-string (buffer-string) "\n" t)))
      (setq ws-folders-for-eglot (mapcar (lambda (o) (concat "file://" o))
                                         ws-root-folders-content))
      (vconcat ws-folders-for-eglot)))

  (add-to-list 'eglot-server-programs
               `(java-mode
                 . ("jdtls"
                    ;; The following allows jdtls to find definition
                    ;; if the code lives outside the current project.
                    :initializationOptions
                    ,(lambda (server)
                       `(:workspaceFolders ,(husain-eglot-generate-workspace-folders server)
                         :extendedClientCapabilities
                         (:classFileContentsSupport t
                          :classFileContentsSupport t
                          :overrideMethodsPromptSupport t
                          :hashCodeEqualsPromptSupport t
                          :advancedOrganizeImportsSupport t
                          :generateToStringPromptSupport t
                          :advancedGenerateAccessorsSupport t
                          :generateConstructorsPromptSupport t
                          :generateDelegateMethodsPromptSupport t
                          :advancedExtractRefactoringSupport t
                          :moveRefactoringSupport t
                          :clientHoverProvider t
                          :clientDocumentSymbolProvider t
                          :advancedIntroduceParameterRefactoringSupport t
                          :actionableRuntimeNotificationSupport t
                          :extractInterfaceSupport t
                          :advancedUpgradeGradleSupport t))))))

  ;; The jdt server sometimes returns jdt:// scheme for jumping to definition
  ;; instead of returning a file. This is not part of LSP and eglot does not
  ;; handle it. The following code enables eglot to handle jdt files.
  ;; See https://github.com/yveszoundi/eglot-java/issues/6 for more info.
  (defun jdt-file-name-handler (operation &rest args)
    "Support Eclipse jdtls `jdt://' uri scheme."
    (let* ((uri (car args))
           (cache-dir "/tmp/.eglot")
           (source-file
            (directory-abbrev-apply
             (expand-file-name
              (file-name-concat
               cache-dir
               (save-match-data
                 (when (string-match "jdt://contents/\\(.*?\\)/\\(.*\\)\.class\\?" uri))
                 (message "URI:%s" uri)
                 (format "%s.java" (replace-regexp-in-string "/" "." (match-string 2 uri) t t))))))))
      (unless (file-readable-p source-file)
        (let ((content (jsonrpc-request (eglot-current-server) :java/classFileContents (list :uri uri)))
              (metadata-file (format "%s.%s.metadata"
                                     (file-name-directory source-file)
                                     (file-name-base source-file))))
          (message "content:%s" content)
          (unless (file-directory-p cache-dir) (make-directory cache-dir t))
          (with-temp-file source-file (insert content))
          (with-temp-file metadata-file (insert uri))))
      source-file))

  (add-to-list 'file-name-handler-alist '("\\`jdt://" . jdt-file-name-handler))

  (defun jdthandler--wrap-legacy-eglot--path-to-uri (original-fn &rest args)
    "Hack until eglot is updated.
ARGS is a list with one element, a file path or potentially a URI.
If path is a jar URI, don't parse. If it is not a jar call ORIGINAL-FN."
    (let ((path (file-truename (car args))))
      (if (equal "jdt" (url-type (url-generic-parse-url path)))
          path
        (apply original-fn args))))

  (defun jdthandler--wrap-legacy-eglot--uri-to-path (original-fn &rest args)
    "Hack until eglot is updated.
ARGS is a list with one element, a URI.
If URI is a jar URI, don't parse and let the `jdthandler--file-name-handler'
handle it. If it is not a jar call ORIGINAL-FN."
    (let ((uri (car args)))
      (if (and (stringp uri)
               (string= "jdt" (url-type (url-generic-parse-url uri))))
          uri
        (apply original-fn args))))

  (defun jdthandler-patch-eglot ()
    "Patch old versions of Eglot to work with Jdthandler."
    (interactive) ;; TODO, remove when eglot is updated in melpa
    (unless (and (advice-member-p #'jdthandler--wrap-legacy-eglot--path-to-uri 'eglot--path-to-uri)
                 (advice-member-p #'jdthandler--wrap-legacy-eglot--uri-to-path 'eglot--uri-to-path))
      (advice-add 'eglot--path-to-uri :around #'jdthandler--wrap-legacy-eglot--path-to-uri)
      (advice-add 'eglot--uri-to-path :around #'jdthandler--wrap-legacy-eglot--uri-to-path)
      (message "[jdthandler] Eglot successfully patched.")))

  ;; invoke
  (jdthandler-patch-eglot))

(defun my/get-bws-root ()
  "Get the root directory from bws command if available."
  (let ((bws-output (shell-command-to-string "bws show -r . -f json 2>/dev/null | jq \".root\"")))
    (unless (string-empty-p bws-output)
      (string-trim bws-output "\"\n" "\"\n"))))

(defun my/get-project-root ()
  "Get the project root based on priority: bws > git > current directory."
  (or (my/get-bws-root)
      (when (locate-dominating-file default-directory ".git")
        (expand-file-name (locate-dominating-file default-directory ".git")))
      default-directory))

(defun my/centaur-tabs-group-by-project ()
  "Custom group function for centaur-tabs."
  (let* ((project-root (my/get-project-root))
         (file-path (or (buffer-file-name) "")))
    (if (string-prefix-p project-root file-path)
        (file-name-nondirectory (directory-file-name project-root))
      "Common")))

;; Set the grouping function for centaur-tabs
(after! centaur-tabs
  (setq centaur-tabs-group-by-function #'my/centaur-tabs-group-by-project)
  (setq centaur-tabs-set-bar 'left))

;; Optional: Customize which buffers to show/hide
(setq centaur-tabs-excluded-prefixes
      '("*Messages*" "*scratch*" "*doom*" "*Backtrace*" "*"))

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
