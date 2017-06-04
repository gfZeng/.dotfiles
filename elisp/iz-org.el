(if (display-graphic-p)
    (setq org-bullets-bullet-list '("☰" "☷" "■" "◆" "▲" "▶" "◉" "○" "✸" "✿" "⋗" "⇀"))
  (load "emoj-org-bullets"))
(require 'ob-clojure)
(require 'ob-python)
(advice-add 'text-scale-adjust :after
            #'visual-fill-column-adjust)

(defun my-change-window-line-wrap ()
  (when (bound-and-true-p visual-line-mode)
    (let ((display-table (or
                          (window-display-table (selected-window))
                          buffer-display-table
                          standard-display-table)))
      (set-display-table-slot display-table 'wrap ?↩)
      (set-window-display-table (selected-window) display-table))))
;; (add-hook 'window-configuration-change-hook 'my-change-window-line-wrap)

(define-minor-mode writing-mode
  "for writing"
  :lighter "" :keymap nil
  (setq visual-fill-column-center-text t)
  (set-display-table-slot buffer-display-table 'wrap ?\s)
  (visual-fill-column-mode)
  (visual-line-mode 1)
  (toggle-word-wrap nil))

(add-hook 'after-save-hook
          (lambda ()
            (when (bound-and-true-p writing-mode)
                (writing-mode))))

;; http://stackoverflow.com/questions/20882935/how-to-move-between-visual-lines-and-move-past-newline-in-evil-mode
;; Make movement keys work like they should
(define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
;; Make horizontal movement cross lines
(setq-default evil-cross-lines t)


(setq org-agenda-files '("~/org/agenda/"))
(setq org-default-notes-file "~/org/agenda/refile.org")

;; I use C-c c to start capture mode
(global-set-key (kbd "C-c c") 'org-capture)

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates
      '(("t" "todo" entry (file "~/org/agenda/refile.org")
         "* TODO %?\n%U\n\t%a\n" :clock-in t :clock-resume t)
        ("r" "respond" entry (file "~/org/agenda/refile.org")
         "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
        ("n" "note" entry (file "~/org/agenda/refile.org")
         "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
        ("j" "Journal" entry (file+datetree "~/org/agenda/diary.org")
         "* %?\n%U\n" :clock-in t :clock-resume t)
        ("w" "org-protocol" entry (file "~/org/agenda/refile.org")
         "* TODO Review %c\n%U\n" :immediate-finish t)
        ("m" "Meeting" entry (file "~/org/agenda/refile.org")
         "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
        ("p" "Phone call" entry (file "~/org/agenda/refile.org")
         "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
        ("h" "Habit" entry (file "~/org/agenda/refile.org")
         "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n")))

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/agenda/gtd.org" "Workspace")
         "* TODO [#B] %?\n  %i\n"
         :empty-lines 1)
        ("n" "notes" entry (file+headline "~/org/agenda/notes.org" "Quick notes")
         "* %?\n  %i\n %U"
         :empty-lines 1)
        ("b" "Blog Ideas" entry (file+headline "~/org/agenda/notes.org" "Blog Ideas")
         "* TODO [#B] %?\n  %i\n %U"
         :empty-lines 1)
        ("s" "Code Snippet" entry
         (file "~/org/agenda/snippets.org")
         "* %?\t%^g\n#+BEGIN_SRC %^{language}\n\n#+END_SRC")
        ("w" "work" entry (file+headline "~/org/agenda/gtd.org" "Huobi")
         "* TODO [#A] %?\n  %i\n %U"
         :empty-lines 1)
        ("c" "Chrome" entry (file+headline "~/org/agenda/notes.org" "Quick notes")
         "* TODO [#C] %?\n %(zilongshanren/retrieve-chrome-current-tab-url)\n %i\n %U"
         :empty-lines 1)
        ("l" "links" entry (file+headline "~/org/agenda/notes.org" "Quick notes")
         "* TODO [#C] %?\n  %i\n %a \n %U"
         :empty-lines 1)
        ("j" "Journal Entry"
         entry (file+datetree "~/org/agenda/journal.org")
         "* %?"
         :empty-lines 1)))

;; Remove empty LOGBOOK drawers on clock out
(defun bh/remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at "LOGBOOK" (point))))
(add-hook 'org-clock-out-hook 'bh/remove-empty-drawer-on-clock-out 'append)

(use-package org-page
  ;; set for blog
  :defer t
  :config
  (progn
    (setq op/repository-directory "~/org/blog/")
    (setq op/theme-root-directory (concat op/repository-directory "themes/"))
    (setq op/site-domain "http://gfzeng.github.io/")
    (setq op/personal-disqus-shortname "isaac-zeng")
    (setq op/category-ignore-list '(".drafts" "themes"))
    (require 'blog-admin)
    (setq blog-admin-backend-type 'org-page)
    (setq blog-admin-backend-path op/repository-directory)
    (setq blog-admin-backend-new-post-in-drafts t)
    (setq blog-admin-backend-new-post-with-same-name-dir t)
    (setq blog-admin-backend-org-page-drafts ".drafts") ;; directory to save draft
    (add-hook 'blog-admin-backend-after-new-post-hook 'find-file)
    ;; (setq blog-admin-backend-org-page-config-file "/path/to/org-page/config.el") ;; if nil init.el is used
    ))

(autoload 'op/do-publication "org-page" "org page" t nil)
(autoload 'op/do-publication-and-preview-site "org-page" "org page" t nil)

(defun org->remarkup (str)
  (->> str
       (replace-regexp-in-string "=\\([^=\n]+\\)=" "`\\1`")
       (replace-regexp-in-string "^\\*\\*\\*\\*\\*\\* " "====== ")
       (replace-regexp-in-string "^\\*\\*\\*\\*\\* " "===== ")
       (replace-regexp-in-string "^\\*\\*\\*\\* " "==== ")
       (replace-regexp-in-string "^\\*\\*\\* " "=== ")
       (replace-regexp-in-string "^\\*\\* " "== ")
       (replace-regexp-in-string "^\\* " "= ")
       (replace-regexp-in-string "#\\+begin_quote\\|#\\+end_quote" "```")
       (replace-regexp-in-string "#\\+begin_src \\(\\w+\\).*" "```lang=\\1")
       (replace-regexp-in-string "#\\+end_src" "```")
       (replace-regexp-in-string "\\s-*|[-+]+|\\s-*$" "")
       (replace-regexp-in-string "\\[\\[\\(.*\\)\\]\\[\\(.*\\)\\]\\]" "[\\2](\\1)")))


(defun org-export-as-remarkup (&optional start end)
  (interactive "r")
  (let ((str (with-current-buffer (current-buffer)
               (if (use-region-p)
                   (buffer-substring start end)
                 (buffer-string))))
        (buffer (get-buffer-create "*Phabricator Remarkup*")))
    (with-current-buffer buffer
      (erase-buffer)
      (insert (org->remarkup str))
      (goto-char (point-min)))
    (switch-to-buffer-other-window buffer)))

(defun org-export-to-remarkup ()
  (interactive)
  (let* ((path (buffer-file-name))
         (fname (file-name-base path))
         (dir (file-name-directory path))
         (str (org->remarkup (buffer-string)))
         (target (concat dir fname ".md")))
    (with-temp-file target
      (insert str))
    (message "Writed %s" target)))
