.data

msg:
    .ascii      "Hello, world!\n"

.text

.global _start
_start:
    mov     %r0, $1
    ldr     %r1, =msg
    mov     %r2, $14
    mov     %r7, $4
    swi     $0

    mov     %r0, $0
    mov     %r7, $1
    swi     $0