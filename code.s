calculateElapsedTime:
        push    rbp
        mov     rbp, rsp
        mov     rax, rsi
        mov     r8, rdi
        mov     rsi, r8
        mov     rdi, r9
        mov     rdi, rax
        mov     QWORD PTR [rbp-32], rsi
        mov     QWORD PTR [rbp-24], rdi
        mov     QWORD PTR [rbp-48], rdx
        mov     QWORD PTR [rbp-40], rcx
        mov     rax, QWORD PTR [rbp-32]
        mov     QWORD PTR [rbp-8], rax
        mov     rax, QWORD PTR [rbp-8]
        imul    rax, rax, 1000000000
        mov     QWORD PTR [rbp-8], rax
        mov     rax, QWORD PTR [rbp-24]
        add     QWORD PTR [rbp-8], rax
        mov     rax, QWORD PTR [rbp-48]
        mov     QWORD PTR [rbp-16], rax
        mov     rax, QWORD PTR [rbp-16]
        imul    rax, rax, 1000000000
        mov     QWORD PTR [rbp-16], rax
        mov     rax, QWORD PTR [rbp-40]
        add     QWORD PTR [rbp-16], rax
        mov     rax, QWORD PTR [rbp-16]
        sub     rax, QWORD PTR [rbp-8]
        pop     rbp
        ret
calculateFactorial:
        push    rbp
        mov     rbp, rsp
        mov     DWORD PTR [rbp-20], edi
        movsd   xmm0, QWORD PTR .LC0[rip]
        movsd   QWORD PTR [rbp-8], xmm0
        mov     DWORD PTR [rbp-12], 1
        jmp     .L4
.L5:
        pxor    xmm0, xmm0
        cvtsi2sd        xmm0, DWORD PTR [rbp-12]
        movsd   xmm1, QWORD PTR [rbp-8]
        mulsd   xmm0, xmm1
        movsd   QWORD PTR [rbp-8], xmm0
        add     DWORD PTR [rbp-12], 1
.L4:
        mov     eax, DWORD PTR [rbp-12]
        cmp     eax, DWORD PTR [rbp-20]
        jle     .L5
        movsd   xmm0, QWORD PTR [rbp-8]
        movq    rax, xmm0
        movq    xmm0, rax
        pop     rbp
        ret
calculatePower:
        push    rbp
        mov     rbp, rsp
        movsd   QWORD PTR [rbp-24], xmm0
        mov     DWORD PTR [rbp-28], edi
        movsd   xmm0, QWORD PTR .LC0[rip]
        movsd   QWORD PTR [rbp-8], xmm0
        mov     DWORD PTR [rbp-12], 0
        jmp     .L8
.L9:
        movsd   xmm0, QWORD PTR [rbp-8]
        mulsd   xmm0, QWORD PTR [rbp-24]
        movsd   QWORD PTR [rbp-8], xmm0
        add     DWORD PTR [rbp-12], 1
.L8:
        mov     eax, DWORD PTR [rbp-12]
        cmp     eax, DWORD PTR [rbp-28]
        jl      .L9
        movsd   xmm0, QWORD PTR [rbp-8]
        movq    rax, xmm0
        movq    xmm0, rax
        pop     rbp
        ret
calculateE:
        push    rbp
        mov     rbp, rsp
        push    rbx
        sub     rsp, 40
        movsd   QWORD PTR [rbp-48], xmm0
        pxor    xmm0, xmm0
        movsd   QWORD PTR [rbp-16], xmm0
        mov     DWORD PTR [rbp-20], 0
        movsd   xmm0, QWORD PTR .LC0[rip]
        movsd   QWORD PTR [rbp-32], xmm0
        jmp     .L12
.L13:
        mov     edx, DWORD PTR [rbp-20]
        mov     rax, QWORD PTR [rbp-48]
        mov     edi, edx
        movq    xmm0, rax
        call    calculatePower
        movq    rbx, xmm0
        mov     eax, DWORD PTR [rbp-20]
        mov     edi, eax
        call    calculateFactorial
        movapd  xmm1, xmm0
        movq    xmm0, rbx
        divsd   xmm0, xmm1
        movsd   QWORD PTR [rbp-32], xmm0
        movsd   xmm0, QWORD PTR [rbp-16]
        addsd   xmm0, QWORD PTR [rbp-32]
        movsd   QWORD PTR [rbp-16], xmm0
        add     DWORD PTR [rbp-20], 1
.L12:
        movsd   xmm0, QWORD PTR [rbp-32]
        comisd  xmm0, QWORD PTR .LC2[rip]
        jnb     .L13
        movsd   xmm0, QWORD PTR [rbp-16]
        movq    rax, xmm0
        movq    xmm0, rax
        mov     rbx, QWORD PTR [rbp-8]
        leave
        ret
