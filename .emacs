(global-unset-key (kbd "M-a"))
(setq indent-tabs-mode nil)
(setq tab-width 4)
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

;;; {
(define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C-S-a") 'evil-numbers/dec-at-pt)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
;;;; }

;;; set to slime {
(setq inferior-lisp-program "/usr/bin/sbcl")
(add-to-list 'load-path "~/.emacs.d/slime")
(require 'slime)
(slime-setup)
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
(set-default-font "Monaco-11")
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
 '(custom-enabled-themes (quote (manoj-dark)))
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
(package-initialize)

(add-to-list 'auto-mode-alist '("\.cljs$" . clojure-mode))
