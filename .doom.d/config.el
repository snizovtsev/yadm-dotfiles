;;; ~/.doom.d/config.el -*- lexical-binding:overlay t; -*-

(setq-default user-full-name "Sergey Nizovtsev"
              user-mail-address "snizovtsev@gmail.com"
              scroll-margin 3
              mouse-wheel-scroll-amount '(5 ((shift) . 2))
              mouse-wheel-progressive-speed nil
              doom-font (font-spec :family "Hack" :size 15))

(add-hook! 'doom-init-ui-hook
  (defun configure-frame-h ()
    (modify-frame-parameters nil '((undecorated . t)
                                   (fullscreen . maximized)))
    ))

(setq projectile-project-search-path
      '("~/projects/"
        "~/opensource/"))

(map! :n "C-h" 'evil-window-left
      :n "C-l" 'evil-window-right
      :n "C-j" 'evil-window-down
      :n "C-k" 'evil-window-up

      (:map evil-treemacs-state-map
        "C-h" 'evil-window-left
        "C-l" 'evil-window-right)
      (:map (c-mode-map c++-mode-map)
        :n "M-h" (lambda! (ccls-navigate "L"))
        :n "M-j" (lambda! (ccls-navigate "D"))
        :n "M-k" (lambda! (ccls-navigate "U"))
        :n "M-l" (lambda! (ccls-navigate "R"))))

;; cc-mode
(add-to-list 'auto-mode-alist
             '("/BUILD\\'" . python-mode)
             '("/WORKSPACE\\'" . python-mode))

(after! lsp-ui
  (setq lsp-ui-sideline-delay 5
        lsp-ui-doc-max-width 70
        lsp-ui-doc-max-height 16
        lsp-document-highlight-delay 2.0))

(after! ccls
  (setq ccls-sem-highlight-method 'font-lock)
  (ccls-use-default-rainbow-sem-highlight))

(put 'ccls-initialization-options 'safe-local-variable 'listp)
(put 'projectile-enable-caching 'safe-local-variable 'booleanp)
(put 'projectile-project-compilation-dir 'safe-local-variable 'stringp)
(put 'compile-command 'safe-local-variable 'stringp)
(put 'run-command 'safe-local-variable 'stringp)
(put 'test-command 'safe-local-variable 'stringp)
(put 'indent-region-function 'safe-local-variable 'booleanp)
(put 'doom-modeline-buffer-file-name-style 'safe-local-variable 'atom)
(put 'lsp-file-watch-ignored 'safe-local-variable 'listp)
(put 'lsp-file-watch-threshold 'safe-local-variable 'integerp)
(put 'lsp-file-watch-threshold 'safe-local-variable 'integerp)
(put 'display-line-numbers 'safe-local-variable 'booleanp)

(use-package! meson-mode
  :init
  (add-hook! 'meson-mode-hook 'company-mode))

(use-package! vagrant-tramp)
