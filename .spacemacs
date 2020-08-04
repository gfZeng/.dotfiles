;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     (auto-completion :variables
                      auto-completion-return-key-behavior 'complete
                      auto-completion-tab-key-behavior 'cycle
                      auto-completion-enable-sort-by-usage t
                      auto-completion-complete-with-key-sequence nil
                      auto-completion-private-snippets-directory nil)
     better-defaults
     emacs-lisp
     git
     markdown
     multiple-cursors
     (spell-checking :variables
                     spell-checking-enable-by-default nil)
     syntax-checking
     treemacs
     version-control

     (evil-snipe :variables evil-snipe-enable-alternate-f-and-t-behaviors t)

     (chinese :variables
              chinese-default-input-method nil
              chinese-enable-youdao-dict t)
     osx
     evil-cleverparens
     tmux
     lsp

     julia

     clojure
     (python :variables
             python-shell-completion-native-enable nil
             python-fill-column 99)
     ruby
     react
     html
     yaml
     nginx
     lua
     (sql :variables
          sql-capitalize-keywords t)
     )

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   ;; To use a local version of a package, use the `:location' property:
   ;; '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages '(visual-fill-column
                                      evil-terminal-cursor-changer
                                      toml-mode
                                      q-mode
                                      systemd
                                      sqlup-mode)

   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '(company-tern)

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need
   ;; to compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; File path pointing to emacs 27.1 executable compiled with support
   ;; for the portable dumper (this is currently the branch pdumper).
   ;; (default "emacs-27.0.50")
   dotspacemacs-emacs-pdumper-executable-file "emacs-27.0.50"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=~/.emacs.d/.cache/dumps/spacemacs.pdmp
   ;; (default spacemacs.pdmp)
   dotspacemacs-emacs-dumper-dump-file "spacemacs.pdmp"

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. (default nil)
   dotspacemacs-use-spacelpa t

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default nil)
   dotspacemacs-verify-spacelpa-archives nil

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style '(hybrid :variables
                                        hybrid-mode-enable-hjkl-bindings t)

   ;; If non-nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Default major mode for a new empty buffer. Possible values are mode
   ;; names such as `text-mode'; and `nil' to use Fundamental mode.
   ;; (default `text-mode')
   dotspacemacs-new-empty-buffer-major-mode 'text-mode

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1.5)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font or prioritized list of fonts.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 10.0
                               :weight normal
                               :width normal)

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state nil

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil

   ;; If non-nil the frame is undecorated when Emacs starts up. Combine this
   ;; variable with `dotspacemacs-maximized-at-startup' in OSX to obtain
   ;; borderless fullscreen. (default nil)
   dotspacemacs-undecorated-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t', `relative' or `visual' then line numbers are enabled in all
   ;; `prog-mode' and `text-mode' derivatives. If set to `relative', line
   ;; numbers are relative. If set to `visual', line numbers are also relative,
   ;; but lines are only visual lines are counted. For example, folded lines
   ;; will not be counted and wrapped lines are counted as multiple lines.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :visual nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; When used in a plist, `visual' takes precedence over `relative'.
   ;; (default nil)
   dotspacemacs-line-numbers nil

   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server t

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env))

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  (advice-add
   #'spacemacs/load-theme :around
   (lambda (f theme &optional fallback-theme disable)
     (if (display-graphic-p)
         (funcall f theme fallback-theme disable)
       (message "Ignore load theme for nw-mode"))))

  (setq-default
   exec-path-from-shell-check-startup-files nil
   ;; exec-path-from-shell-arguments '("-l")
   vc-follow-symlinks t
   sp-highlight-pair-overlay nil

   web-mode-markup-indent-offset 2
   css-indent-offset 2
   ;; js2-mode
   js2-basic-offset 2
   ;; web-mode
   css-indent-offset 2
   js-indent-level 2
   web-mode-markup-indent-offset 2
   web-mode-css-indent-offset 2
   web-mode-code-indent-offset 2
   web-mode-attr-indent-offset 2

   paradox-github-token "7933a31544bedc8960479ed06457f091276c568d"

   pyim-isearch-enable-pinyin-search nil

   cider-repl-history-file "~/.nrepl-history"

   js2-strict-trailing-comma-warning nil
   ns-pop-up-frames nil
   projectile-enable-caching t
   line-spacing 0.03
   tags-add-tables nil
   tags-revert-without-query t)
  (with-eval-after-load 'web-mode
    (add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
    (add-to-list 'web-mode-indentation-params '("lineup-concats" . nil))
    (add-to-list 'web-mode-indentation-params '("lineup-calls" . nil)))
  )

(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration. You can
`require' or `load' the libraries of your choice that will be included in the
dump."
  )

