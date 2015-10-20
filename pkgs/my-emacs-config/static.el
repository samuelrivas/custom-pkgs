;; My configuration that doesn't depend on any variable
;; This file is loaded by emacs.el, which is generated by default.nix

;; Enable the solarised theme, with dark background
(setq frame-background-mode 'dark)
(load-theme 'solarized t)
(enable-theme 'solarized)

;; Minor modes
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(column-number-mode t)
(global-font-lock-mode t)
(transient-mark-mode t)
(delete-selection-mode t)
(show-paren-mode t)
(blink-cursor-mode -1)
(auto-fill-mode t)

;; Key bindings
(global-set-key "\C-c\C-c" 'comment-region)
(global-set-key "\C-c\C-u" 'uncomment-region)
(global-set-key "\M-g" 'goto-line)

;; Global variables
(setq-default fill-column 80)
(setq inhibit-splash-screen t)
(setq-default indent-tabs-mode nil)

;; Whitespace mode
(global-whitespace-mode t)
(setq whitespace-line-column 80)
(setq whitespace-style '(face trailing empty tabs lines-tail))

; Erlang mode
(defun my-erlang-mode-hook ()
  "Erlang mode hook"
  (setq indent-tabs-mode nil)
  (auto-fill-mode)
  (flyspell-prog-mode)
  (ispell-change-dictionary "british"))

(add-hook 'erlang-mode-hook 'my-erlang-mode-hook)

;; LaTeX mode
(defun my-latex-mode-hook ()
  "LaTeX mode hook"
  (local-set-key "\C-c\C-c" 'comment-region)
  (local-set-key "\C-c\C-u" 'uncomment-region)
  (flyspell-mode t)
  (ispell-change-dictionary "british")
  (auto-fill-mode t))

(add-hook 'LaTeX-mode-hook 'my-latex-mode-hook)

;; C mode
(defun my-c-mode-hook ()
  (flyspell-prog-mode)
  (auto-fill-mode)
  (setq indent-tabs-mode nil)
  (setq comment-start "//")
  (setq comment-end "")
  (local-set-key "\C-c\C-u" 'uncomment-region))

(add-hook 'c-mode-hook 'my-c-mode-hook)

;; Javascript mode
(defun my-javascript-mode-hook ()
  (flyspell-prog-mode)
  (auto-fill-mode)
  (setq indent-tabs-mode nil)
  (local-set-key "\C-c\C-c" 'comment-region)
  (local-set-key "\C-c\C-u" 'uncomment-region))

(add-hook 'js-mode-hook 'my-javascript-mode-hook)

;; Text mode
(defun my-text-mode-hook ()
  (ispell-change-dictionary "british")
  (auto-fill-mode t)
  (flyspell-mode t))

(add-hook 'text-mode-hook 'my-text-mode-hook)

;; Haskell
(custom-set-variables
  '(haskell-process-suggest-remove-import-lines t)
  '(haskell-process-auto-import-loaded-modules t)
  '(haskell-process-log t))

(define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
(define-key haskell-mode-map (kbd "C-`") 'haskell-interactive-bring)
(define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
(define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
(define-key haskell-mode-map (kbd "C-c C-c") 'comment-region)
(define-key haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
(define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)
(define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)

(add-hook 'haskell-mode-hook 'my-haskell-mode-hook)

(defun my-haskell-mode-hook ()
  (turn-on-haskell-indentation)
  (flycheck-mode)
)

;; Ocaml
;;(setq opam-share (substring (shell-command-to-string "opam config var share") 0 -1))
;;(add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))

(setq auto-mode-alist
      (append '(("\\.ml[i]?$" . tuareg-mode)
                ("\\.topml$" . tuareg-mode))
              auto-mode-alist))

(autoload 'utop-setup-ocaml-buffer "utop" "Toplevel for OCaml" t)
(add-hook 'tuareg-mode-hook 'utop-setup-ocaml-buffer)

(add-hook 'tuareg-mode-hook 'merlin-mode)
(add-hook 'tuareg-mode-hook 'flyspell-prog-mode)

(setq merlin-use-auto-complete-mode t)

(define-key merlin-mode-map
    (kbd "C-c C-n") 'merlin-error-next)
(define-key merlin-mode-map
    (kbd "C-c <up>") 'merlin-type-enclosing-go-up)
(define-key merlin-mode-map
    (kbd "C-c <down>") 'merlin-type-enclosing-go-down)

;; ORG
(setq org-catch-invisible-edits 'error)