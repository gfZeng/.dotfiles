;;; begin hack
(global-linum-mode t)
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

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
(set-default-font "Monaco-10")
(show-paren-mode t)

(evil-mode t)
(define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/dec-at-pt)
(define-key evil-normal-state-map (kbd "C-S-a") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

(add-hook 'cider-mode-hook 'cider-turn-eldoc-mode)
;(setq nrepl-hide-special-buffers t)
;(setq cider-repl-tab-command 'indent-for-tab-command)
;(setq cider-repl-pop-to-buffer-on-connection nil)
;(setq cider-popup-stacktraces nil)
(setq cider-repl-pop-stacktraces t)
(setq cider-auto-select-error-buffer t)
(setq cider-repl-display-in-current-window t) ; C-c C-z
(setq cider-repl-print-length 100) ; can print infinite collection
(setq cider-prompt-save-file-on-load nil)
(setq cider-repl-use-clojure-font-lock t)
(setq cider-repl-wrap-history t)
(setq cider-repl-history-size 1000)
(setq cider-repl-history-file "~/.cider.hist")

(add-hook 'cider-repl-mode-hook 'subword-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'smartparens-strict-mode)
(add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
(add-hook 'clojure-mode-hook 'ac-nrepl-setup)
(add-hook 'cider-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'cider-repl-mode))
(require 'auto-complete-config)
(ac-config-default)

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
