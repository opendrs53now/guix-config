;;; init.el --- Polaris init - Guix 22.5 + gruber-darker + λ -*- lexical-binding: t; -*-
;; 2026-10-02 - v4 FINAL for Emacs 31.1 - Gen 42/43 dark - BAK 20261002-1217

(require 'package)
(require 'dired-x)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(setq gc-cons-threshold (* 16 1024 1024))
(setq inhibit-startup-screen t)
(show-paren-mode 1)

;; --- The Perfect Setup (Guix Manual 22.5) - SAFE ---
(when (require 'geiser nil t)
  (setq geiser-active-implementations '(guile))
  (setq geiser-guile-binary "guile")
  (setq geiser-repl-history-filename "~/.cache/geiser-history")
  (when (boundp 'geiser-guile-load-path)
    (add-to-list 'geiser-guile-load-path "~/dotfiles")
    (add-to-list 'geiser-guile-load-path "~/dotfiles/my-packages")))

(setq dired-listing-switches "-alh --group-directories-first")
(setq dired-dwim-target t)
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)
(put 'dired-find-alternate-file 'disabled nil)

(setq-default c-basic-offset 4 indent-tabs-mode nil)
(add-hook 'c-mode-hook (lambda () (c-set-style "linux")))
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(when (require 'projectile nil t)
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq company-minimum-prefix-length 1)
(setq printer-name "Brother_HL-2800DW")   

(custom-set-variables
 '(custom-enabled-themes '(gruber-darker))
 '(custom-safe-themes
   '("e13beeb34b932f309fb2c360a04a460821ca99fe58f69e65557d6c1b10ba18c7" default))
 '(package-selected-packages '(projectile gruber-darker-theme company paredit)))

;; --- gruber-darker - Guix first, MELPA fallback - NO LOGOUT NEEDED ---
(when (require 'gruber-darker-theme nil t)
  (load-theme 'gruber-darker t t)
  (enable-theme 'gruber-darker))

(unless (custom-theme-enabled-p 'gruber-darker)
  (when (package-installed-p 'gruber-darker-theme)
    (load-theme 'gruber-darker t t)
    (enable-theme 'gruber-darker)))

;; --- Polaris λ - KEEP AT BOTTOM - leave until authorized removal ---
(global-set-key (kbd "<menu>") (lambda () (interactive) (insert "λ")))
(global-set-key (kbd "C-c l") (lambda () (interactive) (insert "λ")))
(setq frame-title-format '("Polaris λ"))
