(defun hello () "Hello, world!")

(defun show_langs ()
  (nthcdr 2 (directory-files "~/.sdkman/candidates"))
  )

(defun show_versions (lang)
  (nthcdr 2 (directory-files (format "~/.sdkman/candidates/%s" lang)))
  )

(defun eshell/sdk (&rest args)
  (cond ((string-equal (downcase (nth 0 args)) 'langs) (show_langs))
    ((string-equal (downcase (nth 0 args)) 'ls) "List")
    ((string-equal (downcase (nth 0 args)) 'list) "List")
    ((string-equal (downcase (nth 0 args)) 'use) "Use")
    ((string-equal (downcase (nth 0 args)) 'current) (show_current (nth 1)))
    (t args))
  )
