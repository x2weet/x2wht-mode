;;; x2wht-mode.el --- x2w's html-mode.
;;;
;;; x2wht-mode.el
;;;
;;;     Author: Ryota Wada
;;;    Version: 0.0.1
;;;       Date: 2012-08-15T10:32:32+09:00.
;;; -------------------------------------------------------------------------
;;; 
;;; Commentary:
;;;   GNU Emacs附属のhtml-modeをHTML文書がユルく扱へる樣に變更した
;;;   メジャーモード。
;;;
;;; TODO:
;;;   (未完成。)
;;;   
;;; Code:

(defvar x2wht-mode-syntax-table
  (let ((st (make-syntax-table)))
    st)
  "")

(defvar x2wht-mode-map
  (let ((map (make-sparse-keymap)))
    map)
  "")

;;; 
;;; html-mode
;;;
;; utility macro.
(defmacro my-define-many-skeletons (&rest table)
  (let ((result '()))
    (while (not (null table))
      (let ((h (car table)))
        (setq result
              (cons `(defun ,(car h) ()
                       "(Generated by #<my-define-many-skeletons>."
                       (interactive)
                       (insert ,@(cdr h)))
                    result)))
      (setq table (cdr table)))
    (setq result (cons 'progn result))
    result))
;;
(add-hook
 'x2wht-mode-hook
 #'(lambda ()
     ;; 基本的な函數（タグ閉ぢ等）
     (define-key html-mode-map (kbd "C-c C-t") 'sgml-tag)
     (define-key html-mode-map (kbd "C-c C-v") 'sgml-validate)
     (define-key html-mode-map (kbd "C-l") 'sgml-close-tag)
     ;; 個人的によく使ふ要素（C-cを2囘打つた後、Ctrlと併せたアルファベット）
     (define-key html-mode-map (kbd "C-c C-c C-u") 'html-unordered-list)
     (define-key html-mode-map (kbd "C-c C-c C-o") 'html-ordered-list)
     (define-key html-mode-map (kbd "C-c C-c C-l") 'html-list-item)
     (define-key html-mode-map (kbd "C-c C-c C-b") 'html-blockquote)
     (define-key html-mode-map (kbd "C-c C-c C-p") 'html-paragraph)
     (define-key html-mode-map (kbd "C-c C-c C-q") 'html-q)
     (define-key html-mode-map (kbd "C-c C-c C-a") 'html-href-anchor)
     (define-key html-mode-map (kbd "C-c C-c C-i") 'html-linked-image)
     (define-key html-mode-map (kbd "C-c C-c C-c C-i") 'html-image)
     (define-key html-mode-map (kbd "C-c C-c C-e") 'html-em-tag)
     (define-key html-mode-map (kbd "C-c C-c C-s") 'html-strong-tag)
     ;; 定義リスト要素
     (define-key html-mode-map (kbd "C-c C-c C-d") 'html-dl)
     (define-key html-mode-map (kbd "C-c C-9") 'html-dt)
     (define-key html-mode-map (kbd "C-c C-0") 'html-dd)
     ;; heading
     (define-key html-mode-map (kbd "C-c C-1") 'html-headline-1)
     (define-key html-mode-map (kbd "C-c C-2") 'html-headline-2)
     (define-key html-mode-map (kbd "C-c C-3") 'html-headline-3)
     (define-key html-mode-map (kbd "C-c C-4") 'html-headline-4)
     (define-key html-mode-map (kbd "C-c C-5") 'html-headline-5)
     (define-key html-mode-map (kbd "C-c C-6") 'html-headline-6)
     ;; HTML文書の構造関係要素（C-cを2囘打つた後、單發のアルファベット）
     (define-key html-mode-map (kbd "C-c C-c m") 'html-meta)
     (define-key html-mode-map (kbd "C-c C-c l") 'html-link)
     (define-key html-mode-map (kbd "C-c C-c r") 'html-html-tag)
     (define-key html-mode-map (kbd "C-c C-c t") 'html-title-tag)
     (define-key html-mode-map (kbd "C-c C-c h") 'html-head-tag)
     (define-key html-mode-map (kbd "C-c C-c b") 'html-body-tag)
     ;; コンピュータ関係要素とpre要素
     (local-unset-key (kbd "C-c C-a"))
     (define-key html-mode-map (kbd "C-c C-a C-p") 'html-pre-tag)
     (define-key html-mode-map (kbd "C-c C-a C-c") 'html-code-tag)
     (define-key html-mode-map (kbd "C-c C-a C-k") 'html-kbd-tag)
     (define-key html-mode-map (kbd "C-c C-a C-s") 'html-samp-tag)
     ;; ins要素とdel要素
     (local-unset-key (kbd "C-c C-e"))
     (define-key html-mode-map (kbd "C-c C-e C-i") 'html-ins-start-tag)
     (define-key html-mode-map (kbd "C-c C-e C-d") 'html-del-start-tag)
     ;; div要素とspan要素
     (local-unset-key (kbd "C-c C-f"))
     (define-key html-mode-map (kbd "C-c C-f C-d") 'html-div-start-tag)
     (define-key html-mode-map (kbd "C-c C-f C-s") 'html-span-start-tag)
     
     ;; skeleton定義
     (define-skeleton html-href-anchor ""
       "href: "
       "<a href=\"" str "\">" _ )
     (define-skeleton html-image ""
       "src: "
       "<img src=\"" str "\" alt=\"\" />" _ )
     (define-skeleton html-linked-image ""
       "URI: "
       "<a href=\"" str "\"><img src=\"" str "\" alt=\" \" /></a>" _ )
     (define-skeleton html-meta ""
       "name: "
       "<meta name=\"" str "\" content=\"\" />" _ )
     (define-skeleton html-link ""
       "rel: "
       "<link rel=\"" str "\" href=\"\" />" _ )
     
     (my-define-many-skeletons
      ;; (html-image "<img src=\"\" alt=\"\" />" )
      ;;(html-q ("<q cite=\"" str "\">" ))
      (html-q "<q>" )
      ;;(html-href-anchor ("<a href=\"" str "\">" ))
      ;; (html-href-anchor "<a href=\"\">" )
      (html-headline-6 "<h6>" )
      (html-headline-5 "<h5>" )
      (html-headline-4 "<h4>" )
      (html-headline-3 "<h3>" )
      (html-headline-2 "<h2>" )
      (html-headline-1 "<h1>" )
      ;;(html-blockquote ("<blockquote cite=\"" str "\">" ))
      (html-blockquote "<blockquote>" )
      (html-paragraph "<p>" )
      (html-em-tag "<em>" )
      (html-strong-tag "<strong>" )
      (html-dd "<dd>" )
      (html-dt "<dt>" )
      (html-dl "<dl>" )
      (html-list-item "<li>")
      (html-ordered-list "<ol>")
      (html-unordered-list "<ul>")
      ;;(html-link ("<link rel=\"" str "\" href=\"\" />"))
      ;; (html-link "<link rel=\"\" href=\"\" />")
      ;;(html-meta ("<meta name=\"" str "\" content=\"\" />"))
      ;; (html-meta "<meta name=\"\" content=\"\" />")
      (html-doctype-xthml1.0-strict "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">")
      (html-doctype-html4.01-strict "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">") ; 暫定的 空要素がXML方式な爲
      (html-html-tag "<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"ja\" lang=\"ja\">")
      (html-body-tag "<body>")
      (html-head-tag "<head>")
      (html-title-tag "<title>")
      (html-pre-tag "<pre>")
      (html-code-tag "<code>")
      (html-kbd-tag "<kbd>")
      (html-samp-tag "<samp>")
      (html-ins-start-tag "<ins>")
      (html-del-start-tag "<del>")
      (html-div-start-tag "<div>")
      (html-span-start-tag "<span>")
      )))
;; html-mode-hook ends here.

(setq html-tag-face-alist '())
(setq html-quick-keys t)
(setq html-tag-alist
  '(("a")
    ("form" (\n _ \n )
     ("action" ("method" ("GET") ("POST"))))
    ("h1")
    ("h2")
    ("h3")
    ("h4")
    ("h5")
    ("h6")
    ("hr")
    ("img" t ("src") ("alt"))
    ("input")
    ("link")
    ("ol")
    ("p")
    ("acronym")
    ("address")
    ("blockquote" \n)
    ("body")
    ("br")
    ("caption")
    ("cite")
    ("code")
    ("dd")
    ("del")
    ("dfn")
    ("div")
    ("dl")
    ("dt")
    ("em")
    ("head" \n)
    ("html")
    ("ins")
    ("kbd")
    ("li")
    ("option" t ("value") ("label") ("selected" t))
    ("pre" \n)
    ("q")
    ("samp")
    ("span")
    ("strong")
    ("sub")
    ("sup")
    ("title")
    ("tr" t)
    ("var")))

;;;
;;; html-replace-chars-region
;;; 
;;;     cf.) http://xahlee.org/emacs/emacs_html.html
(defun html-replace-chars-region (start end)
  "Replace ``<'' to ``&lt;'' and other chars in HTML. This works on the current region."
  (interactive "r")
  (save-restriction
    (narrow-to-region start end)
    (goto-char (point-min))
    (while (search-forward "&" nil t) (replace-match "&amp;" nil t))
    (goto-char (point-min))
    (while (search-forward "<" nil t) (replace-match "&lt;" nil t))
    (goto-char (point-min))
    (while (search-forward ">" nil t) (replace-match "&gt;" nil t))
    (goto-char (point-min))
    (while (search-forward "\"" nil t) (replace-match "&quot;" nil t))))

;;;
;;; html-mode's font-lock-keywords
;;;
(defface my-html-heading-face
  '((t (:foreground "black" :background "salmon")))
  "The face used for HTML document's headings.")
(defvar my-html-heading-face 'my-html-heading-face)

;; (font-lock-add-keywords
;;  'html-mode
;;  `(("\\(<\\)[^!]"
;;     (1 font-lock-builtin-face))
;;    ("\\(<\\)!"
;;     (1 font-lock-keyword-face))
;;    ("<[^!][^<>]*\\(>\\)"
;;     (1 font-lock-builtin-face))
;;    ("<![^<>]*\\(>\\)"
;;     (1 font-lock-keyword-face))
;;    ("\\([0-9a-zA-Z\\-]+=\\)['\"]"
;;     (1 font-lock-builtin-face))
;;    ("<\\(/\\)"
;;     (1 font-lock-builtin-face))
;;    (" \\(/\\)>"
;;     (1 font-lock-builtin-face))
;;    ("<\\(!\\[CDATA\\[\\)"
;;     (1 font-lock-keyword-face))
;;    ("\\(\\]\\]\\)>"
;;     (1 font-lock-keyword-face))
;;    ("xml\\(:\\)"
;;     (1 font-lock-builtin-face))
;;    ("<!DOCTYPE\\s-+\\(\\sw+\\)"
;;     (1 my-white-face))
;;    ("<!DOCTYPE\\s-+\\sw+\\s-+\\(PUBLIC\\|SYSTEM\\)"
;;     (1 font-lock-keyword-face))
;;    ("&\\w+;"
;;     (0 font-lock-keyword-face))
;;    ("&#\\w+;"
;;     (0 font-lock-keyword-face))
;;    ("<h[1-6]>\\(.*\\)</h[1-6]>"
;;     (1 my-html-heading-face))
;;    ))

(defvar x2wht-font-lock-keywords
  `(;; ("<[^!][^<>]*\\(>\\)"
    ;;  (1 font-lock-builtin-face))
    ;; ("<![^<>]*\\(>\\)"
    ;;  (1 font-lock-keyword-face))
    ("\\sw+="
     (0 font-lock-builtin-face))
    ("<\\(\\?xml\\)\\>"
     (1 font-lock-keyword-face))
    ("<\\(!\\[CDATA\\[\\)"
     (1 font-lock-keyword-face))
    ("\\(\\]\\]\\)>"
     (1 font-lock-keyword-face))
    ("<!DOCTYPE\\s-+\\(\\sw+\\)"
     (1 my-white-face))
    ("<!DOCTYPE\\s-+\\sw+\\s-+\\(PUBLIC\\|SYSTEM\\)"
     (1 font-lock-keyword-face))
    ("<\\(!DOCTYPE\\)\\>"
     (1 font-lock-keyword-face))
    ("\\(<\\)!DOCTYPE\\>"
     (1 font-lock-keyword-face))
    ("<!DOCTYPE\\s-+\\(>\\)$"
     (2 font-lock-keyword-face))
    ("&\\w+;"
     (0 font-lock-keyword-face))
    ("&#\\w+;"
     (0 font-lock-keyword-face))
    ("\\(<\\)\\([a-zA-Z\\-]+\\)\\(>\\)"
     (1 font-lock-builtin-face)
     (2 font-lock-function-name-face)
     (3 font-lock-builtin-face))
    ("\\(</\\)\\([a-zA-Z\\-]+\\)\\(>\\)"
     (1 font-lock-builtin-face)
     (2 font-lock-function-name-face)
     (3 font-lock-builtin-face))
    )
  "")

;; (defvar asm-mode-abbrev-table nil
;;   "Abbrev table used while in Asm mode.")
;; (define-abbrev-table 'asm-mode-abbrev-table ())

;;;###autoload
(define-derived-mode x2wht-mode html-mode "X2WHT"
  ""
  ;; (setq local-abbrev-table asm-mode-abbrev-table)
  (set (make-local-variable 'font-lock-defaults) '(x2wht-font-lock-keywords))
  ;; Stay closer to the old TAB behavior (was tab-to-tab-stop).
  (set (make-local-variable 'tab-always-indent) nil)

  (run-hooks 'x2wht-mode-set-comment-hook)
  ;; Make our own local child of x2wht-mode-map
  ;; so we can define our own comment character.
  
  ;;(use-local-map (nconc (make-sparse-keymap) x2wht-mode-map))
  ;;(local-set-key (vector x2wht-comment-char) 'x2wht-comment)
  (set-syntax-table (make-syntax-table x2wht-mode-syntax-table))
  (modify-syntax-entry	x2wht-comment-char "< b")

  (set (make-local-variable 'comment-start) (string x2wht-comment-char))
  (set (make-local-variable 'comment-add) 1)
  (set (make-local-variable 'comment-start-skip)
       "\\(?:\\s<+\\|/[/*]+\\)[ \t]*")
  (set (make-local-variable 'comment-end-skip) "[ \t]*\\(\\s>\\|\\*+/\\)")
  (set (make-local-variable 'comment-end) "")
  (setq fill-prefix "\t"))

(provide 'x2wht-mode)

;;; x2wht-mode.el ends here
