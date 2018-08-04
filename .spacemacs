;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

;;; do not move to trash
(defun around-package-delete (f package &optional force nosave)
  (let ((delete-by-moving-to-trash nil))
    (message "~~~~~~~~~~~~~removing %s" package)
    (funcall f package force nosave)))

(advice-add #'package-delete
            :around
            #'around-package-delete)

(defmacro comment (&rest body))

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
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
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     helm
     (auto-completion :variables
                      auto-completion-return-key-behavior 'complete
                      auto-completion-tab-key-behavior 'cycle
                      auto-completion-enable-sort-by-usage t
                      auto-completion-complete-with-key-sequence nil
                      auto-completion-private-snippets-directory nil)
     (evil-snipe :variables evil-snipe-enable-alternate-f-and-t-behaviors t)
     osx
     better-defaults
     evil-cleverparens
     tmux
     emacs-lisp
     git
     github
     dash
     chrome
     markdown
     org
     (shell :variables
            shell-default-shell 'multi-term
            shell-default-height 30
            shell-default-position 'bottom)
     (spell-checking :variables
                     spell-checking-enable-by-default nil)
     syntax-checking
     version-control
     search-engine
     restclient
     (chinese :variables
              chinese-default-input-method nil
              chinese-enable-fcitx t
              chinese-enable-youdao-dict t)

     (clojure :variables clojure-enable-fancify-symbols t)
     (scheme  :variables
              geiser-chez-binary "chez"
              scheme-program-name "chez")
     (haskell :variables haskell-enable-hindent-style "johan-tibell")
     graphviz
     (python :variables
             python-shell-completion-native-enable nil
             python-fill-column 99)
     ruby
     react
     rust
     html
     yaml
     nginx
     docker
     lua
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(org-page
                                      blog-admin
                                      know-your-http-well
                                      visual-fill-column
                                      evil-terminal-cursor-changer
                                      systemd)
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '(pbcopy ac-ispell)
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style '(hybrid :variables
                                       hybrid-mode-enable-hjkl-bindings t)
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
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
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(solarized-dark)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font '("Ubuntu Mono" ;"Source Code Pro"
                               :size 16
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
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
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
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
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'source
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non nil line numbers are turned on in all `prog-mode' and `text-mode'
   ;; derivatives. If set to `relative', also turns on relative line numbers.
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
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
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init'.  You are free to put almost
any user code here.  The exception is org related code, which should be placed
in `dotspacemacs/user-config'."

  (add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
  (add-to-list 'configuration-layer--elpa-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
  (add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)
  (add-to-list 'package-pinned-packages '(clj-refactor . "melpa-stable") t)
  (add-to-list 'package-pinned-packages '(inflections . "melpa-stable") t)

  (advice-add
   #'spacemacs/load-theme :around
   (lambda (f theme &optional install)
     (if (display-graphic-p)
         (funcall f theme install)
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

   helm-dash-browser-func
   (lambda (url &rest args)
     (start-process (format "osascript -e 'open location \"%s\"'" url) nil
                    "osascript" "-e" (format "open location \"%s\"" url)))

   paradox-github-token "7933a31544bedc8960479ed06457f091276c568d"

   pyim-isearch-enable-pinyin-search nil

   cider-repl-history-file "~/.nrepl-history"

   js2-strict-trailing-comma-warning nil
   ns-pop-up-frames nil
   fcitx-active-evil-states '(insert emacs hybrid)
   projectile-enable-caching t
   line-spacing 0.03
   tags-add-tables nil
   tags-revert-without-query t)
  (with-eval-after-load 'web-mode
    (add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
    (add-to-list 'web-mode-indentation-params '("lineup-concats" . nil))
    (add-to-list 'web-mode-indentation-params '("lineup-calls" . nil)))
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration. You are free to put any user code."
  (spaceline-toggle-minor-modes-off)
  (spacemacs/set-leader-keys "p C-g" nil)
  (global-unset-key (kbd "C-z"))
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

  (when (display-graphic-p)
    (when (spacemacs/system-is-mac)
      (spacemacs//set-monospaced-font "Ubuntu Mono" "Hiragino Sans GB" 12 14)))

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
  (add-hook 'smartparens-enabled-hook #'evil-cleverparens-mode)
  (add-hook 'paredit-mode-hook #'evil-cleverparens-mode)
  (smartparens-global-mode)

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (setq magit-push-always-verify nil)

  (setq cider-default-repl-command "boot")
  (setq cider-boot-parameters "cider repl -s wait")
  (add-to-list 'magic-mode-alist '(".* boot" . clojure-mode))
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

  (add-hook 'dockerfile-mode-hook #'abbrev-mode)
  (use-package org
    :defer t
    :config (load "iz-org"))
  (use-package magit
    :defer t
    :config (load "magit-arcanist"))
  (load "my-private")
  (global-set-key (kbd "M-s") #'evil-write)

  (defun evil-paste-after-from-0 ()
    (interactive)
    (let ((evil-this-register ?0))
      (call-interactively 'evil-paste-after)))

  (define-key evil-visual-state-map "p" 'evil-paste-after-from-0)
  (evil-cp--enable-surround-operators)
  )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-want-Y-yank-to-eol nil)
 '(package-selected-packages
   (quote
    (powerline org-category-capture alert htmlize projectile flycheck json-mode diminish ghc inflections multiple-cursors paredit seq queue clojure-mode epl rust-mode ctable bind-key packed anaconda-mode pythonic f avy inf-ruby haskell-mode dash-functional tern company highlight iedit smartparens evil goto-chg undo-tree pinyinlib flyspell-correct magit magit-popup git-commit ghub let-alist with-editor gh marshal ht markdown-mode yasnippet skewer-mode js2-mode simple-httpd hydra helm helm-core async restclient haml-mode s names chinese-word-at-point org-mime solarized-theme cider systemd graphviz-dot-mode geiser git mustache org-plus-contrib youdao-dictionary yapfify yaml-mode xterm-color ws-butler winum which-key web-mode web-beautify volatile-highlights visual-fill-column vi-tilde-fringe uuidgen use-package unfill toml-mode toc-org tagedit spaceline smeargle slim-mode shell-pop scss-mode sass-mode rvm ruby-tools ruby-test-mode rubocop rspec-mode robe reveal-in-osx-finder restclient-helm restart-emacs rbenv rake rainbow-delimiters racer pyvenv pytest pyenv-mode py-isort pug-mode popwin pip-requirements persp-mode paradox pangu-spacing osx-trash osx-dictionary orgit org-projectile org-present org-pomodoro org-page org-download org-bullets open-junk-file ob-restclient ob-http nginx-mode neotree mwim multi-term move-text mmm-mode minitest markdown-toc magit-gitflow magit-gh-pulls macrostep lua-mode lorem-ipsum livid-mode live-py-mode linum-relative link-hint less-css-mode launchctl js2-refactor js-doc intero info+ indent-guide hy-mode hungry-delete hlint-refactor hl-todo hindent highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-make helm-hoogle helm-gitignore helm-flx helm-descbinds helm-dash helm-css-scss helm-company helm-c-yasnippet helm-ag haskell-snippets google-translate golden-ratio gnuplot gmail-message-mode github-search github-clone github-browse-file gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ gist gh-md fuzzy flyspell-correct-helm flymd flycheck-rust flycheck-pos-tip flycheck-haskell flx-ido find-by-pinyin-dired fill-column-indicator fcitx fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-terminal-cursor-changer evil-surround evil-snipe evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-cleverparens evil-args evil-anzu eshell-z eshell-prompt-extras esh-help engine-mode emmet-mode elisp-slime-nav edit-server dumb-jump dockerfile-mode docker diff-hl dash-at-point cython-mode company-web company-tern company-statistics company-restclient company-ghci company-ghc company-cabal company-anaconda column-enforce-mode coffee-mode cmm-mode clojure-snippets clj-refactor clean-aindent-mode cider-eval-sexp-fu chruby cargo bundler blog-admin auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile aggressive-indent adaptive-wrap ace-window ace-pinyin ace-link ace-jump-helm-line ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
