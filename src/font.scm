                                        ; .db width (in pixels)
                                        ; .db #b00000000
                                        ; .db #b00000000
                                        ; .db #b00000000
                                        ; .db #b00000000
                                        ; .db #b00000000

(define font-asm
  '((label kernel-font)
                                        ; [space]
    (db (4))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))

                                        ; !
    (db (4))
    (db (#b01000000))
    (db (#b01000000))
    (db (#b01000000))
    (db (#b00000000))
    (db (#b01000000))

                                        ; "
    (db (4))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))

                                        ; #
    (db (4))
    (db (#b10100000))
    (db (#b11100000))
    (db (#b01000000))
    (db (#b11100000))
    (db (#b10100000))

                                        ; $
    (db (4))
    (db (#b01100000))
    (db (#b11000000))
    (db (#b01100000))
    (db (#b11000000))
    (db (#b01000000))

                                        ; %
    (db (4))
    (db (#b10000000))
    (db (#b00100000))
    (db (#b01000000))
    (db (#b10000000))
    (db (#b00100000))

                                        ; &
    (db (4))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b01100000))

                                        ; '
    (db (4))
    (db (#b01000000))
    (db (#b01000000))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))

                                        ; (
    (db (4))
    (db (#b00100000))
    (db (#b01000000))
    (db (#b01000000))
    (db (#b01000000))
    (db (#b00100000))

                                        ; )
    (db (4))
    (db (#b10000000))
    (db (#b01000000))
    (db (#b01000000))
    (db (#b01000000))
    (db (#b10000000))

                                        ; *
    (db (4))
    (db (#b01000000))
    (db (#b11100000))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b00000000))

                                        ; +
    (db (4))
    (db (#b00000000))
    (db (#b01000000))
    (db (#b11100000))
    (db (#b01000000))
    (db (#b00000000))

                                        ; ,
    (db (4))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b01000000))
    (db (#b10000000))

                                        ; -
    (db (4))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b11100000))
    (db (#b00000000))
    (db (#b00000000))

                                        ; .
    (db (4))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b01000000))

                                        ; /
    (db (4))
    (db (#b00100000))
    (db (#b00100000))
    (db (#b01000000))
    (db (#b10000000))
    (db (#b10000000))

                                        ; 0
    (db (4))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b01000000))

                                        ; 1
    (db (4))
    (db (#b01000000))
    (db (#b11000000))
    (db (#b01000000))
    (db (#b01000000))
    (db (#b11100000))

                                        ; 2
    (db (4))
    (db (#b11000000))
    (db (#b00100000))
    (db (#b01000000))
    (db (#b10000000))
    (db (#b11100000))

                                        ; 3
    (db (4))
    (db (#b11000000))
    (db (#b00100000))
    (db (#b01000000))
    (db (#b00100000))
    (db (#b11000000))

                                        ; 4
    (db (4))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b11100000))
    (db (#b00100000))
    (db (#b00100000))

                                        ; 5
    (db (4))
    (db (#b11100000))
    (db (#b10000000))
    (db (#b11000000))
    (db (#b00100000))
    (db (#b11000000))

                                        ; 6
    (db (4))
    (db (#b01100000))
    (db (#b10000000))
    (db (#b11100000))
    (db (#b10100000))
    (db (#b11100000))

                                        ; 7
    (db (4))
    (db (#b11100000))
    (db (#b00100000))
    (db (#b01000000))
    (db (#b10000000))
    (db (#b10000000))

                                        ; 8
    (db (4))
    (db (#b11100000))
    (db (#b10100000))
    (db (#b11100000))
    (db (#b10100000))
    (db (#b11100000))

                                        ; 9
    (db (4))
    (db (#b11100000))
    (db (#b10100000))
    (db (#b11100000))
    (db (#b00100000))
    (db (#b11000000))

                                        ; :
    (db (4))
    (db (#b00000000))
    (db (#b01000000))
    (db (#b00000000))
    (db (#b01000000))
    (db (#b00000000))

                                        ; ;
    (db (4))
    (db (#b00000000))
    (db (#b01000000))
    (db (#b00000000))
    (db (#b01000000))
    (db (#b10000000))

                                        ; <
    (db (4))
    (db (#b00100000))
    (db (#b01000000))
    (db (#b10000000))
    (db (#b01000000))
    (db (#b00100000))

                                        ; =
    (db (4))
    (db (#b00000000))
    (db (#b11100000))
    (db (#b00000000))
    (db (#b11100000))
    (db (#b00000000))

                                        ; >
    (db (4))
    (db (#b10000000))
    (db (#b01000000))
    (db (#b00100000))
    (db (#b01000000))
    (db (#b10000000))

                                        ; ?
    (db (4))
    (db (#b11000000))
    (db (#b00100000))
    (db (#b01000000))
    (db (#b00000000))
    (db (#b01000000))

                                        ; @
    (db (4))
    (db (#b01000000))
    (db (#b11100000))
    (db (#b11100000))
    (db (#b10000000))
    (db (#b01100000))

                                        ; A
    (db (4))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b11100000))
    (db (#b10100000))
    (db (#b10100000))

                                        ; B
    (db (4))
    (db (#b11000000))
    (db (#b10100000))
    (db (#b11000000))
    (db (#b10100000))
    (db (#b11000000))

                                        ; C
    (db (4))
    (db (#b01100000))
    (db (#b10000000))
    (db (#b10000000))
    (db (#b10000000))
    (db (#b01100000))

                                        ; D
    (db (4))
    (db (#b11000000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b11000000))

                                        ; E
    (db (4))
    (db (#b11100000))
    (db (#b10000000))
    (db (#b11000000))
    (db (#b10000000))
    (db (#b11100000))

                                        ; F
    (db (4))
    (db (#b11100000))
    (db (#b10000000))
    (db (#b11000000))
    (db (#b10000000))
    (db (#b10000000))

                                        ; G
    (db (4))
    (db (#b01100000))
    (db (#b10000000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b01100000))

                                        ; H
    (db (4))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b11100000))
    (db (#b10100000))
    (db (#b10100000))

                                        ; I
    (db (4))
    (db (#b11100000))
    (db (#b01000000))
    (db (#b01000000))
    (db (#b01000000))
    (db (#b11100000))

                                        ; J
    (db (4))
    (db (#b11100000))
    (db (#b01000000))
    (db (#b01000000))
    (db (#b01000000))
    (db (#b10000000))

                                        ; K
    (db (4))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b11000000))
    (db (#b10100000))
    (db (#b10100000))

                                        ; L
    (db (4))
    (db (#b10000000))
    (db (#b10000000))
    (db (#b10000000))
    (db (#b10000000))
    (db (#b11100000))

                                        ; M
    (db (4))
    (db (#b10100000))
    (db (#b11100000))
    (db (#b11100000))
    (db (#b10100000))
    (db (#b10100000))

                                        ; N
    (db (4))
    (db (#b11000000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b10100000))

                                        ; O
    (db (4))
    (db (#b11100000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b11100000))

                                        ; P
    (db (4))
    (db (#b11000000))
    (db (#b10100000))
    (db (#b11000000))
    (db (#b10000000))
    (db (#b10000000))

                                        ; Q
    (db (4))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b11100000))
    (db (#b01100000))

                                        ; R
    (db (4))
    (db (#b11000000))
    (db (#b10100000))
    (db (#b11000000))
    (db (#b10100000))
    (db (#b10100000))

                                        ; S
    (db (4))
    (db (#b01100000))
    (db (#b10000000))
    (db (#b01000000))
    (db (#b00100000))
    (db (#b11000000))

                                        ; T
    (db (4))
    (db (#b11100000))
    (db (#b01000000))
    (db (#b01000000))
    (db (#b01000000))
    (db (#b01000000))

                                        ; U
    (db (4))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b11100000))

                                        ; V
    (db (4))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b01000000))

                                        ; W
    (db (4))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b11100000))
    (db (#b11100000))
    (db (#b10100000))

                                        ; X
    (db (4))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b10100000))

                                        ; Y
    (db (4))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b01000000))
    (db (#b01000000))
    (db (#b01000000))

                                        ; Z
    (db (4))
    (db (#b11100000))
    (db (#b00100000))
    (db (#b01000000))
    (db (#b10000000))
    (db (#b11100000))

                                        ; [
    (db (4))
    (db (#b11100000))
    (db (#b10000000))
    (db (#b10000000))
    (db (#b10000000))
    (db (#b11100000))

                                        ; \
    (db (4))
    (db (#b10000000))
    (db (#b10000000))
    (db (#b01000000))
    (db (#b00100000))
    (db (#b00100000))

                                        ; ]
    (db (4))
    (db (#b11100000))
    (db (#b00100000))
    (db (#b00100000))
    (db (#b00100000))
    (db (#b11100000))

                                        ; ^
    (db (4))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))

                                        ; _
    (db (4))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b11110000))

                                        ; `
    (db (4))
    (db (#b10000000))
    (db (#b01000000))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))

                                        ; a
    (db (4))
    (db (#b00000000))
    (db (#b01100000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b01100000))

                                        ; b
    (db (4))
    (db (#b10000000))
    (db (#b11000000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b11000000))

                                        ; c
    (db (4))
    (db (#b00000000))
    (db (#b01100000))
    (db (#b10000000))
    (db (#b10000000))
    (db (#b01100000))

                                        ; d
    (db (4))
    (db (#b00100000))
    (db (#b01100000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b01100000))

                                        ; e
    (db (4))
    (db (#b00000000))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b11000000))
    (db (#b01100000))

                                        ; f
    (db (4))
    (db (#b00100000))
    (db (#b01000000))
    (db (#b11100000))
    (db (#b01000000))
    (db (#b01000000))

                                        ; g
    (db (4))
    (db (#b00000000))
    (db (#b01100000))
    (db (#b11100000))
    (db (#b00100000))
    (db (#b11000000))

                                        ; h
    (db (4))
    (db (#b10000000))
    (db (#b11000000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b10100000))

                                        ; i
    (db (4))
    (db (#b01000000))
    (db (#b00000000))
    (db (#b11000000))
    (db (#b01000000))
    (db (#b11100000))

                                        ; j
    (db (4))
    (db (#b00100000))
    (db (#b00000000))
    (db (#b00100000))
    (db (#b10100000))
    (db (#b01000000))

                                        ; k
    (db (4))
    (db (#b10000000))
    (db (#b10100000))
    (db (#b11000000))
    (db (#b10100000))
    (db (#b10100000))

                                        ; l
    (db (4))
    (db (#b11000000))
    (db (#b01000000))
    (db (#b01000000))
    (db (#b01000000))
    (db (#b11100000))

                                        ; m
    (db (4))
    (db (#b00000000))
    (db (#b10100000))
    (db (#b11100000))
    (db (#b10100000))
    (db (#b10100000))

                                        ; n
    (db (4))
    (db (#b00000000))
    (db (#b11000000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b10100000))

                                        ; o
    (db (4))
    (db (#b00000000))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b01000000))

                                        ; p
    (db (4))
    (db (#b00000000))
    (db (#b11000000))
    (db (#b10100000))
    (db (#b11000000))
    (db (#b10000000))

                                        ; q
    (db (4))
    (db (#b00000000))
    (db (#b01100000))
    (db (#b10100000))
    (db (#b01100000))
    (db (#b00100000))

                                        ; r
    (db (4))
    (db (#b00000000))
    (db (#b10100000))
    (db (#b11000000))
    (db (#b10000000))
    (db (#b10000000))

                                        ; s
    (db (4))
    (db (#b00000000))
    (db (#b01100000))
    (db (#b11000000))
    (db (#b00100000))
    (db (#b11000000))

                                        ; t
    (db (4))
    (db (#b01000000))
    (db (#b11100000))
    (db (#b01000000))
    (db (#b01000000))
    (db (#b01100000))

                                        ; u
    (db (4))
    (db (#b00000000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b11100000))

                                        ; v
    (db (4))
    (db (#b00000000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b01000000))

                                        ; w
    (db (4))
    (db (#b00000000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b11100000))
    (db (#b10100000))

                                        ; x
    (db (4))
    (db (#b00000000))
    (db (#b10100000))
    (db (#b01000000))
    (db (#b01000000))
    (db (#b10100000))

                                        ; y
    (db (4))
    (db (#b00000000))
    (db (#b10100000))
    (db (#b01100000))
    (db (#b00100000))
    (db (#b11000000))

                                        ; z
    (db (4))
    (db (#b00000000))
    (db (#b11100000))
    (db (#b01100000))
    (db (#b11000000))
    (db (#b11100000))

                                        ; {
    (db (4))
    (db (#b01100000))
    (db (#b01000000))
    (db (#b10000000))
    (db (#b01000000))
    (db (#b01100000))

                                        ; |
    (db (4))
    (db (#b01000000))
    (db (#b01000000))
    (db (#b01000000))
    (db (#b01000000))
    (db (#b01000000))

                                        ; }
    (db (4))
    (db (#b11000000))
    (db (#b01000000))
    (db (#b00100000))
    (db (#b01000000))
    (db (#b11000000))

                                        ; ~
    (db (4))
    (db (#b01100000))
    (db (#b11000000))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))

                                        ; (DEL)
    (db (4))
    (db (#b11100000))
    (db (#b11100000))
    (db (#b11100000))
    (db (#b11100000))
    (db (#b11100000))

                                        ; €
    (db (5))
    (db (#b00110000))
    (db (#b11000000))
    (db (#b01100000))
    (db (#b11000000))
    (db (#b00110000))

                                        ; n/a
    (db (0 0 0 0 0 0))

                                        ; ‚
    (db (3))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b01000000))
    (db (#b10000000))

                                        ; ƒ
    (db (4))
    (db (#b00100000))
    (db (#b01000000))
    (db (#b11100000))
    (db (#b01000000))
    (db (#b10000000))

                                        ; „
    (db (5))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b01010000))
    (db (#b10100000))

                                        ; …
    (db (5))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))

                                        ; †
    (db (4))
    (db (#b01000000))
    (db (#b11100000))
    (db (#b01000000))
    (db (#b01000000))
    (db (#b01000000))

                                        ; ‡
    (db (4))
    (db (#b01000000))
    (db (#b11100000))
    (db (#b01000000))
    (db (#b11100000))
    (db (#b01000000))

                                        ; ˆ
    (db (4))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))

                                        ; ‰
    (db (5))
    (db (#b10100000))
    (db (#b00100000))
    (db (#b01000000))
    (db (#b10010000))
    (db (#b10100000))

                                        ; Š
    (db (4))
    (db (#b01100000))
    (db (#b10000000))
    (db (#b01000000))
    (db (#b00100000))
    (db (#b11000000))

                                        ; ‹
    (db (3))
    (db (#b00000000))
    (db (#b01000000))
    (db (#b10000000))
    (db (#b01000000))
    (db (#b00000000))

                                        ; Œ
    (db (6))
    (db (#b01111000))
    (db (#b10100000))
    (db (#b10110000))
    (db (#b10100000))
    (db (#b01111000))

                                        ; n/a
    (db (0 0 0 0 0 0))

                                        ; Ž
    (db (5))
    (db (#b11100000))
    (db (#b00100000))
    (db (#b01000000))
    (db (#b10000000))
    (db (#b11100000))

                                        ; n/a
    (db (0 0 0 0 0 0))

                                        ; n/a
    (db (0 0 0 0 0 0))

                                        ; ‘
    (db (3))
    (db (#b10000000))
    (db (#b01000000))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))

                                        ; ’
    (db (3))
    (db (#b01000000))
    (db (#b10000000))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))

                                        ; “
    (db (5))
    (db (#b10100000))
    (db (#b01010000))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))

                                        ; ”
    (db (5))
    (db (#b01010000))
    (db (#b10100000))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))

                                        ; •
    (db (6))
    (db (#b01110000))
    (db (#b11111000))
    (db (#b11111000))
    (db (#b11111000))
    (db (#b01110000))

                                        ; –
    (db (5))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b11110000))
    (db (#b00000000))
    (db (#b00000000))

                                        ; —
    (db (5))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b11111000))
    (db (#b00000000))
    (db (#b00000000))

                                        ; ˜
    (db (5))
    (db (#b01010000))
    (db (#b10100000))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))

                                        ; ™
    (db (7))
    (db (#b11111100))
    (db (#b01011100))
    (db (#b01010100))
    (db (#b00000000))
    (db (#b00000000))

                                        ; š
    (db (3))
    (db (#b00000000))
    (db (#b11000000))
    (db (#b10000000))
    (db (#b01000000))
    (db (#b11000000))

                                        ; ›
    (db (3))
    (db (#b00000000))
    (db (#b10000000))
    (db (#b01000000))
    (db (#b10000000))
    (db (#b00000000))

                                        ; œ
    (db (7))
    (db (#b00000000))
    (db (#b01001000))
    (db (#b10110100))
    (db (#b10111000))
    (db (#b01011100))

                                        ; n/a
    (db (0 0 0 0 0 0))

                                        ; ž
    (db (3))
    (db (#b00000000))
    (db (#b11000000))
    (db (#b01000000))
    (db (#b10000000))
    (db (#b11000000))

                                        ; Ÿ
    (db (4))
    (db (#b10100000))
    (db (#b00000000))
    (db (#b10100000))
    (db (#b01000000))
    (db (#b01000000))

                                        ; n/a
    (db (0 0 0 0 0 0))

                                        ; ¡
    (db (2))
    (db (#b10000000))
    (db (#b00000000))
    (db (#b10000000))
    (db (#b10000000))
    (db (#b10000000))

                                        ; ¢
    (db (5))
    (db (#b00100000))
    (db (#b01110000))
    (db (#b10100000))
    (db (#b01110000))
    (db (#b00000000))

                                        ; £
    (db (5))
    (db (#b00110000))
    (db (#b01000000))
    (db (#b11100000))
    (db (#b01000000))
    (db (#b01110000))

                                        ; ¤
    (db (5))
    (db (#b10001000))
    (db (#b01110000))
    (db (#b01010000))
    (db (#b01110000))
    (db (#b10001000))

                                        ; ¥
    (db (5))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b01000000))
    (db (#b11100000))
    (db (#b01000000))

                                        ; ¦
    (db (2))
    (db (#b10000000))
    (db (#b10000000))
    (db (#b00000000))
    (db (#b10000000))
    (db (#b10000000))

                                        ; §
    (db (4))
    (db (#b01100000))
    (db (#b11000000))
    (db (#b10100000))
    (db (#b01100000))
    (db (#b11000000))

                                        ; ¨
    (db (4))
    (db (#b10100000))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))

                                        ; ©
    (db (5))
    (db (#b01110000))
    (db (#b10111000))
    (db (#b11001000))
    (db (#b10111000))
    (db (#b01110000))

                                        ; ª
    (db (5))
    (db (#b01100000))
    (db (#b10100000))
    (db (#b01100000))
    (db (#b00000000))
    (db (#b00000000))

                                        ; «
    (db (5))
    (db (#b00000000))
    (db (#b01010000))
    (db (#b10100000))
    (db (#b01010000))
    (db (#b00000000))

                                        ; ¬
    (db (5))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b11100000))
    (db (#b00100000))
    (db (#b00000000))

                                        ; »
    (db (5))
    (db (#b00000000))
    (db (#b10100000))
    (db (#b01010000))
    (db (#b10100000))
    (db (#b00000000))

                                        ; ®
    (db (5))
    (db (#b01110000))
    (db (#b10111000))
    (db (#b11001000))
    (db (#b11001000))
    (db (#b01110000))

                                        ; ¯
    (db (4))
    (db (#b11110000))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))

                                        ; °
    (db (4))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b01000000))
    (db (#b00000000))
    (db (#b00000000))

                                        ; ±
    (db (4))
    (db (#b01000000))
    (db (#b11100000))
    (db (#b01000000))
    (db (#b00000000))
    (db (#b11100000))

                                        ; ²
    (db (3))
    (db (#b11000000))
    (db (#b01000000))
    (db (#b10000000))
    (db (#b11000000))
    (db (#b00000000))

                                        ; ³
    (db (3))
    (db (#b11000000))
    (db (#b01000000))
    (db (#b11000000))
    (db (#b00000000))
    (db (#b00000000))

                                        ; ´
    (db (3))
    (db (#b01000000))
    (db (#b10000000))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))

                                        ; µ
    (db (4))
    (db (#b00000000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b11100000))
    (db (#b10000000))

                                        ; ¶
    (db (5))
    (db (#b01110000))
    (db (#b10110000))
    (db (#b10110000))
    (db (#b01110000))
    (db (#b00110000))

                                        ; ·
    (db (2))
    (db (#b00000000))
    (db (#b10000000))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))

                                        ; ¸
    (db (2))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b00000000))
    (db (#b01000000))
    (db (#b11000000))

                                        ; ¹
    (db (4))
    (db (#b11000000))
    (db (#b01000000))
    (db (#b11100000))
    (db (#b00000000))
    (db (#b00000000))

                                        ; º
    (db (5))
    (db (#b01100000))
    (db (#b10010000))
    (db (#b10010000))
    (db (#b01100000))
    (db (#b00000000))

                                        ; »
    (db (5))
    (db (#b00000000))
    (db (#b10100000))
    (db (#b01010000))
    (db (#b10100000))
    (db (#b00000000    ))

                                        ; ¼
    (db (7))
    (db (#b10010000))
    (db (#b10010000))
    (db (#b00101000))
    (db (#b01001100))
    (db (#b01000100))

                                        ; ½
    (db (8))
    (db (#b10010000))
    (db (#b10010100))
    (db (#b00100010))
    (db (#b01000100))
    (db (#b01000110))

                                        ; ¾
    (db (8))
    (db (#b11001000))
    (db (#b01001000))
    (db (#b11010100))
    (db (#b00100110))
    (db (#b00100010))

                                        ; ¿
    (db (4))
    (db (#b01000000))
    (db (#b00000000))
    (db (#b01000000))
    (db (#b10000000))
    (db (#b01100000))

                                        ; À
    (db (4))
    (db (#b10000000))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b11100000))
    (db (#b10100000))

                                        ; Á
    (db (4))
    (db (#b00100000))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b11100000))
    (db (#b10100000))

                                        ; Â
    (db (4))
    (db (#b11100000))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b11100000))
    (db (#b10100000))

                                        ; Ã
    (db (4))
    (db (#b01100000))
    (db (#b11000000))
    (db (#b10100000))
    (db (#b11100000))
    (db (#b10100000))

                                        ; Ä
    (db (4))
    (db (#b10100000))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b11100000))
    (db (#b10100000))

                                        ; Å
    (db (4))
    (db (#b01000000))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b11100000))
    (db (#b10100000))

                                        ; Æ
    (db (6))
    (db (#b01111000))
    (db (#b10100000))
    (db (#b11110000))
    (db (#b10100000))
    (db (#b10111000))

                                        ; Ç
    (db (4))
    (db (#b01100000))
    (db (#b10000000))
    (db (#b10000000))
    (db (#b01100000))
    (db (#b11000000))

                                        ; È
    (db (4))
    (db (#b11100000))
    (db (#b10000000))
    (db (#b11000000))
    (db (#b10000000))
    (db (#b11100000))

                                        ; É
    (db (4))
    (db (#b11100000))
    (db (#b10000000))
    (db (#b11000000))
    (db (#b10000000))
    (db (#b11100000))

                                        ; Ê
    (db (4))
    (db (#b11100000))
    (db (#b10000000))
    (db (#b11000000))
    (db (#b10000000))
    (db (#b11100000))

                                        ; Ë
    (db (4))
    (db (#b11100000))
    (db (#b10000000))
    (db (#b11000000))
    (db (#b10000000))
    (db (#b11100000))

                                        ; Ì
    (db (4))
    (db (#b10000000))
    (db (#b01000000))
    (db (#b11100000))
    (db (#b01000000))
    (db (#b11100000))

                                        ; Í
    (db (4))
    (db (#b00100000))
    (db (#b01000000))
    (db (#b11100000))
    (db (#b01000000))
    (db (#b11100000))

                                        ; Î
    (db (4))
    (db (#b11100000))
    (db (#b00000000))
    (db (#b11100000))
    (db (#b01000000))
    (db (#b11100000))

                                        ; Ï
    (db (4))
    (db (#b10100000))
    (db (#b00000000))
    (db (#b01000000))
    (db (#b01000000))
    (db (#b01000000))

                                        ; Ð
    (db (4))
    (db (#b11000000))
    (db (#b10100000))
    (db (#b11100000))
    (db (#b10100000))
    (db (#b11000000))

                                        ; Ñ
    (db (4))
    (db (#b11100000))
    (db (#b00000000))
    (db (#b10100000))
    (db (#b11100000))
    (db (#b11100000))

                                        ; Ò
    (db (4))
    (db (#b10000000))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b01000000    ))

                                        ; Ó
    (db (4))
    (db (#b00100000))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b01000000))

                                        ; Ô
    (db (4))
    (db (#b01000000))
    (db (#b11100000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b01000000))

                                        ; Õ
    (db (4))
    (db (#b11100000))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b01000000))

                                        ; Ö
    (db (4))
    (db (#b10100000))
    (db (#b00000000))
    (db (#b11100000))
    (db (#b10100000))
    (db (#b01000000))

                                        ; ×
    (db (4))
    (db (#b00000000))
    (db (#b10100000))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b00000000))

                                        ; Ø
    (db (4))
    (db (#b00100000))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b01000000))
    (db (#b10000000))

                                        ; Ù
    (db (4))
    (db (#b10000000))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b01000000))

                                        ; Ú
    (db (4))
    (db (#b00100000))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b01000000))

                                        ; Û
    (db (4))
    (db (#b11100000))
    (db (#b00000000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b01000000))

                                        ; Ü
    (db (4))
    (db (#b10100000))
    (db (#b00000000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b01000000))

                                        ; Ý
    (db (4))
    (db (#b00100000))
    (db (#b00000000))
    (db (#b10100000))
    (db (#b01000000))
    (db (#b01000000))

                                        ; Þ
    (db (4))
    (db (#b10000000))
    (db (#b11000000))
    (db (#b10100000))
    (db (#b11000000))
    (db (#b10000000))

                                        ; ß
    (db (4))
    (db (#b11000000))
    (db (#b10100000))
    (db (#b11000000))
    (db (#b11100000))
    (db (#b10000000))

                                        ; à
    (db (4))
    (db (#b10000000))
    (db (#b01000000))
    (db (#b01100000))
    (db (#b10100000))
    (db (#b01100000))

                                        ; á
    (db (4))
    (db (#b00100000))
    (db (#b01000000))
    (db (#b01100000))
    (db (#b10100000))
    (db (#b01100000))

                                        ; â
    (db (4))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b01100000))
    (db (#b10100000))
    (db (#b01100000))

                                        ; ã
    (db (4))
    (db (#b10100000))
    (db (#b01000000))
    (db (#b01100000))
    (db (#b10100000))
    (db (#b01100000))

                                        ; ä
    (db (4))
    (db (#b10100000))
    (db (#b00000000))
    (db (#b01100000))
    (db (#b10100000))
    (db (#b01100000))

                                        ; å
    (db (4))
    (db (#b00000000))
    (db (#b01100000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b01100000))

                                        ; æ
    (db (7))
    (db (#b00000000))
    (db (#b01101100))
    (db (#b10110100))
    (db (#b10111000))
    (db (#b01101100))

                                        ; ç
    (db (4))
    (db (#b01100000))
    (db (#b10000000))
    (db (#b01100000))
    (db (#b01000000))
    (db (#b11000000))

                                        ; è
    (db (4))
    (db (#b10000000))
    (db (#b01100000))
    (db (#b10100000))
    (db (#b11000000))
    (db (#b01100000))

                                        ; é
    (db (4))
    (db (#b00100000))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b11000000))
    (db (#b01100000))

                                        ; ê
    (db (4))
    (db (#b00000000))
    (db (#b01100000))
    (db (#b10100000))
    (db (#b11000000))
    (db (#b01100000))

                                        ; ë
    (db (4))
    (db (#b10100000))
    (db (#b01100000))
    (db (#b10100000))
    (db (#b11000000))
    (db (#b01100000))

                                        ; ì
    (db (4))
    (db (#b01000000))
    (db (#b00100000))
    (db (#b01000000))
    (db (#b01000000))
    (db (#b01100000))

                                        ; í
    (db (4))
    (db (#b01000000))
    (db (#b10000000))
    (db (#b01000000))
    (db (#b01000000))
    (db (#b11100000))

                                        ; î
    (db (4))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b01000000))
    (db (#b01000000))
    (db (#b01100000))

                                        ; ï
    (db (4))
    (db (#b10100000))
    (db (#b00000000))
    (db (#b01000000))
    (db (#b01000000))
    (db (#b11100000))

                                        ; ð
    (db (4))
    (db (#b11000000))
    (db (#b00100000))
    (db (#b01100000))
    (db (#b10100000))
    (db (#b01000000))

                                        ; ñ
    (db (4))
    (db (#b10100000))
    (db (#b01000000))
    (db (#b11000000))
    (db (#b10100000))
    (db (#b10100000))

                                        ; ò
    (db (4))
    (db (#b01000000))
    (db (#b00100000))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b01000000))

                                        ; ó
    (db (4))
    (db (#b01000000))
    (db (#b10000000))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b01000000))

                                        ; ô
    (db (4))
    (db (#b01000000))
    (db (#b00000000))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b01000000))

                                        ; õ
    (db (4))
    (db (#b11100000))
    (db (#b00000000))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b01000000))

                                        ; ö
    (db (4))
    (db (#b10100000))
    (db (#b00000000))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b01000000))

                                        ; ÷
    (db (4))
    (db (#b01000000))
    (db (#b00000000))
    (db (#b11100000))
    (db (#b00000000))
    (db (#b01000000))

                                        ; ø
    (db (4))
    (db (#b00100000))
    (db (#b01100000))
    (db (#b10100000))
    (db (#b11000000))
    (db (#b10000000))

                                        ; ù
    (db (4))
    (db (#b11000000))
    (db (#b00100000))
    (db (#b01100000))
    (db (#b10100000))
    (db (#b01000000))

                                        ; ú
    (db (4))
    (db (#b00100000))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b01100000))

                                        ; û
    (db (4))
    (db (#b11100000))
    (db (#b00000000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b01100000))

                                        ; ü
    (db (4))
    (db (#b10100000))
    (db (#b00000000))
    (db (#b10100000))
    (db (#b10100000))
    (db (#b01100000))

                                        ; ý
    (db (4))
    (db (#b00100000))
    (db (#b01000000))
    (db (#b10100000))
    (db (#b01000000))
    (db (#b10000000))

                                        ; þ
    (db (4))
    (db (#b10000000))
    (db (#b11000000))
    (db (#b10100000))
    (db (#b11000000))
    (db (#b10000000))

                                        ; ÿ
    (db (4))
    (db (#b10100000))
    (db (#b00000000))
    (db (#b10100000))
    (db (#b01000000))
    (db (#b10000000))
    ))