.LC3:
        .string "x: "
.LC4:
        .string "%lf"
.LC5:
        .string "r"
.LC8:
        .string "Your random number: %lf\n"
.LC9:
        .string "x < 0.0.\n Exit "
.LC10:
        .string "w"
.LC11:
        .string "%lf\n"
.LC12:
        .string "Result: %lf\n"
main:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 96
        mov     DWORD PTR [rbp-84], edi
        mov     QWORD PTR [rbp-96], rsi
        cmp     DWORD PTR [rbp-84], 1
        jne     .L16
        mov     edi, OFFSET FLAT:.LC3
        mov     eax, 0
        call    printf
        lea     rax, [rbp-72]
        mov     rsi, rax
        mov     edi, OFFSET FLAT:.LC4
        mov     eax, 0
        call    __isoc99_scanf
        jmp     .L17
.L16:
        cmp     DWORD PTR [rbp-84], 2
        jne     .L18
        mov     rax, QWORD PTR [rbp-96]
        add     rax, 8
        mov     rax, QWORD PTR [rax]
        mov     esi, OFFSET FLAT:.LC5
        mov     rdi, rax
        call    fopen
        mov     QWORD PTR [rbp-16], rax
        lea     rdx, [rbp-72]
        mov     rax, QWORD PTR [rbp-16]
        mov     esi, OFFSET FLAT:.LC4
        mov     rdi, rax
        mov     eax, 0
        call    __isoc99_fscanf
        jmp     .L17
.L18:
        cmp     DWORD PTR [rbp-84], 3
        jne     .L19
        mov     rax, QWORD PTR [rbp-96]
        add     rax, 8
        mov     rax, QWORD PTR [rax]
        mov     rdi, rax
        call    atoi
        mov     edi, eax
        call    srand
        call    rand
        pxor    xmm0, xmm0
        cvtsi2sd        xmm0, eax
        movsd   xmm2, QWORD PTR .LC6[rip]
        movapd  xmm1, xmm0
        divsd   xmm1, xmm2
        movsd   xmm0, QWORD PTR .LC7[rip]
        mulsd   xmm0, xmm1
        movsd   QWORD PTR [rbp-72], xmm0
        mov     rax, QWORD PTR [rbp-72]
        movq    xmm0, rax
        mov     edi, OFFSET FLAT:.LC8
        mov     eax, 1
        call    printf
        jmp     .L17
.L19:
        mov     eax, -1
        jmp     .L26
.L17:
        movsd   xmm1, QWORD PTR [rbp-72]
        pxor    xmm0, xmm0
        comisd  xmm0, xmm1
        jbe     .L28
        mov     edi, OFFSET FLAT:.LC9
        call    puts
        mov     eax, 0
        jmp     .L26
.L28:
        lea     rax, [rbp-48]
        mov     rsi, rax
        mov     edi, 1
        call    clock_gettime
        mov     DWORD PTR [rbp-4], 0
        jmp     .L23
.L24:
        mov     rax, QWORD PTR [rbp-72]
        movq    xmm0, rax
        call    calculateE
        movq    rax, xmm0
        mov     QWORD PTR [rbp-72], rax
        add     DWORD PTR [rbp-4], 1
.L23:
        cmp     DWORD PTR [rbp-4], 9999
        jle     .L24
        lea     rax, [rbp-64]
        mov     rsi, rax
        mov     edi, 1
        call    clock_gettime
        cmp     DWORD PTR [rbp-84], 2
        jne     .L25
        mov     rax, QWORD PTR [rbp-96]
        add     rax, 16
        mov     rax, QWORD PTR [rax]
        mov     esi, OFFSET FLAT:.LC10
        mov     rdi, rax
        call    fopen
        mov     QWORD PTR [rbp-24], rax
        mov     rdx, QWORD PTR [rbp-72]
        mov     rax, QWORD PTR [rbp-24]
        movq    xmm0, rdx
        mov     esi, OFFSET FLAT:.LC11
        mov     rdi, rax
        mov     eax, 1
        call    fprintf
        mov     eax, 0
        jmp     .L26
.L25:
        mov     rax, QWORD PTR [rbp-72]
        movq    xmm0, rax
        mov     edi, OFFSET FLAT:.LC12
        mov     eax, 1
        call    printf
        mov     eax, 0
.L26:
        leave
        ret
.LC0:
        .long   0
        .long   1072693248
.LC2:
        .long   -1717986918
        .long   1068079513
.LC6:
        .long   -4194304
        .long   1105199103
.LC7:
        .long   0
        .long   1079574528