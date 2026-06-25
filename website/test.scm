(use-modules (srfi srfi-1))

(pk
 (reduce-right
  (lambda (new old)
    (string-append new old))
  ""
  '("5" "6" "7")))

(pk
 (reduce-right
  (lambda (new old)
    (string-append
     (if (string? new)
	 new
	 (string new))
     (if (string? old)
	 old
	 (string old))))
  ""
  (string->list "5678")))
