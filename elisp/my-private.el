;;; -*- lexical-binding: t -*-

(with-eval-after-load 'semantic
  (add-hook 'semantic-mode-hook
            (lambda ()
              (dolist (x completion-at-point-functions)
                (when (string-prefix-p "semantic-" (symbol-name x))
                  (remove-hook 'completion-at-point-functions x))))))

(defun tmux-command (direction)
  (shell-command-to-string
   (concat "tmux list-panes -F '#F' |grep -q Z || tmux select-pane -"
           (tmux-direction direction))))

(unless (display-graphic-p)
  (xterm-mouse-mode -1)
  (global-set-key (kbd "<mouse-4>") 'scroll-down-line)
  (global-set-key (kbd "<mouse-5>") 'scroll-up-line))

(defun disable-ctrl-jk-for-history (mode-map)
  (evil-define-key 'insert mode-map
    (kbd "C-k") nil
    (kbd "C-j") nil)
  (evil-define-key 'normal mode-map
    (kbd "C-k") nil
    (kbd "C-j") nil))



(use-package markdown-mode
  :defer t
  :config
  (progn
    (require 'mmm-auto)
    (mmm-add-classes
     '((markdown-clojure
        :submode clojure-mode
        :front "^```clojure[\n\r]+"
        :back "^```$")))
    (mmm-add-mode-ext-class 'markdown-mode nil 'markdown-clojure)
    (defun my/display-as-markdown-mode (buffer alist)
      (interactive)
      (with-current-buffer buffer
        (mmm-mode)
        (markdown-mode)))
    ;; (add-to-list 'display-buffer-alist '("\\*cider-grimoire\\*" . (my/display-as-markdown-mode)))
    ))

(use-package cider
  :defer t
  :config
  (progn
    (defun cider-call-defun-in-repl (&optional arg)
      "Insert a call to the toplevel form defined around point into the REPL."
      (interactive "P")
      (let* ((string-list (split-string (cider-defun-at-point)))
             (define-name (car string-list))
             (defun-p (equal "(defn" define-name))
             (fn-name (cadr string-list))
             (form (if defun-p
                       (concat "(" fn-name " )")
                     (concat " " fn-name))))
        (cider-repl-set-ns (cider-current-ns))
        (cider-insert-in-repl form nil)
        (goto-char (+ cider-repl-input-start-mark
                      (if defun-p
                          (1- (length form))
                        0)))))

    (defun cider-send-defun-to-repl ()
      (local-set-key (kbd "C-c C-y") 'cider-call-defun-in-repl))

    (add-hook 'cider-mode-hook 'cider-send-defun-to-repl)))

(when (display-graphic-p)
  (define-globalized-minor-mode global-text-scale-mode
    text-scale-mode
    (lambda () (text-scale-mode 1)))

  (defun global-text-scale-adjust (inc)
    (interactive)
    (text-scale-set 1)
    (kill-local-variable 'text-scale-mode-amount)
    (setq-default text-scale-mode-amount (+ text-scale-mode-amount inc))
    (global-text-scale-mode 1))

  (global-set-key (kbd "s-0")
                  '(lambda () (interactive)
                     (global-text-scale-adjust (- text-scale-mode-amount))
                     (global-text-scale-mode -1)))
  (global-set-key (kbd "s-=")
                  '(lambda () (interactive) (global-text-scale-adjust 1)))
  (global-set-key (kbd "s--")
                  '(lambda () (interactive) (global-text-scale-adjust -1))))


(use-package tmux
  :defer t
  :config
  (advice-add #'tmux-command
              :around
              (lambda (f direction)
                (unless (display-graphic-p)
                  (funcall f direction)))))



(when (and (fboundp 'make-thread)
           (not (display-graphic-p)))
  (defmacro future (&rest body)
    `(make-thread
      (lambda ()
        ,@body)))

  (advice-add
   #'set-register
   :around
   (lambda (f register value)
     (future
      (with-temp-buffer
        (insert text)
        (with-demoted-errors "Error calling pbcopy: %S"
          (call-process-region (point-min) (point-max) "pbcopy"))))
     (funcall f register value))))

(use-package evil-cleverparens
  :defer t
  :config
  (progn
    (evil-define-key 'normal evil-cleverparens-mode-map (kbd "M-s") nil)
    (evil-define-key 'normal evil-cleverparens-mode-map (kbd "M-[") nil)
    (evil-define-key 'normal evil-cleverparens-mode-map (kbd "M-]") nil)
    (define-key smartparens-mode-map (kbd "M-s") nil)))

(use-package sqlup-mode
  :defer t
  :init
  (progn
    ;; Capitalize keywords in SQL mode
    (add-hook 'sql-mode-hook 'sqlup-mode)
    ;; Capitalize keywords in an interactive session (e.g. psql)
    (add-hook 'sql-interactive-mode-hook 'sqlup-mode)
    ;; Set a global keyword to use sqlup on a region
    ;; (global-set-key (kbd "C-c u") 'sqlup-capitalize-keywords-in-region)
    ))

(use-package sql-indent
  :defer t
  :init
  (add-hook 'sql-mode-hook 'sqlind-minor-mode))

(if (display-graphic-p)
    (when (custom-theme-p 'spacemacs-dark)
      (custom-theme-set-faces 'spacemacs-dark '(default ((t (:background "#300a24"))))))
  (load-theme 'spacemacs-dark t)
  (custom-theme-set-faces 'spacemacs-dark '(default ((t (:background nil))))))
