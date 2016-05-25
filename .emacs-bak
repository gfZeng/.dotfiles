(global-unset-key (kbd "M-a"))
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(global-set-key (kbd "TAB") 'self-insert-command)
;;; set to evil {
(add-to-list 'load-path "~/.emacs.d/evil")  ;only without ELPA/el-get
(require 'evil)
(evil-mode 1)
(global-linum-mode t)
;;; }

;;; set to evil-numbers {
(add-to-list 'load-path "~/.emacs.d/evil-numbers")  ;only without ELPA/el-get
(require 'evil-numbers)
;;; }


;(require 'tree-mode)
;(require 'windata)
;(require 'dirtree)
;;; {
(define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C-S-a") 'evil-numbers/dec-at-pt)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
;;;; }

;;; set to slime {
;(add-to-list 'load-path "~/.emacs.d/slime")
;(setq inferior-lisp-program "/usr/bin/sbcl")
;(require 'slime)
;(slime-setup)
;(setq slime-lisp-implementations
;      '((clj ("~/clojurescript/script/repl"))
;	(sbcl ("sbcl" "--noinform") :coding-system utf-8-unix)))
;;; }

;;; set to autopair {
(add-to-list 'load-path "~/.emacs.d/autopair")
(require 'autopair)
(autopair-global-mode)
;;;}

;;; set for c/c++ java {
(setq c-default-style "bsd" c-basic-offset 4)
;;;}

;;; font setting {
(set-default-font "Monaco-10")
;;;}

;;; lisp indent {
(setq show-paren-delay 0 show-paren-style 'parenthesis)
(show-paren-mode 1)
(add-to-list 'load-path "~/.emacs.d")
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook #'enable-paredit-mode)
(add-hook 'clojure-mode-hook #'enable-paredit-mode)

(add-hook 'scheme-mode-hook
	  '(lambda () (local-set-key (kbd "RET") 'newline-and-indent)))
(add-hook 'emacs-lisp-mode-hook
	  '(lambda () (local-set-key (kbd "RET") 'newline-and-indent)))
(add-hook 'lisp-mode-hook
	  '(lambda () (local-set-key (kbd "RET") 'newline-and-indent)))
(add-hook 'clojure-mode-hook
	  '(lambda () (local-set-key (kbd "RET") 'newline-and-indent)))
(add-hook 'python-mode-hook
	  '(lambda () (local-set-key (kbd "RET") 'newline-and-indent)))
(add-hook 'c-mode-hook
	  '(lambda () (local-set-key (kbd "RET") 'newline-and-indent)))
(add-hook 'c++-mode-hook
	  '(lambda () (local-set-key (kbd "RET") 'newline-and-indent)))
(add-hook 'js-mode-hook
	  '(lambda () (local-set-key (kbd "RET") 'newline-and-indent)))
;;; }

(global-unset-key (kbd "C-r"))

;;; auto-complete {
(add-to-list 'load-path "~/.emacs.d/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/ac-dict")
(ac-config-default)
(ac-set-trigger-key "M-a")
;;; }

;;; auto-complete-nxml {
(add-to-list 'load-path "~/.emacs.d/popup-el")
(add-to-list 'load-path "~/.emacs.d/auto-complete-nxml")
(require 'auto-complete-nxml)
(setq auto-complete-nxml-popup-help-key "C-:")
;;; }

;;; disable sroll bar {
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
;;; }
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 ;'(custom-enabled-themes (quote (manoj-dark)))
 '(custom-enabled-themes '(color-theme-emacs-nw))
 '(inhibit-startup-screen t)
 '(scroll-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;; {
;(add-to-list 'load-path "~/.emacs.d/clojure-mode")
;(add-to-list 'load-path "~/.emacs.d/swank-clojure")
;(require 'clojure-mode)
(add-hook 'nrepl-mode-hook
          (defun clojure-mode-slime-font-lock ()
            (require 'clojure-mode)
            (let (font-lock-mode)
              (clojure-mode-font-lock-setup))))
;(require 'clojure-test-mode)
;(eval-after-load 'slime '(setq slime-protocol-version 'ignore))
;(slime-setup '(slime-repl))
;;; }
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(add-to-list 'auto-mode-alist '("\.cljs$" . clojure-mode))

;; ido mode
(ido-mode t)
(setq ido-enable-flex-matching t) ; fuzzy matching is a must have
(setq ido-enable-last-directory-history nil) ; forget latest selected directory names

(require 'flx-ido)
(flx-ido-mode 1)
(setq ido-use-faces nil)
(setq flx-ido-threshhold 10000)
(setq make-backup-files nil)
(setq auto-save-default nil)
(global-auto-revert-mode t)

;; js2-mode
;;(require 'slime-js)
;;(autoload 'js2-mode "js2-mode" nil t)
;;(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;;(global-set-key [f5] 'slime-js-reload)
;;(add-hook 'js2-mode-hook
;;          (lambda ()
;;            (slime-js-minor-mode 1)))
;;(add-hook 'css-mode-hook
;;          (lambda ()
;;            (define-key css-mode-map "\M-\C-x" 'slime-js-refresh-css)
;;            (define-key css-mode-map "\C-c\C-r" 'slime-js-embed-css)))
;;
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

(setq python-shell-interpreter "/usr/bin/ipython2")

(setq ein:use-auto-complete t)
;; Or, to enable "superpack" (a little bit hacky improvements):
;; (setq ein:use-auto-complete-superpack t)

;;(add-to-list 'load-path "~/.emacs.d/python-mode.el-6.1.2")
;;(autoload 'python-mode "python-mode" "Python Mode." t)
;;(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;;(add-to-list 'interpreter-mode-alist '("python" . python-mode))
;;(setq
;; python-shell-interpreter "ipython"
;; python-shell-interpreter-args ""
;; python-shell-prompt-regexp "In \\[[0-9]+\\]: "
;; python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
;; python-shell-completion-setup-code
;;   "from IPython.core.completerlib import module_completion"
;; python-shell-completion-module-string-code
;;   "';'.join(module_completion('''%s'''))\n"
;; python-shell-completion-string-code
;;   "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")
(global-set-key (kbd "C-SPC") nil)
;;(setq show-paren-style 'expression)
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(auto-insert-mode)  ;;; Adds hook to find-files-hook
(setq auto-insert-directory "~/.templates/") ;;; Or use custom, *NOTE* Trailing slash important
(setq auto-insert-query nil) ;;; If you don't want to be prompted before insertion
;(define-auto-insert "\.py" "python/headers.py")
;(define-auto-insert "\.php" "my-php-template.php")

;(setq time-stamp-pattern "8/.*Updated Time:[ \t]+\\\\?[\"<]+%:y-%02m-%02d %02H:%02M:%02S\\\\?[\">]")
(setq time-stamp-pattern "8/Updated Time:[ \t]+\\\\?%:y-%02m-%02d %02H:%02M:%02S\\\\?$")
(add-hook 'before-save-hook 'time-stamp)
