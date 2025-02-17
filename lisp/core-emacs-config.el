;;; core-emacs-config.el --- Summary:

;;; Commentary:
;;; Configuration of core emacs variables, hooks and so on

(use-package
  emacs
  :ensure nil
  :hook (after-init . (lambda () (setq gc-cons-threshold (* 2 1000 1000))))
  :custom

  ;; Set custom file early
  (custom-file (expand-file-name "lisp/.custom.el" user-emacs-directory))

  ;; Introduction
  (user-full-name "Rubén Salinas")

  ;; Tune system limits
  (gc-cons-threshold (* 20 1024 1024))
  (read-process-output-max (* 1024 1024))

  (load-prefer-newer t)
  (bidi-paragraph-direction 'left-to-right)
  (initial-scratch-message "#+title: Scratch buffer\n\n")
  (initial-major-mode 'org-mode)
  
  ;; store all backup and autosave files in the tmp dir
  (backup-directory-alist `((".*" . ,temporary-file-directory)))
  (auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))
  (create-lockfiles nil)
  (fill-column 100)
  (inhibit-startup-screen t)

  (line-spacing 0.1)

  (indent-tabs-mode nil)
  (infer-indentation-style)
  (lisp-indent-function nil)
  (lisp-indent-offset 2)
  (use-short-answers t)
  ;; Should use:
  ;; (mapc #'treesit-install-language-grammar (mapcar #'car treesit-language-source-alist))
  ;; At least once per installation or while changing this list
  (treesit-language-source-alist
    '((bash "https://github.com/tree-sitter/tree-sitter-bash")
       (cmake "https://github.com/uyha/tree-sitter-cmake")
       (css "https://github.com/tree-sitter/tree-sitter-css")
       (elisp "https://github.com/Wilfred/tree-sitter-elisp")
       (heex "https://github.com/phoenixframework/tree-sitter-heex")
       (elixir "https://github.com/elixir-lang/tree-sitter-elixir")
       (go "https://github.com/tree-sitter/tree-sitter-go")
       (html "https://github.com/tree-sitter/tree-sitter-html")
       (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
       (json "https://github.com/tree-sitter/tree-sitter-json")
       (make "https://github.com/alemuller/tree-sitter-make")
       (markdown "https://github.com/ikatyang/tree-sitter-markdown")
       (python "https://github.com/tree-sitter/tree-sitter-python")
       (toml "https://github.com/tree-sitter/tree-sitter-toml")
       (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
       (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
       (yaml "https://github.com/ikatyang/tree-sitter-yaml")
       (java "https://github.com/tree-sitter/tree-sitter-java")))

  (major-mode-remap-alist
    '((yaml-mode . yaml-ts-mode)
       (bash-mode . bash-ts-mode)
       (js2-mode . js-ts-mode)
       (typescript-mode . typescript-ts-mode)
       (json-mode . json-ts-mode)
       (css-mode . css-ts-mode)
       (python-mode . python-ts-mode)
       (elixir-mode . elixir-ts-mode)
       (java-mode . java-ts-mode)))

  (org-directory "/Users/ruben.salinas/Documents/Notes")
  (org-archive-location "/Users/ruben.salinas/Documents/Notes/inbox.org")

  :init
  (load custom-file 'noerror)
  (setq-default bidi-paragraph-direction 'left-to-right)
  (prefer-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (global-hl-line-mode +1)
  (setq-default indent-tabs-mode nil)
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))

  ;; Fonts
  (set-face-attribute 'default nil :font "Fira Code" :height 170 :weight 'light)
  (set-face-attribute 'fixed-pitch nil :font "Fira Code" :height 170 :weight 'light)

  :config
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (global-display-line-numbers-mode)
  (column-number-mode t)
  (size-indication-mode t)
  (delete-selection-mode 1)
  (fset 'display-startup-echo-area-message #'ignore)

  (defun vn/customize-frame ()
    ;; Ensure cursor has the same color when run on daemon or not
    (set-cursor-color "DeepSkyBlue"))

  (if (daemonp)
    (add-hook 'server-after-make-frame-hook #'vn/customize-frame)
    (vn/customize-frame))

  (unbind-key "C-z")
  (global-prettify-symbols-mode)

  (load-file (expand-file-name "lisp/vn.el" user-emacs-directory))

  :bind
  ;; C-x C-0 restores the default font size
  (("C-+" . text-scale-increase)
    ("C--" . text-scale-decrease)
    ("<f5>" . treemacs)
    ("<f6>" . flymake-show-buffer-diagnostics)
    ("<f7>" . vterm)
    ("C-o" . other-window)
    ("s-b" . switch-to-buffer)
    ("C-q" . kill-buffer)))

(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
;;; core-emacs-config.el ends here
