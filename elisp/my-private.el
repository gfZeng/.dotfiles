;;; -*- lexical-binding: t -*-

(with-eval-after-load 'semantic
  (add-hook 'semantic-mode-hook
            (lambda ()
              (dolist (x completion-at-point-functions)
                (when (string-prefix-p "semantic-" (symbol-name x))
                  (remove-hook 'completion-at-point-functions x))))))

(comment
 (with-eval-after-load 'projectile
   (add-hook 'after-save-hook
             (lambda ()
               (when (projectile-project-p)
                 (when (file-exists-p (concat (projectile-project-root) "TAGS"))
                   (async-start (projectile-regenerate-tags))))))))


(use-package helm-dash
  :defer t
  :config
  (defun helm-dash--candidate (docset row)
    "Return a list extracting info from DOCSET and ROW to build a helm candidate.
First element is the display message of the candidate, rest is used to build
candidate opts."
    (cons (format-spec "%d %n \t (%t \t %s)"
                       (list (cons ?d (car docset))
                             (cons ?n (cadr row))
                             (cons ?t (car row))
                             (cons ?s (-> (caddr row)
                                          (split-string "/")
                                          (car)))))
          (list (car docset) row))))

(unless (display-graphic-p)
  (xterm-mouse-mode -1)
  (global-set-key (kbd "<mouse-4>") 'scroll-down-line)
  (global-set-key (kbd "<mouse-5>") 'scroll-up-line))

(autoload 'inf-clojure-minor-mode "inf-clojure" "\
Major mode for editing Clojure Script code.

\\{inf-clojure-mode-map}

\(fn)" t nil)

(autoload 'inf-clojure "inf-clojure" "\
Start inf-clojure for clojurescript

\(fn)" t nil)

(add-hook 'clojurescript-mode-hook
          (lambda ()
            (when (file-exists-p (concat (projectile-project-root) "package.json"))
              (setq-local inf-clojure-program "lumo")
              (inf-clojure-minor-mode))))

(defun disable-ctrl-jk-for-history (mode-map)
  (evil-define-key 'insert mode-map
    (kbd "C-k") nil
    (kbd "C-j") nil)
  (evil-define-key 'normal mode-map
    (kbd "C-k") nil
    (kbd "C-j") nil))

(with-eval-after-load 'inf-clojure
  (add-hook 'inf-clojure-mode-hook
            (lambda ()
              (disable-ctrl-jk-for-history inf-clojure-mode-map))))

(with-eval-after-load 'python
  (add-hook 'inferior-python-mode-hook
            (lambda ()
              (disable-ctrl-jk-for-history inferior-python-mode-map))))

(with-eval-after-load 'geiser-repl
  (add-hook 'geiser-repl-mode-hook
            (lambda ()
              (disable-ctrl-jk-for-history 'geiser-repl-mode-map))))

(defun lumo-cljs ()
  (interactive)
  (inf-clojure "lumo"))

(defun lumo-cljs-connect (host port)
  (interactive (list (read-string "Host: " "127.0.0.1")
                     (read-string "Port: " "5555")))
  (inf-clojure (concat "telnet " host " " port)))


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


(use-package haskell
  :defer t
  :config
  (progn
    (defun haskell-indentation-advice ()
      (when (and (< 1 (line-number-at-pos))
                 (save-excursion
                   (forward-line -1)
                   (string= "" (s-trim (buffer-substring (line-beginning-position) (line-end-position))))))
        (delete-region (line-beginning-position) (point))))

    (advice-add 'haskell-indentation-newline-and-indent
                :after 'haskell-indentation-advice)))


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