(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."
  (spaceline-toggle-minor-modes-off)
  (spacemacs/set-leader-keys "p C-g" nil)
  (global-unset-key (kbd "C-z"))
  (spacemacs/toggle-evil-cleverparens-on)
  (add-hook 'smartparens-enabled-hook #'evil-cleverparens-mode)
  (define-key evil-motion-state-map (kbd "C-z") nil)
  (unless (display-graphic-p)
    (evil-terminal-cursor-changer-activate)
    (setq linum-format "%4d\u2502 "))
  ;(global-linum-mode)
  (when (display-graphic-p)
    (setq mac-command-key-is-meta t)
    (setq mac-command-modifier 'meta)
    (setq mac-option-key-is-meta nil)
    (setq mac-option-modifier 'super)
    (global-set-key (kbd "M-v") 'yank)

    (use-package cider
      :defer t
      :bind (:map cider-repl-mode-map
                  ("s-n" . cider-repl-next-input)
                  ("s-p" . cider-repl-previous-input))))

  (add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)
  (setq evil-move-cursor-back nil)
  (define-key evil-normal-state-map (kbd "M-.") nil)
  (define-key evil-normal-state-map (kbd "C-.") nil)
  (global-hl-line-mode -1)
  (add-to-load-path "~/.dotfiles/elisp/")
  (require 'osx-say)
  (spacemacs/set-leader-keys
    "oy" #'youdao-dictionary-search-at-point+
    "os" #'osx-say)
  ;; (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
  ;; (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
  (global-evil-matchit-mode 1)
  ;; (golden-ratio-mode 1)
  (defun init-cli ()
    (message "define keys for input-decode-map")
    (define-key input-decode-map "\e[1;5A" [C-up])
    (define-key input-decode-map "\e[1;5B" [C-down])
    (define-key input-decode-map "\e[1;5C" [C-right])
    (define-key input-decode-map "\e[1;5D" [C-left])
    (define-key input-decode-map "\e[1;5/" (kbd "C-/"))
    (define-key input-decode-map "\e[1;6A" [C-S-up])
    (define-key input-decode-map "\e[1;6B" [C-S-down])
    (define-key input-decode-map "\e[1;6C" [C-S-right])
    (define-key input-decode-map "\e[1;6D" [C-S-left])
    (define-key input-decode-map "\e[1;8A" [C-M-up])
    (define-key input-decode-map "\e[1;8B" [C-M-down])
    (define-key input-decode-map "\e[1;8C" [C-M-right])
    (define-key input-decode-map "\e[1;4C" [C-M-right])
    (define-key input-decode-map "\e[1;8D" [C-M-left])
    (define-key input-decode-map "\e[1;4D" [C-M-left])
    (define-key input-decode-map "\e[1;4/" (kbd "C-M-/"))
    (define-key input-decode-map "\e[1;9A" [M-up])
    (define-key input-decode-map "\e[1;3A" [M-up])
    (define-key input-decode-map "\e[1;9B" [M-down])
    (define-key input-decode-map "\e[1;3B" [M-down])
    (define-key input-decode-map "\e[1;9C" [M-right])
    (define-key input-decode-map "\e[1;9D" [M-left])
    (define-key input-decode-map "\e[1;10A" [S-M-up])
    (define-key input-decode-map "\e[1;10B" [S-M-down])
    (define-key input-decode-map "\e[1;10C" [S-M-right])
    (define-key input-decode-map "\e[1;10D" [S-M-left]))

  (unless (display-graphic-p) (init-cli))

  (advice-add #'terminal-init-xterm :before #'init-cli)

  ;;; smartparens & paredit
  (with-eval-after-load 'smartparens
    (message "binding for smartparens")
    (dolist (binding '(("C-<left>" . sp-backward-slurp-sexp)
                       ("C-<right>" . sp-backward-barf-sexp)
                       ("C-M-<left>" . sp-forward-barf-sexp)
                       ("C-," . sp-forward-barf-sexp)
                       ("C-M-<right>" . sp-forward-slurp-sexp)
                       ("C-." . sp-forward-slurp-sexp)
                       ("M-<up>" . sp-splice-sexp-killing-backward)
                       ("M-<down>" . sp-splice-sexp-killing-forward)
                       ("M-r" . sp-splice-sexp-killing-around)
                       ("s-r" . sp-splice-sexp-killing-around)
                       (";" . (lambda ()
                                (interactive)
                                (if (member major-mode '(clojure-mode
                                                         clojurescript-mode
                                                         emacs-lisp-mode))
                                    (sp-comment)
                                  (self-insert-command 1))))))
      (define-key smartparens-mode-map (kbd (car binding)) (cdr binding))))

  (with-eval-after-load 'paredit
    (message "binding for paredit")
    (dolist (binding '(("C-<left>" . paredit-backward-slurp-sexp)
                       ("C-<right>" . paredit-backward-barf-sexp)
                       ("C-M-<left>" . paredit-forward-barf-sexp)
                       ("C-M-<right>" . paredit-forward-slurp-sexp)
                       ("M-<up>" . paredit-splice-sexp-killing-backward)
                       ("M-<down>" . paredit-splice-sexp-killing-forward)))
      (define-key paredit-mode-map (kbd (car binding)) (cdr binding))))

  (advice-add #'paredit-mode
              :around
              (lambda (f &optional x)
                (let ((ret (funcall f x)))
                  (if ret
                      (smartparens-mode 0)
                    (smartparens-mode 1))
                  ret)))
  (smartparens-global-mode)

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (setq magit-push-always-verify nil)
  (setq delete-by-moving-to-trash nil)

  (setq cider-default-repl-command "clojure")
  (setq cider-clojure-cli-parameters "-J-client -J-ea -A:cider")
  (defun indent-cond (indent-point state)
    (goto-char (elt state 1))
    (let ((pos -1)
          (base-col (current-column)))
      (forward-char 1)
      ;; `forward-sexp' will error if indent-point is after
      ;; the last sexp in the current sexp.
      (condition-case nil
          (while (and (<= (point) indent-point)
                      (not (eobp)))
            (clojure-forward-logical-sexp 1)
            (cl-incf pos))
        ;; If indent-point is _after_ the last sexp in the
        ;; current sexp, we detect that by catching the
        ;; `scan-error'. In that case, we should return the
        ;; indentation as if there were an extra sexp at point.
        (scan-error (cl-incf pos)))
      (+ base-col (if (evenp pos) 4 2))))
  (with-eval-after-load 'clojure-mode
    (require 'smartparens-clojure)
    (set-face-italic 'clojure-keyword-face t)
    (define-clojure-indent
      (cond #'indent-cond)
      (or-join '(1 ((:defn)) nil))
      (not-join '(1 ((:defn)) nil))))

  (add-to-list 'auto-mode-alist '("\\.\\(ios\\|android\\).js\\'" . react-mode))

  (add-hook 'python-mode-hook
            (lambda ()
              (make-variable-buffer-local 'evil-snipe-aliases)
              (push '(?: "def .+:") evil-snipe-aliases)))

  (add-hook 'clojure-mode-hook
            (lambda ()
              (make-variable-buffer-local 'evil-snipe-aliases)
              (push '(?: "\(def[^ ]+") evil-snipe-aliases)))

  (add-hook 'q-mode-hook
            (lambda ()
              (sp-pair "`" nil :actions :rem)))
  (load "my-private")
  (global-set-key (kbd "M-s") #'evil-write)

  (defun evil-paste-after-from-0 ()
    (interactive)
    (let ((evil-this-register ?0))
      (call-interactively 'evil-paste-after)))

  (define-key evil-visual-state-map "p" 'evil-paste-after-from-0)
  (load "im-select")
  )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (names chinese-word-at-point powerline pcre2el org-plus-contrib markdown-mode magit-popup skewer-mode simple-httpd json-snatcher json-reformat js2-mode dash-functional parent-mode projectile request haml-mode gitignore-mode fringe-helper git-gutter+ git-gutter flyspell-correct pos-tip flycheck flx highlight magit git-commit with-editor transient iedit smartparens anzu evil goto-chg undo-tree web-completion-data company hydra inflections multiple-cursors paredit lv eval-sexp-fu cider sesman spinner queue pkg-info parseedn clojure-mode parseclj a epl inf-ruby bind-map bind-key yasnippet packed anaconda-mode pythonic f dash s pinyinlib helm avy helm-core async auto-complete popup q-mode lsp-julia lsp-mode ht julia-repl julia-mode youdao-dictionary yapfify yaml-mode ws-butler winum which-key web-mode web-beautify volatile-highlights visual-fill-column vi-tilde-fringe uuidgen use-package unfill toml-mode toc-org tagedit systemd sqlup-mode sql-indent spaceline smeargle slim-mode scss-mode sass-mode rvm ruby-tools ruby-test-mode rubocop rspec-mode robe reveal-in-osx-finder restart-emacs rbenv rake rainbow-delimiters pyvenv pytest pyenv-mode py-isort pug-mode popwin pip-requirements persp-mode pbcopy paradox pangu-spacing osx-trash osx-dictionary orgit org-bullets open-junk-file nginx-mode neotree mwim move-text mmm-mode minitest markdown-toc magit-gitflow macrostep lua-mode lorem-ipsum livid-mode live-py-mode linum-relative link-hint launchctl json-mode js2-refactor js-doc indent-guide hy-mode hungry-delete hl-todo highlight-parentheses highlight-numbers highlight-indentation helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-make helm-gitignore helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag google-translate golden-ratio gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ gh-md fuzzy flyspell-correct-helm flycheck-pos-tip flx-ido find-by-pinyin-dired fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-terminal-cursor-changer evil-surround evil-snipe evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-cleverparens evil-args evil-anzu emmet-mode elisp-slime-nav dumb-jump diminish diff-hl cython-mode company-web company-statistics company-anaconda column-enforce-mode coffee-mode clojure-snippets clj-refactor clean-aindent-mode cider-eval-sexp-fu chruby bundler auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile aggressive-indent adaptive-wrap ace-window ace-pinyin ace-link ace-jump-helm-line ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
