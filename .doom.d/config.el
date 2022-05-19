(setq user-full-name "Rafael Santos"
      user-mail-address "rafael.santos@electric.ai")

(setq confirm-kill-emacs nil)

(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-xcode t)

  (custom-set-faces!
    '(font-lock-comment-face :slant italic))) ; Show comments in italic
;; custom-set-faces must be used *after* the theme is loaded

(setq doom-font (font-spec :family "Comic Code" :style 'Regular :size 13)
      doom-variable-pitch-font (font-spec :family "Comic Code" :size 14)
      doom-big-font (font-spec :family "Comic Code" :size 24))
;; (setq doom-font (font-spec :family "JetBrainsMono Nerd Font Mono" :style 'Regular :size 13)
;;       doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 14)
;;       doom-big-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 24))

;; Give each line some room to breathe.
(setq-default line-spacing 0.3)

(setq display-line-numbers-type 'relative)
(map! :leader
      :desc "Truncate lines"
      "t t" #'toggle-truncate-lines)

(use-package lsp-mode
  :ensure t
  :config
  (use-package lsp-ui
    :ensure t
    :config
    (setq lsp-ui-doc-max-height 30
          lsp-ui-doc-max-width 150
          lsp-ui-doc-use-childframe t
          lsp-ui-doc-enable nil
          lsp-file-watch-ignored-directories '(".git" "node_modules" "venv" "build")))
  (use-package lsp-pylsp
    :ensure t
    :config
    (setq lsp-pylsp-plugins-pydocstyle-add-ignore ["D104" "D105" "D107" "D203" "D204" "D213" "D215" "D400" "D401" "D404" "D406" "D407" "D408" "D409" "D413" "D417"])))

(eval-after-load 'git-timemachine
  '(progn
     (evil-make-overriding-map git-timemachine-mode-map 'normal)
     ;; force update evil keymaps after git-timemachine-mode loaded
     (add-hook 'git-timemachine-mode-hook #'evil-normalize-keymaps)))

(use-package org-roam
  :ensure t
  :config
  (setq org-roam-capture-templates
        '(("d" "default" plain "%?"
           :target (file+head "%<%Y%m%d%H%M%S>.org" "#+title: ${title}")
           :unnarrowed t))))
