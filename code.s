JMP START

PA:  .ds 1
PB:  .ds 1
N:  .ds 1
.org 10 

MA: .ds 10
MB: .ds 0f

START: IN 0

    STOR a, N
    CMI a, 0
    JNP exit
    CMI a, 10
    JP exit

    XCHG
    DVI a, 02
    CMI a, 0
    JNZ exit

    MVI b, MA
    LOAD a, N
    nexta: PUSH a
    IN 1
    STOR a, 00(b)
    ADI b, 01
    POP a
    LOOP a, nexta

    MVI a, MB
    STOR a, PB
    MVI b, MA
    STOR b, PA
    LOAD a, N
    SBI a, 01

    nextb: PUSH a
    LOAD a, 00(b)	; A(n)
    ADI b, 01
    LOAD b, 00(b)	; A(n+1)
    MUR a, a
    MUI a, 01
    DVI a, 02
    LOAD a, PB
    STOR b, 00(a)
    ADI a, 01
    STOR a, PB

    POP a
    LOAD b, PA
    ADI b, 01
    STOR b, PA
    LOOP a, nextb

exit: STOP
.END
