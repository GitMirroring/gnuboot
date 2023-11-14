;;; Copyright © 2015 David Thompson <davet@gnu.org>
;;; Copyright © 2016 Christopher Allan Webber <cwebber@dustycloud.org>
;;; Copyright © 2023 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
;;;
;;; This file is based on haunt/builder/blog.scm,
;;; haunt/reader/commonmark.scm and tests/post.scm and from Haunt
;;; 2.6.0.
;;;
;;; This file is free software; you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published
;;; by the Free Software Foundation; either version 3 of the License,
;;; or (at your option) any later version.
;;;
;;; Haunt is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;; General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with Haunt.  If not, see <http://www.gnu.org/licenses/>.

(define-module (website builders gnuboot)
  #:use-module (commonmark)
  #:use-module (haunt artifact)
  #:use-module (haunt builder assets)
  #:use-module (haunt html)
  #:use-module (haunt post)
  #:use-module (haunt site)
  #:use-module (haunt utils)
  #:use-module (ice-9 match)
  #:use-module (ice-9 rdelim)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-9)
  #:use-module (srfi srfi-19)
  #:export (gnuboot-website))

(define-record-type <theme>
  (make-theme name layout post-template collection-template)
  theme?
  (name theme-name)
  (layout theme-layout)
  (post-template theme-post-template)
  (collection-template theme-collection-template))

(define (untitled-layout site title body)
  `((doctype "html")
    (head
     (meta (@ (charset "utf-8")))
     (link (@ (rel "stylesheet") (href "/software/gnuboot/web/static/gnuboot.css")))
     (title ,(string-append title " — " (site-title site))))
    (body
     (header
      (ul
       (li (a (@ (href "/software/gnuboot/web/index.html"))
              "Home"))
       (li (a (@ (href "/software/gnuboot/web/faq.html"))
              "FAQ"))
       (li (a (@ (href "/software/gnuboot/web/download.html"))
              "Download"))
       (li (a (@ (href "/software/gnuboot/web/docs/install"))
              "Install"))
       (li (a (@ (href "/software/gnuboot/web/docs"))
              "Docs"))
       (li (a (@ (href "/software/gnuboot/web/news"))
              "News"))
       (li (a (@ (href "https://todo.sr.ht/~libreboot/Libreboot"))
              "Bugs"))
       (li (a (@ (href "/software/gnuboot/web/tasks"))
              "TODO"))
       (li (a (@ (href "/software/gnuboot/web/git.html"))
              "Send patch"))
       (li (a (@ (href "/software/gnuboot/web/contact.html"))
              "Contact"))
       (li (a (@ (href "https://ryf.fsf.org/categories/laptops"))
              "Buy preinstalled")))
      (hr))
     ,body
     (footer
      (hr)
      (ul
       (li (a (@ (href "/software/gnuboot/web/git.md"))
              "Edit this page"))
       (li (a (@ (href "/software/gnuboot/web/who.md"))
              "Who develops Libreboot?"))
       (li (a (@ (href "/software/gnuboot/web/license.md"))
              "License"))
       (li (a (@ (href "/software/gnuboot/web/template-license.md"))
              "Template"))
       (li (a (@ (href "/software/gnuboot/web/logo-license.md"))
              "Logo"))
       (li (a (@ (href "/software/gnuboot/web/contrib.md"))
              "Authors")))
      (hr)))))

(define (ugly-default-post-template post)
  `((h2 ,(post-ref post 'title))
    (div ,(post-sxml post))))

(define (ugly-default-collection-template site title posts prefix)
  (define (post-uri post)
    (string-append (or prefix "") "/"
                   (site-post-slug site post) ".html"))

  `((h3 ,title)
    (ul
     ,@(map (lambda (post)
              `(li
                (a (@ (href ,(post-uri post)))
                   ,(post-ref post 'title))))
            posts))))

(define* (theme #:key
                (name "GNU Boot")
                (layout untitled-layout)
                (post-template ugly-default-post-template)
                (collection-template ugly-default-collection-template))
  (make-theme name layout post-template collection-template))

(define (with-layout theme site title body)
  ((theme-layout theme) site title body))

(define (render-post theme site post)
  (let ((title (post-ref post 'title))
        (body ((theme-post-template theme) post)))
    (with-layout theme site title body)))

(define (render-collection theme site title posts prefix)
  (let ((body ((theme-collection-template theme) site title posts prefix)))
    (with-layout theme site title body)))

(define (date->string* date)
  "Convert DATE to human readable string."
  (date->string date "~a ~d ~B ~Y"))

(define ugly-theme
  (theme #:name "Ugly"
         #:layout untitled-layout
         #:post-template ugly-default-post-template
         #:collection-template ugly-default-collection-template))

(define* (gnuboot-website #:key (theme ugly-theme) prefix
               (collections
                `(("Pages:" "index.html" ,posts/reverse-chronological))))
  "Return a procedure that transforms a list of posts into pages
decorated by THEME, whose URLs start with PREFIX."
  (define (make-file-name base-name)
    (if prefix
	(string-append prefix "/" base-name)
        base-name))
  (define (remove-html-extension string)
    (string-append
     (string-join
      (drop-right ;; remove .html
       (string-split
	string #\.)
       1)
      ".")
     ".html"))

  (define (remove-pages-prefix string)
    (string-join (cdr (string-split string #\/)) "/"))

  (lambda (site posts)
    (define (post->page post)
      (let ((base-name
	     (remove-pages-prefix (remove-html-extension (post-file-name post)))))

	(pk (post-file-name post))
        (serialized-artifact (make-file-name base-name)
                             (render-post theme site post)
                             sxml->html)))

    (define collection->page
      (match-lambda
	((title file-name filter)
        (serialized-artifact (make-file-name file-name)
                             (render-collection theme site title (filter posts) prefix)
                             sxml->html))))

    (append (map post->page posts))))
