(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;;; begin hack
(scroll-bar-mode -1)
(modify-syntax-entry ?- "w")
(modify-syntax-entry ?_ "w")
(global-linum-mode t)
(global-auto-revert-mode t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(global-set-key (kbd "TAB") 'self-insert-command)
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)
(setq auto-save-default nil)
(setq make-backup-files nil)
(global-unset-key (kbd "C-a"))
(global-unset-key (kbd "C-S-a"))
(define-key global-map (kbd "RET") 'newline-and-indent)
(require 'saveplace)
(setq-default save-place t)

(ido-mode 1)
(setq ido-enable-flex-matching t)
;(setq ido-enable-last-directory-history nil)

;;; abbreviation
(setq abbrev-file-name "~/.emacs.d/abbrev-defs")
(setq save-abbrevs nil)
(setq-default abbrev-mode t)
(when (file-exists-p abbrev-file-name)
    (quietly-read-abbrev-file))

(set-default-font "Monaco-10")
(show-paren-mode t)

(require 'mustache-mode)
(autopair-global-mode)
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(evil-leader/set-key
 "dt" 'project-explorer-open)

(evil-mode t)
(define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/dec-at-pt)
(define-key evil-normal-state-map (kbd "C-S-a") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
;(setq nrepl-hide-special-buffers t)
;(setq cider-repl-tab-command 'indent-for-tab-command)
;(setq cider-repl-pop-to-buffer-on-connect nil)
;(setq cider-popup-stacktraces nil)
;(setq cider-repl-popup-stacktraces t)
(setq cider-auto-select-error-buffer t)
(setq cider-repl-display-in-current-window t) ; C-c C-z
(setq cider-repl-print-length 100) ; the default is nil, no limit, can print infinite collection
(setq cider-prompt-save-file-on-load nil)
(setq cider-repl-use-clojure-font-lock t)
(setq cider-repl-wrap-history t)
(setq cider-repl-history-size 1000) ; the default is 500
(setq cider-repl-history-file "~/.cider.hist")

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-20140208.653/dict")
(ac-config-default)
(add-hook 'cider-repl-mode-hook 'subword-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)
;(add-hook 'cider-repl-mode-hook 'smartparens-strict-mode)
(add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
(add-hook 'clojure-mode-hook 'ac-nrepl-setup)
(add-hook 'cider-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'cider-repl-mode))
(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions '(auto-complete)))
(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'cider-repl-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'cider-mode-hook 'set-auto-complete-as-completion-at-point-function)

(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode) 

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
