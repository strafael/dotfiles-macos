(setq doom-theme 'doom-one)

(setq doom-font (font-spec :family "UbuntuMono Nerd Font Mono" :size 17 :style 'Regular)
      doom-big-font (font-spec :family "DejaVu Sans Mono" :size 24))

(setq-default line-spacing 4)

(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))

;; Show comments in italic
(custom-set-faces!
  '(font-lock-comment-face :slant italic))

(add-hook 'treemacs-mode-hook (lambda () (text-scale-decrease 1)))

(setq display-line-numbers-type 'relative)
(map! :leader
      :desc "Truncate lines"
      "t t" #'toggle-truncate-lines)

(after! org
  (require 'org-bullets)
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  (setq org-ellipsis " ▼ "
        org-superstar-headline-bullets-list '("◉" "●" "○" "◆" "●" "○" "◆")
        org-superstar-itembullet-alist '((?+ . ?➤) (?- . ?✦)) ; changes +/- symbols in item lists
        org-hide-emphasis-markers t
        calendar-week-start-day 1
        ))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(after! treemacs
  (setq treemacs-is-never-other-window t
        treemacs-follow-mode t
        treemacs-width 45))

(after! doom-themes
  (setq doom-themes-treemacs-enable-variable-pitch t))

(add-hook 'magit-mode-hook (lambda () (magit-delta-mode +1)))
