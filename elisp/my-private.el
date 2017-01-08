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
