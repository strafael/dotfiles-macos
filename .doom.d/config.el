;; [[file:config.org::*Personal information][Personal information:1]]
(setq user-full-name "Rafael Santos"
      user-mail-address "rafael.santos@electric.ai")
(setq org-directory "~/org/")
;; Personal information:1 ends here

;; [[file:config.org::*Simple settings][Simple settings:1]]
(setq undo-limit 80000000               ; raise undo limit to 80Mb
      evil-want-fine-undo t             ; by default all changes in insert mode are one big blob
      auto-save-default t               ; auto save
      truncate-string-ellipsis "…"      ; unicode ellipsis
      scroll-margin 2)                  ; margin at the top and bottom of a window

(global-subword-mode 1)                 ; iterate throught CamelCase words
;; Simple settings:1 ends here

;; [[file:config.org::*Auto-customizations][Auto-customizations:1]]
(setq-default custom-file (expand-file-name ".custom.el" doom-private-dir))
(when (file-exists-p custom-file)
  (load custom-file))
;; Auto-customizations:1 ends here

;; [[file:config.org::*Windows][Windows:1]]
(setq evil-vsplit-window-right t
      evil-split-window-below t)
;; Windows:1 ends here

;; [[file:config.org::*Windows][Windows:2]]
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (consult-buffer))
;; Windows:2 ends here

;; [[file:config.org::*Font Face][Font Face:1]]
(setq doom-font (font-spec :family "Comic Code" :style 'Regular :size 13)
      doom-big-font (font-spec :family "Comic Code" :size 24)
      doom-variable-pitch-font (font-spec :family "Comic Code" :size 14)
      doom-unicode-font (font-spec :family "JuliaMono")
      doom-serif-font (font-spec :family "Comic Code"))
;; Font Face:1 ends here

;; [[file:config.org::*Theme and modeline][Theme and modeline:1]]
(setq doom-theme 'doom-dracula)
(custom-set-faces!
  '(font-lock-comment-face :slant italic))      ; show comments in italic
;; Theme and modeline:1 ends here

;; [[file:config.org::*Theme and modeline][Theme and modeline:2]]
(custom-set-faces!
  '(doom-modeline-buffer-modified :foreground "orange"))
;; Theme and modeline:2 ends here

;; [[file:config.org::*Miscellaneus][Miscellaneus:1]]
(setq display-line-numbers-type 'relative)
;; Miscellaneus:1 ends here

;; [[file:config.org::*Miscellaneus][Miscellaneus:2]]
(map! :leader
      :desc "Truncate lines"
      "t t" #'toggle-truncate-lines)
;; Miscellaneus:2 ends here

;; [[file:config.org::*Miscellaneus][Miscellaneus:3]]
(setq-default line-spacing 0.3)         ; Give each line some room to breathe.
;; Miscellaneus:3 ends here

;; [[file:config.org::*Which key][Which key:1]]
(setq which-key-idle-delay 0.5)         ; I need the help, I really do
;; Which key:1 ends here

;; [[file:config.org::*Evil][Evil:1]]
(after! evil
  (setq evil-move-cursor-back nil       ; don't move the block cursor back when exiting insert mode
        evil-kill-on-visual-paste nil)) ; don't save the replaced text in visual mode to the kill ring, making it the default for the next paste
;; Evil:1 ends here

;; [[file:config.org::*lsp][lsp:1]]
(use-package lsp-mode
  :config
  (use-package lsp-ui
    :config
    (setq lsp-ui-doc-max-height 30
          lsp-ui-doc-max-width 150
          lsp-ui-doc-use-childframe t
          lsp-ui-doc-enable nil
          lsp-file-watch-ignored-directories '(".git" "node_modules" "venv" "build"))))
;; lsp:1 ends here

;; [[file:config.org::*Company][Company:1]]
(after! company
  (setq company-idle-delay 0.5
        company-minimum-prefix-length 2)
  (setq company-show-numbers t))
  ;; (add-hook 'evil-normal-state-entry-hook #'company-abort)) ;; make aborting less annoying.
;; Company:1 ends here

;; [[file:config.org::*Company][Company:2]]
(setq-default history-length 1000)
(setq-default prescient-history-length 1000)
;; Company:2 ends here

;; [[file:config.org::*Projectile][Projectile:1]]
(setq projectile-ignored-projects '("~/" "/tmp" "~/.emacs.d/.local/straight/repos/"))
(defun projectile-ignored-project-function (filepath)
  "Return t if FILEPATH is within any of `projectile-ignored-projects'"
  (or (mapcar (lambda (p) (s-starts-with-p p filepath)) projectile-ignored-projects)))
;; Projectile:1 ends here

;; [[file:config.org::*Zen][Zen:1]]
(setq +zen-text-scale 0.8)
;; Zen:1 ends here

;; [[file:config.org::*Treemacs][Treemacs:1]]
(after! treemacs
  (defvar treemacs-file-ignore-extensions '()
    "File extension which `treemacs-ignore-filter' will ensure are ignored")
  (defvar treemacs-file-ignore-globs '()
    "Globs which will are transformed to `treemacs-file-ignore-regexps' which `treemacs-ignore-filter' will ensure are ignored")
  (defvar treemacs-file-ignore-regexps '()
    "RegExps to be tested to ignore files, generated from `treeemacs-file-ignore-globs'")
  (defun treemacs-file-ignore-generate-regexps ()
    "Generate `treemacs-file-ignore-regexps' from `treemacs-file-ignore-globs'"
    (setq treemacs-file-ignore-regexps (mapcar 'dired-glob-regexp treemacs-file-ignore-globs)))
  (if (equal treemacs-file-ignore-globs '()) nil (treemacs-file-ignore-generate-regexps))
  (defun treemacs-ignore-filter (file full-path)
    "Ignore files specified by `treemacs-file-ignore-extensions', and `treemacs-file-ignore-regexps'"
    (or (member (file-name-extension file) treemacs-file-ignore-extensions)
        (let ((ignore-file nil))
          (dolist (regexp treemacs-file-ignore-regexps ignore-file)
            (setq ignore-file (or ignore-file (if (string-match-p regexp full-path) t nil)))))))
  (add-to-list 'treemacs-ignored-file-predicates #'treemacs-ignore-filter))
;; Treemacs:1 ends here

;; [[file:config.org::*Treemacs][Treemacs:2]]
(setq treemacs-file-ignore-extensions
      '(;; LaTeX
        "aux"
        "ptc"
        "fdb_latexmk"
        "fls"
        "synctex.gz"
        "toc"
        ;; LaTeX - glossary
        "glg"
        "glo"
        "gls"
        "glsdefs"
        "ist"
        "acn"
        "acr"
        "alg"
        ;; LaTeX - pgfplots
        "mw"
        ;; LaTeX - pdfx
        "pdfa.xmpi"
        ))
(setq treemacs-file-ignore-globs
      '(;; LaTeX
        "*/_minted-*"
        ;; AucTeX
        "*/.auctex-auto"
        "*/_region_.log"
        "*/_region_.tex"))
;; Treemacs:2 ends here

;; [[file:config.org::*Git timemachine][Git timemachine:1]]
(eval-after-load 'git-timemachine
  '(progn
     (evil-make-overriding-map git-timemachine-mode-map 'normal)
     ;; force update evil keymaps after git-timemachine-mode loaded
     (add-hook 'git-timemachine-mode-hook #'evil-normalize-keymaps)))
;; Git timemachine:1 ends here
