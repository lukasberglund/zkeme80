(define math-asm
  `(;; Multiplies DE and BC
    ;; Outputs in DEHL
    (label mul-16-by-16)
    (ld hl 0)
    (ld a 16)
    (label mul-16-loop)
    (add hl hl)
    (rl e)
    (rl d)
    (jp nc no-mul-16)
    (add hl bc)
    (jp nc no-mul-16)
    (inc de)
    (label no-mul-16)
    (dec a)
    (jp nz mul-16-loop)
    (ret)


    (label div-8-by-8)
    (xor a)
    (sla d)
    (rla)
    (cp e)
    ,@(concat-map (lambda (x)
                    (let ((local (string->symbol (format #f "d88-local~a" x))))
                      `((jr c ,local)
                        (sub e)
                        (inc d)
                        (sla d)
                        (label ,local)
                        (rla)
                        (cp e))))
                  (iota 7))
    (jr c d88-local8)
    (sub e)
    (inc d)
    (label d88-local8)
    (ret)

    (label mul-8-by-8)
    (push de)
    (ld l 0)
    (ld d l)
    (sla h)
    (jr nc mul88-next-local)
    (ld l e)
    (label mul88-next-local)
    ,@(concat-map (lambda (x)
                    (let ((curr (string->symbol (format #f "mul88-iter~a" (1+ x)))))
                      `((add hl hl)
                        (jr nc ,curr)
                        (add hl de)
                        (label ,curr))))
                  (iota 7))

    (pop de)
    (ret)

    (label div-hl-by-c)
    (push bc)
    (xor a)
    (ld b 16)
    (label dhc-local)
    (add hl hl)
    (rla)
    (cp c)
    (jr c dhc-local2)
    (sub c)
    (inc l)
    (label dhc-local2)
    (djnz dhc-local)
    (pop bc)
    (ret)

    ))
