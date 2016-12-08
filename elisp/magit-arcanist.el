(setq magit-commit-popup
      '(:variable magit-commit-arguments
                  :man-page "git-commit"
                  :switches ((?a "Stage all modified and deleted files"   "--all")
                             (?e "Allow empty commit"                     "--allow-empty")
                             (?v "Show diff of changes to be committed"   "--verbose")
                             (?n "Bypass git hooks"                       "--no-verify")
                             (?s "Add Signed-off-by line"                 "--signoff")
                             (?R "Claim authorship and reset author date" "--reset-author"))
                  :options  ((?A "Override the author"  "--author=")
                             (?S "Sign using gpg"       "--gpg-sign=" magit-read-gpg-secret-key)
                             (?C "Reuse commit message" "--reuse-message="))
                  :actions  ((?c "Commit"         magit-commit)
                             (?e "Extend"         magit-commit-extend)
                             (?f "Fixup"          magit-commit-fixup)
                             (?F "Instant Fixup"  magit-commit-instant-fixup) nil
                             (?w "Reword"         magit-commit-reword)
                             (?s "Squash"         magit-commit-squash)
                             (?S "Instant Squash" magit-commit-instant-squash) nil
                             (?a "Amend"          magit-commit-amend)
                             (?A "Augment"        magit-commit-augment)
                             (?p "Arcanist"       magit-commit-arcanist))
                  :max-action-columns 4
                  :default-action magit-commit))

(defun magit-commit-arcanist (&optional args)
  "Create a new commit on HEAD.
With a prefix argument amend to the commit at HEAD instead.
\n(git commit [--amend] ARGS)"
  (interactive (if current-prefix-arg
                   (list (cons "--amend" (magit-commit-arguments)))
                 (list (magit-commit-arguments))))
  (lexical-let ((new-revision? (string=
                                ""
                                (shell-command-to-string
                                 "git log --grep \"Test Plan:\" origin/master..HEAD"))))
    (set-process-sentinel
     (when (setq args (magit-commit-assert args))
       (if new-revision?
           (magit-run-git-with-editor "commit" "--template" (expand-file-name "~/.arcanist.editmsg") args)
         (magit-run-git-with-editor "commit" args)))
     (lambda (p e)
       (magit-refresh)
       (when (string= "finished" (s-trim e))
         (if new-revision?
             (start-process "arcanist" "*Arcanist*" "arc" "diff" "--use-commit-message"
                            (s-trim
                             (shell-command-to-string "git rev-parse HEAD")))))))))
