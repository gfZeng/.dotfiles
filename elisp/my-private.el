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
