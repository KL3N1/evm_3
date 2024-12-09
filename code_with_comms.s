JMP START

PA:  .ds 1	; Pointer MA
PB:  .ds 1	; Pointer MB
N:  .ds 1	; Amount of elements
.org 10		; Отступ

MA: .ds 10	; Выделяем 16 байтов под массив А
MB: .ds 0f	; Выделяем 15 байтов под массив B

START: IN 0	; Enter N

    STOR a, N	; N = a
    CMI a, 0	; N < 0?
    JNP exit
    CMI a, 10	; N > 16?
    JP exit

    XCHG	; a <=> b
    DVI a, 02	; N mod 2 = 0?
    CMI a, 0
    JNZ exit

    MVI b, MA	; b = address MA
    LOAD a, N	; a = N
    nexta: PUSH a ; a -> stack
    IN 1	; Filling array A
    STOR a, 00(b)
    ADI b, 01	; i+1, (A[i])
    POP a	; stack -> a
    LOOP a, nexta

    MVI a, MB	; a = address MB
    STOR a, PB	; PB = address MB
    MVI b, MA	; b = address MA
    STOR b, PA	; PA = address MA
    LOAD a, N	; a = N
    SBI a, 01	; a = N-1

    nextb: PUSH a	; a -> stack
    LOAD a, 00(b)	; a = A(n)
    ADI b, 01		; n = n+1
    LOAD b, 00(b)	; b = A(n+1)
    MUR a, a		; b = a*b
    MUI a, 01		; Расширяем знак
    DVI a, 02		; b = A(n)*A(n+1)/2
    LOAD a, PB		; a = B(n)
    STOR b, 00(a)	; B(n) = b = A(n)*A(n+1)/2
    ADI a, 01		; increase address of B(n) to B(n+1)
    STOR a, PB		; save address B(n+1)

    POP a		; stack -> a = N - 1
    LOAD b, PA		; b = address MA
    ADI b, 01		; increase address of A(n) to A(n+1)
    STOR b, PA		; save address A(n+1)
    LOOP a, nextb

exit: STOP
.END
