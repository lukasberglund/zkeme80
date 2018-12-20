(use-modules (ice-9 match)
             (ice-9 binary-ports)
             (rnrs bytevectors)
             (srfi srfi-9))

(define verbose? #f)

;; Turns out these things care called "register groups", bit-fields
;; for each register in various instructions.  Will be revised as I
;; implement more of the Z80 instruction set.
(define 16-bit-regs
  '((af . #b11)
    (bc . #b00)
    (de . #b01)
    (hl . #b10)
    (sp . #b11)))

(define push-pop-index-regs
  '((ix . #b11011101)
    (iy . #b11111101)))

(define ld-regs
  '((a . #b111)
    (b . #b000)
    (c . #b001)
    (d . #b010)
    (e . #b011)
    (h . #b100)
    (l . #b101)
    ((hl) . #b110)))

(define ir-regs
  '((i . 0)
    (r . 1)))

(define condition-codes
  '((nz . #b000)
    (z  . #b001)
    (nc . #b010)
    (c  . #b011)
    (po . #b100)
    (pe . #b101)
    (p . #b110)
    (m . #b111)))

(define jr-condition-codes
  '((nz . #b00)
    (z  . #b01)
    (nc . #b10)
    (c  . #b11)))

(define (lookup key alist)
  (let ((match (assoc key alist)))
    (if match
        (cdr match)
        (begin
          ;; Verbose
          (if verbose? (format #t "Failed to lookup: ~a\n" key))
          #f))))

(define (index-reg? reg)
  (member reg '(ix iy)))

;; We often see in the data sheet opcodes like this:
;; PUSH reg16 -> 11[reg16]0101
;; ((bc . #b00) (de . #b01) (hl . #b10) (af . #b11))

;; This means we can generate the opcode for that instruction by
;; offsetting a "register code" by some number of bits and performing
;; logical or on the result with the "template" opcode.
(define (make-opcode reg-code offset opcode)
  (logior (ash reg-code
               offset)
          opcode))

(define-record-type <inst>
  (make-inst-rec cycles length generator)
  inst?
  (cycles inst-cycles)
  (length inst-length)
  (generator inst-generator))

(define-syntax make-inst
  (syntax-rules ()
    ((_ cycles length generator)
     (make-inst-rec cycles length (delay generator)))))

(define (gen-inst inst)
  (force (inst-generator inst)))

(define (assemble-push reg)
  (if (index-reg? reg)
      (make-inst 15 2 `(,(lookup reg push-pop-index-regs) #b11100101))
      (make-inst 11 1 `(,(make-opcode (lookup reg 16-bit-regs) 4 #b11000101)))))

(define (assemble-pop reg)
  (if (index-reg? reg)
      (make-inst 14 2  `(,(lookup reg push-pop-index-regs) #b11100001))
      (make-inst 10 1 `(,(make-opcode (lookup reg 16-bit-regs) 4 #b11000001)))))

(define (unsigned-nat? x)
  (and (integer? x) (>= x 0)))

(define (8-bit-imm? x)
  (and (unsigned-nat? x)
       (> (ash 1 8) x)))

(define (16-bit-imm-or-label? x)
  (or (symbol? x)
      (and (unsigned-nat? x)
           (> (ash 1 16) x))))

(define (16-bit-imm? x)
  (and (unsigned-nat? x)
       (> (ash 1 16) x)))

(define (num->binary n)
  (format #f "~8,'0b" n))

(define (num->hex n)
  (format #f "~2,'0x" n))

(define (16-bit-reg? x)
  (lookup x 16-bit-regs))

;; Unsure of register group, so this solution for now.
(define (8-bit-reg? x)
  (member x '(a b c d e f h l ixl ixh i r (hl))))

(define (ir-reg? x)
  (lookup x ir-regs))

(define (reg? x)
  (or (16-bit-reg? x)  (8-bit-reg? x)))

(define (assemble-ld-reg8-reg8 dest src)
  (make-inst (if (eqv? dest '(hl)) 7 4)
             1
             `(,(make-opcode (lookup src ld-regs)
                             0
                             (make-opcode (lookup dest ld-regs)
                                          3
                                          #b01000000)))))
(define (assemble-ld-reg8-imm8 reg8 imm8)
  (make-inst (if (eqv? reg8 '(hl)) 10 7)
             2
             `(,(make-opcode (lookup reg8 ld-regs) 3 #b00000110) ,imm8)))

(define (assemble-ld-hl-iimm16 iimm16)
  (make-inst 16
             3
             `(#b00101010
               ,(lsb iimm16)
               ,(msb iimm16))))

(define ld-iregs
  '((bc . #b0) (de . #b1)))

(define (assemble-ld-a-ireg16 reg)
  (make-inst 14
             1
             `(,(make-opcode (lookup reg ld-iregs) 4 #b00001010))))

;; Least significant byte.
(define (lsb n)
  (logand n 255))

;; Most significant byte.
(define (msb n)
  (ash n -8))

(define (resolve-label label-or-imm16)
  (if (16-bit-imm? label-or-imm16)
      label-or-imm16
      (or (lookup label-or-imm16 *labels*)
          (error (format #f "Label not found: ~a" label-or-imm16)))))

(define (assemble-ld-reg16-imm16 reg16 imm16)
  (make-inst 10
             3
             (let ((imm16 (resolve-label imm16)))
               `(,(make-opcode (lookup reg16 16-bit-regs) 4 #b00000001)
                 ,(lsb imm16)
                 ,(msb imm16)))))


(define (assemble-ld-reg16-iimm16 reg16 imm16)
  (make-inst 20
             4
             (let ((imm16 (resolve-label imm16)))
               `(#b11101101
                 ,(make-opcode (lookup reg16 16-bit-regs) 4 #b01001011)
                 ,(lsb imm16)
                 ,(msb imm16)))))


(define (assemble-ld-ireg16-a reg16)
  (make-inst 7
             1
             `(,(make-opcode (lookup reg16 16-bit-regs) 4 #b00000010))))

(define ld-index-imm16-regs
  '((ix . #b11011101)
    (iy . #b11111101)))

(define (assemble-ld-index-imm16 ireg imm16)
  (make-inst 14
             4
             (let ((imm16 (resolve-label imm16)))
               `(,(lookup ireg ld-index-imm16-regs)
                 #b00100001
                 ,(lsb imm16)
                 ,(msb imm16)))))

(define (assemble-ld-ir-reg ir)
  (make-inst 9
             2
             `(#b11101101
               ,(make-opcode (lookup ir ir-regs) 3 #b01010111))))

(define (assemble-ld-iimm16-a addr)
  (make-inst 13
             3
             `(#b00110010
               ,(lsb addr)
               ,(msb addr))))

(define (assemble-ld-a-imm16 addr)
  (make-inst 13
             3
             `(#b00111010
               ,(lsb addr)
               ,(msb addr))))

(define (assemble-ld-sp-hl)
  (make-inst 6
             1
             `(#b11111001)))

(define (assemble-ld-reg8-index-offset a b c)
  (make-inst 19
             3
             `(,(if (eq? b 'ix) #b11011101 #b11111101)
               ,(make-opcode (lookup a ld-regs) 3 #b01000110)
               ,c)))

(define (assemble-ld args)
  (match args
    ('(sp hl)
     (assemble-ld-sp-hl))
    (('a (? ir-reg? b))
     (assemble-ld-ir-reg b))
    (((? 8-bit-reg? a) (? 8-bit-reg? b))
     (assemble-ld-reg8-reg8 a b))
    (((? 8-bit-reg? a) ('+ (? index-reg? b) (? 8-bit-imm? c)))
     (assemble-ld-reg8-index-offset a b c))
    (((? 8-bit-reg? a) ('+ (? 8-bit-imm? c) (? index-reg? b)))
     (assemble-ld-reg8-index-offset a b c))
    (('a ((? 16-bit-reg? b)))
     (assemble-ld-a-ireg16 b))
    (('a ((? 16-bit-imm-or-label? b)))
     (assemble-ld-a-imm16 b))
    ((((? 16-bit-reg? b)) 'a)
     (assemble-ld-ireg16-a b))
    ((((? 16-bit-imm-or-label? a)) 'a)
     (assemble-ld-iimm16-a a))
    (((? 8-bit-reg? a) (? 8-bit-imm? b))
     (assemble-ld-reg8-imm8 a b))
    (((? 16-bit-reg? a) (? 16-bit-imm-or-label? b))
     (assemble-ld-reg16-imm16 a b))
    (((? 16-bit-reg? a) ((? 16-bit-imm-or-label? b)))
     (assemble-ld-reg16-iimm16 a b))
    (('hl ((? 16-bit-imm-or-label? b)))
     (assemble-ld-hl-iimm16 b))
    (((? index-reg? a) (? 16-bit-imm-or-label? b))
     (assemble-ld-index-imm16 a b))
    
    
    (_
     (error (format #f "Invalid operands to ld: ~a" args))))
  )

(define (simple-op? op) (lookup op simple-ops))

;; Operations that don't receive arguments or have specific ones.
(define simple-ops
  '((otdr         .  (0 2 (#b11101101 #b10111011)))
    (lddr         .  (0 2 (#b11101101 #b10111000)))
    (otir         .  (0 2 (#b11101101 #b10110011)))
    (indr         .  (0 2 (#b11101101 #b10110010)))
    (ldir         .  (0 2 (#b11101101 #b10110000)))
    (outd         .  (0 2 (#b11101101 #b10101011)))
    (ind          .  (0 2 (#b11101101 #b10101010)))
    (outi         .  (0 2 (#b11101101 #b10100011)))
    (ldi          .  (0 2 (#b11101101 #b10100000)))
    (rld          .  (0 2 (#b11101101 #b01101111)))
    (rrd          .  (0 2 (#b11101101 #b01100111)))
    (reti         .  (0 2 (#b11101101 #b01001101)))
    (retn         .  (0 2 (#b11101101 #b01000101)))
    (neg          .  (8 2 (#b11101101 #b01000100)))
    (ei           .  (0 1 (#b11111011)))
    (di           .  (0 1 (#b11110011)))
    ((ex de hl)   .  (0 1 (#b11101011)))
    ((ex (sp) hl) .  (0 1 (#b11100011)))
    (exx          .  (0 1 (#b11011001)))
    (ret          .  (0 1 (#b11001001)))
    (halt         .  (0 1 (#b01110110)))
    (ccf          .  (0 1 (#b00111111)))
    (scf          .  (4 1 (#b00110111)))
    (cpl          .  (4 1 (#b00101111)))
    (rra          .  (0 1 (#b00011111)))
    (rla          .  (0 1 (#b00010111)))
    (rrca         .  (0 1 (#b00001111)))
    ((ex af afs)  .  (0 1 (#b00001000)))
    (rlca         .  (0 1 (#b00000111)))
    (nop          .  (0 1 (#b00000000)))
    ))

(define (assemble-simple a)
  (let ((res (lookup a simple-ops)))
    (if res
        (make-inst (car res) (cadr res) (caddr res))
        (error (format #f "Operation not found: ~a" a)))))

(define (add-label! name val)
  (if (assv name *labels*)
      (error (format #f "Cannot add another label of ~a" name))
      (begin
        (format #t "Adding label ~a with value 0x~4,'0x\n" name val)
        (set! *labels* `((,name . ,val) . ,*labels*)))))


(define (advance-pc! count)
  (set! *pc* (+ *pc* count)))
(define (assemble-label name)
  (add-label! name *pc*)
  '())

(define (assemble-org new-pc)
  (set! *pc* new-pc)
  '())

(define (condition? s) (lookup s condition-codes))

(define (assemble-cond-jp cond imm16)
  (make-inst 10
             3
             (let ((imm16 (resolve-label imm16)))
               `(,(make-opcode (lookup cond condition-codes) 3 #b11000010)
                 ,(lsb imm16)
                 ,(msb imm16)))))

(define (assemble-uncond-jp imm16)
  (make-inst 10
             3
             (let ((imm16 (resolve-label imm16)))
               `(#b11000011
                 ,(lsb imm16)
                 ,(msb imm16)))))

(define (assemble-jp args)
  (match args
    (((? condition? a) b)
     (assemble-cond-jp a b))
    (((? 16-bit-imm-or-label? a))
     (assemble-uncond-jp a))))


(define (signed-8-bit-imm? x)
  (and (integer? x)
       (>= 127 (abs x))))

(define (jr-simm8-convert x)
  (if (negative? x)
      (+ 256 x)
      x)
  )

(define (resolve-jr-label-or-simm x)
  (if (symbol? x)
      (let* ((dest (resolve-label x))
             (offset (- dest *pc*)))
        ;; (format #t "~a\n" *pc*)
        ;; Compute the offset from the current program counter
        (if (not (signed-8-bit-imm? offset))
            (error (format #f "Offset ~a too far for 8-bit signed." offset))
            (jr-simm8-convert offset)))
      (and (signed-8-bit-imm? x)
           (jr-simm8-convert (- x *pc*)))))

(define (assemble-cond-jr cond simm8)
  (make-inst 9.5
             2
             (let ((simm8 (resolve-jr-label-or-simm simm8)))
               `(,(make-opcode (lookup cond condition-codes) 3 #b00100000)
                 ,simm8))))

(define (assemble-uncond-jr simm8)
  (make-inst 12
             2
             (let ((simm8 (resolve-jr-label-or-simm simm8)))
               `(#b00011000
                 ;; Follwed by a signed byte, -127 to +127
                 ,simm8))))

(define (assemble-jr args)
  (match args
    (((? condition? a) b)
     (assemble-cond-jr a b))
    (((? 16-bit-imm-or-label? a))
     (assemble-uncond-jr a))
    ))


(define (assemble-cond-call cond imm16)
  (make-inst 13.5
             3
             (let ((imm16 (resolve-label imm16)))
               `(,(make-opcode (lookup cond condition-codes) 3 #b11000100)
                 ,(lsb imm16)
                 ,(msb imm16)))))

(define (assemble-uncond-call imm16)
  (make-inst 17
             3
             (let ((imm16 (resolve-label imm16)))
               `(#b11001101
                 ,(lsb imm16)
                 ,(msb imm16)))))

(define (assemble-call args)
  (match args
    (((? condition? a) (? 16-bit-imm-or-label? b))
     (assemble-cond-call a b))
    (((? 16-bit-imm-or-label? a))
     (assemble-uncond-call a))
    (_
     (error (format #f "Invalid operands to call: ~a" args)))))

(define (assemble-dw word-list)
  (make-inst 0
             (ash (length word-list) 1)
             (flatten (map
                       (lambda (x)
                         (let ((x (if (symbol? x) (resolve-label x) x)))
                           (list (lsb x) (msb x))))
                       word-list))))

(define (assemble-db byte-list)
  (make-inst 0
             (length byte-list)
             byte-list))

(define (assemble-out-iimm8-a port)
  (make-inst 11
             2
             `(#b11010011
               ,port)))

(define (assemble-out-c-reg reg)
  (make-inst 12
             2
             `(#b11101011
               ,(make-opcode (lookup reg ld-regs) 3 #b01000001))))

(define (assemble-out arg)
  (match arg
    ((((? 8-bit-imm? p)) 'a)
     (assemble-out-iimm8-a p))
    (`((c) ,(? 8-bit-reg? r))
     (assemble-out-c-reg r))
    (_
     (error (format #f "Invalid operands to out: ~a" arg)))))

(define (assemble-in-a-iimm8 imm8)
  (make-inst 11
             2
             `(#b11011011
               ,imm8)))

(define (assemble-in-reg8-ic reg)
  (make-inst 12
             2
             `(#b11101011
               ,(make-opcode (lookup reg ld-regs) 3 #b01000000))))

(define (assemble-in arg)
  (match arg
    (('a ((? 8-bit-imm? p)))
     (assemble-in-a-iimm8 p))
    (((? 8-bit-reg? r) '(c))
     (assemble-in-reg8-ic r))
    (_
     (error (format #f "Invalid operands to out: ~a" arg)))))

(define (assemble-xor-8-bit-reg a)
  (make-inst (if (eqv? a '(hl)) 7 4)
             1
             `(,(make-opcode (lookup a ld-regs) 0 #b10101000))))

(define (assemble-xor-8-bit-imm a)
  (make-inst 7
             2
             `(#b11101110
               ,a)))

(define (assemble-xor arg)
  (match arg
    ((? 8-bit-reg? a)
     (assemble-xor-8-bit-reg a))
    ((? 8-bit-imm? a)
     (assemble-xor-8-bit-imm a))
    (_
     (error (format #f "Invalid operands to xor: ~a" arg)))))

(define (assemble-dec-8-bit-reg a)
  (make-inst (if (eqv? a '(hl)) 11 4)
             1
             `(,(make-opcode (lookup a ld-regs) 3 #b00000101))))

(define (assemble-dec-16-bit-reg a)
  (make-inst 6
             1
             `(,(make-opcode (lookup a 16-bit-regs) 4 #b00001011))))

(define (assemble-dec arg)
  (match arg
    ((? 8-bit-reg? a)
     (assemble-dec-8-bit-reg a))
    ((? 16-bit-reg? a)
     (assemble-dec-16-bit-reg a))
    (_
     (error (format #f "Invalid operands to dec: ~a" arg)))))

(define (assemble-inc-8-bit-reg arg)
  (make-inst (if (eqv? arg '(hl)) 11 4)
             1
             `(,(make-opcode (lookup arg ld-regs) 3 #b00000100))))

(define (assemble-inc-16-bit-reg arg)
  (make-inst 6
             1
             `(,(make-opcode (lookup arg 16-bit-regs) 4 #b00000011))))


(define (assemble-inc-index-reg arg)
  (make-inst 10
             2
             `(,(lookup arg ld-index-imm16-regs)
               #b00100011)))

(define (assemble-inc arg)
  (match arg
    ((? 8-bit-reg? a)
     (assemble-inc-8-bit-reg a))
    ((? 16-bit-reg? a)
     (assemble-inc-16-bit-reg a))
    ((? index-reg? a)
     (assemble-inc-index-reg a))
    (_
     (error #f "Invalid operands to inc: ~a" arg))))

(define (assemble-bit imm3 reg8)
  (make-inst (if (eqv? reg8 '(hl)) 12 8)
             2
             `(#b11001011
               ,(make-opcode imm3
                             3
                             (make-opcode (lookup reg8 ld-regs) 0 #b01000000)))))

(define (assemble-res imm3 reg8)
  (make-inst (if (eqv? reg8 '(hl)) 15 8)
             2
             `(#b11001011
               ,(make-opcode imm3
                             3
                             (make-opcode (lookup reg8 ld-regs) 0 #b10000000)))))

(define (assemble-set imm3 reg)
  (cond ((8-bit-reg? reg)
         (make-inst (if (eqv? reg '(hl)) 15 8)
                    2
                    `(#b11001011
                      ,(make-opcode imm3
                                    3
                                    (make-opcode (lookup reg ld-regs) 0 #b11000000)))))
        ((index-reg? (car reg))
         (make-inst 23
                    4
                    `(,(lookup (car reg) ld-index-imm16-regs)
                      #b11001011
                      ;; No offset for now.
                      #b00000000
                      ,(make-opcode imm3 3 #b11000110))))
        (else
         (error (format #f "Invalid operands to set: ~a" `(,imm3 ,reg))))))

(define (assemble-adc-8-bit-reg reg)
  (make-inst (if (eqv? reg '(hl)) 7 4)
             1
             `(,(make-opcode (lookup reg ld-regs) 0 #b10001000))))

(define (assemble-adc arg)
  (match arg
    (`(a ,(? 8-bit-reg? a))
     (assemble-adc-8-bit-reg a))
    (_
     (error (format #f "Invalid operands to adc: ~a" arg)))))

(define (assemble-and-8-bit-reg a)
  (make-inst (if (eqv? a '(hl)) 7 4)
             1
             `(,(make-opcode (lookup a ld-regs) 0 #b10100000))))

(define (assemble-and-8-bit-imm a)
  (make-inst 7
             2
             `(#b11100110
               ,a)))

(define (assemble-and-index-reg a)
  (make-inst 19
             3
             `(,(lookup a ld-index-imm16-regs)
               #b10100110
               ;; No offset for now.
               #b00000000)))

(define (assemble-and arg)
  (match arg
    ((? 8-bit-reg? a)
     (assemble-and-8-bit-reg a))
    ((? 8-bit-imm? a)
     (assemble-and-8-bit-imm a))
    (((? index-reg? a))
     (assemble-and-index-reg a))
    (_
     (error (format #f "Invalid operands to and: ~a" arg)))))

(define (assemble-or-8-bit-reg a)
  (make-inst (if (eqv? a '(hl)) 7 4)
             1
             `(,(make-opcode (lookup a ld-regs) 0 #b10110000))))

(define (assemble-or-8-bit-imm a)
  (make-inst 7
             2
             `(#b11110110
               ,a)))

(define (assemble-or arg)
  (match arg
    ((? 8-bit-reg? a)
     (assemble-or-8-bit-reg a))
    ((? 8-bit-imm? a)
     (assemble-or-8-bit-imm a))
    (_
     (error (format #f "Invalid operands to or: ~a" arg)))))

(define (assemble-ret-cond c)
  (make-inst 8
             1
             `(,(make-opcode (lookup c condition-codes) 3 #b11000000))))

(define (assemble-add-hl-reg16 a)
  (make-inst 11
             1
             `(,(make-opcode (lookup a 16-bit-regs) 4 #b00001001))))

(define (assemble-add-reg8 a)
  (make-inst (if (eqv? a '(hl)) 7 4)
             1
             `(,(make-opcode (lookup a ld-regs) 0 #b10000000))))

(define (assemble-add-index-reg16 a b)
  (make-inst 15
             2
             `(,(if (eq? a 'ix) #b11011101 #b11111101)
               ,(make-opcode (lookup b 16-bit-regs) 4 #b00001001))))

(define (assemble-add-imm8 a)
  (make-inst 7
             2
             `(#b11000110
               ,a)))
(define (assemble-add arg)
  (match arg
    (('hl (? 16-bit-reg? a))
     (assemble-add-hl-reg16 a))
    (((? index-reg? a) (? 16-bit-reg? b))
     (assemble-add-index-reg16 a b))
    (('a (? 8-bit-reg? a))
     (assemble-add-reg8 a))
    (('a (? 8-bit-imm? a))
     (assemble-add-imm8 a))
    (_
     (error (format #f "Invalid operands to add: ~a" arg)))))

(define (assemble-sub-reg8 a)
  (make-inst (if (eqv? a '(hl)) 7 4)
             1
             `(,(make-opcode (lookup a ld-regs) 0 #b10010000))))

(define (assemble-sub-imm8 a)
  (make-inst 7
             2
             `(#b11010110
               ,a)))

(define (assemble-sub arg)
  (match arg
    (((? 8-bit-reg? a))
     (assemble-sub-reg8 a))
    (((? 8-bit-imm? a))
     (assemble-sub-imm8 a))
    (_
     (error (format #f "Invalid operands to sub: ~a" arg)))))


(define (assemble-ret arg)
  (match arg
    ((? condition? a)
     (assemble-ret-cond a))
    (_
     (error (format #f "Invalid operands to ret: ~a" arg)))))

(define (assemble-cp-reg8 arg)
  (make-inst (if (eqv? arg '(hl)) 7 4)
             1
             `(,(make-opcode (lookup arg ld-regs) 0 #b10111000))))

(define (assemble-cp-imm8 arg)
  (make-inst 7
             2
             `(#b11111110
               ,arg)))


(define (assemble-cp arg)
  (match arg
    ((? 8-bit-reg? arg)
     (assemble-cp-reg8 arg))
    ((? 8-bit-imm? arg)
     (assemble-cp-imm8 arg))
    (_
     (error (format #f "Invalid operands to cp: ~a" arg)))))


(define (assemble-sbc-hl-reg16 a)
  (make-inst 15
             2
             `(#b11101101
               ,(make-opcode (lookup a 16-bit-regs) 4 #b01000010))))

(define (assemble-sbc arg)
  (match arg
    (('hl (? 16-bit-reg? a))
     (assemble-sbc-hl-reg16 a))
    (_
     (error (format #f "Invalid operands to sbc: ~a" arg)))))


(define (assemble-im arg)
  (match arg
    (0
     (make-inst 8
                2
                '(#b11101101
                  #b01000110)))
    (1
     (make-inst 8
                2
                '(#b11101101
                  #b01010110)))
    (2
     (make-inst 4
                2
                '(#b11101101
                  #b01011110)))))

(define (assemble-sla-reg8 a)
  (make-inst (if (eqv? a '(hl)) 15 8)
             2
             `(#b11001011
               ,(make-opcode (lookup a ld-regs) 0 #b00100000))))

(define (assemble-sla arg)
  (match arg
    ((? 8-bit-reg? a)
     (assemble-sla-reg8 a))
    (_
     (error (format #f "Invalid operands to sla: ~a" arg)))))

(define (assemble-rl-reg8 a)
  (make-inst (if (eqv? a '(hl)) 15 8)
             2
             `(#b11001011
               ,(make-opcode (lookup a ld-regs) 0 #b00010000))))

(define (assemble-rl arg)
  (match arg
    ((? 8-bit-reg? a)
     (assemble-rl-reg8 a))
    (_
     (error (format #f "Invalid operands to rl: ~a" arg)))))


(define (assemble-rr-reg8 a)
  (make-inst (if (eqv? a '(hl)) 15 8)
             2
             `(#b11001011
               ,(make-opcode (lookup a ld-regs) 0 #b00011000))))

(define (assemble-rr arg)
  (match arg
    ((? 8-bit-reg? a)
     (assemble-rr-reg8 a))
    (_
     (error (format #f "Invalid operands to rr: ~a" arg)))))

(define (assemble-djnz simm8)
  (make-inst 10.5
             2
             (let ((simm8 (resolve-jr-label-or-simm simm8)))
               `(#b00010000
                 ;; Follwed by a signed byte, -127 to +127
                 ,simm8))))


(define (assemble-srl-reg8 a)
  (make-inst (if (eqv? a '(hl)) 15 8)
             2
             `(#b11001011
               ,(make-opcode (lookup a ld-regs) 0 #b00111000))))

(define (assemble-srl arg)
  (match arg
    ((? 8-bit-reg? a)
     (assemble-srl-reg8 a))
    (_
     (error (format #f "Invalid operands to srl: ~a" arg)))))

(define (assemble-expr expr)
  ;; Pattern match EXPR against the valid instructions and dispatch to
  ;; the corresponding sub-assembler.
  (match expr
    (((? simple-op? a))
     (assemble-simple a))
    (`(ld ,dest ,src)
     (assemble-ld `(,dest ,src)))
    (`(push ,a)
     (assemble-push a))
    (`(pop ,a)
     (assemble-pop a))
    (`(label ,name)
     (assemble-label name))
    (`(org ,(? 16-bit-imm? a))
     (assemble-org a))
    ;; Some instructions have multiple possible arguments, they should
    ;; be handled by the sub-assembler.
    (`(jp . ,args)
     (assemble-jp args))
    (`(jr . ,args)
     (assemble-jr args))
    (`(call . ,args)
     (assemble-call args))
    (`(bit ,imm3 ,arg)
     (assemble-bit imm3 arg))
    (`(res ,imm3 ,arg)
     (assemble-res imm3 arg))
    (`(set ,imm3 ,arg)
     (assemble-set imm3 arg))
    (`(ret ,arg)
     (assemble-ret arg))
    (`(db ,arg)
     (assemble-db arg))
    (`(dw ,arg)
     (assemble-dw arg))
    (`(out ,dest ,src)
     (assemble-out `(,dest ,src)))
    (`(in ,dest ,src)
     (assemble-in `(,dest ,src)))
    (`(xor ,arg)
     (assemble-xor arg))
    (`(cp ,arg)
     (assemble-cp arg))
    (`(or ,arg)
     (assemble-or arg))
    (`(dec ,arg)
     (assemble-dec arg))
    (`(inc ,arg)
     (assemble-inc arg))
    (`(add . ,args)
     (assemble-add args))
    (`(sub . ,args)
     (assemble-sub args))
    (`(sbc . ,args)
     (assemble-sbc args))
    (`(adc . ,args)
     (assemble-adc args))
    (`(and ,arg)
     (assemble-and arg))
    (`(im ,arg)
     (assemble-im arg))
    (`(sla ,arg)
     (assemble-sla arg))
    (`(rl ,arg)
     (assemble-rl arg))
    (`(rr ,arg)
     (assemble-rr arg))
    (`(djnz ,arg)
     (assemble-djnz arg))
    (`(srl ,arg)
     (assemble-srl arg))
    (_
     (error (format #f "Unknown expression: ~s\n" expr))))
  )

(define *pc* 0)
(define *labels* 0)
(define (reset-pc!)
  (set! *pc* 0))
(define (reset-labels!)
  (set! *labels* '()))

(define (write-bytevector-to-file bv fn)
  (let ((port (open-output-file fn)))
    (put-bytevector port bv)
    (close-port port)))

(define sample-prog
  '((org #x0000)
    (label foo)
    (ld hl #x1234)
    (push hl)
    (ret)

    (call foo)
    (jp end) ;; test look-ahead labels
    (ld a (hl))
    (ldir)
    (pop bc)
    (ld (bc) a)
    (label end)))

(define (flatten l)
  (if (null? l)
      '()
      (append (car l) (flatten (cdr l)))))

(define (assemble-to-binary prog)
  (map num->binary (flatten (assemble-prog prog))))

(define (assemble-to-hex prog)
  (map num->hex (flatten (assemble-prog prog))))

(define (assemble-to-file prog filename)
  (write-bytevector-to-file (u8-list->bytevector (flatten (assemble-prog prog))) filename))

;; (assemble-to-file sample-prog "out.bin")

(define (pass1 exprs)
  ;; Check each instruction for correct syntax and produce code
  ;; generating thunks.  Meanwhile, increment PC accordingly and build
  ;; up labels.
  
  (reset-labels!)
  (reset-pc!)
  (format #t "Pass one...\n")

  ;; Every assembled instruction, or inlined procedure should return a
  ;; value.  A value of () indicates that it will not be included in
  ;; pass 2.
  (filter
   (lambda (x) (not (null? (car x))))
   (map-in-order
    (lambda (expr)
      (if (procedure? expr)
          ;; Evaluate an inlined procedure (could do anything(!)).
          (let ((macro-val (expr)))
            ;; But that procedure has to return () or an instruction
            ;; record.
            (if (not (or (null? macro-val)
                         (inst? macro-val)))
                (error (format #f
                               "Error during pass one: macro did not return an instruction record: instead got ~a.  PC: ~a\n"
                               macro-val
                               *pc*))
                (cons macro-val expr)))

          ;; Assemble a normal instruction.
          (let ((res (assemble-expr expr)))
            (if (inst? res)
                (advance-pc! (inst-length res)))
            (cons res expr))))
    exprs)))

(define (pass2 insts)
  (reset-pc!)
  (format #t "Pass two...\n")
  ;; Force the code generating thunks.  All labels should be resolved by now.
  (map-in-order
   (lambda (x)
     (if (not (inst? (car x)))
         (error (format #f "Error during pass two: not an instruction record: ~a. PC: ~a." (car x) (num->hex *pc*))))
     (advance-pc! (inst-length (car x)))
     (let ((res (gen-inst (car x))))
       ;; Verbose
       (if verbose? (format #t "PC: ~a ~a\n" (num->hex *pc*) (cdr x)))
       res))
   insts)
  )

(define (assemble-prog prog)
  (pass2 (pass1 prog)))


;; Take n elements from a list
(define (take n list)
  (if (or (zero? n) (null? list))
      '()
      (cons (car list)
            (take (1- n) (cdr list)))))

;; For debugging purposes.  Assemble the program and find the
;; instruction that is at the specified byte address.
(define (assemble-find-instr-byte byte prog context)
  (let ((partial-asm (pass1 prog)))
    (let loop ((pc 0)
               (rest-insts partial-asm))
      (cond ((null? rest-insts) (error "Reached end of program before specified byte address."))
            ((>= pc byte)
             (map cdr (take context rest-insts)))
            (else
             (loop (+ pc (inst-length (caar rest-insts)))
                   (cdr rest-insts)))))))

(define (reload-and-assemble-to-file prog file)
  (load "assembler3.scm")
  (assemble-to-file prog file))
