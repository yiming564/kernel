
[section .text]

global _start

_start:
	
	mov ax, ss
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov ss, ax
	mov esp, 0x7e00
	
	mov rax, 0x101000
	mov cr3, rax
	
; load GDTR
	
	lgdt 
	
[section .data]

global GDT_Table

GDT_Table:
	
	dq 0x0000000000000000	; 0: NULL descriptor				0x00
	dq 0x0020980000000000	; 1: Kernel	Code	64-bit	Segment	0x08
	dq 0x0000920000000000	; 2: Kernel	Data	64-bit	Segment	0x10
	dq 0x0000000000000000	; 3: User	Code	32-bit	Segment	0x18
	dq 0x0000000000000000	; 4: User	Code	32-bit	Segment	0x20
	dq 0x0020f80000000000	; 5: User	Code	64-bit	Segment	0x28
	dq 0x0000f20000000000	; 6: User	Code	64-bit	Segment	0x30
	dq 0x00cf9a000000ffff	; 7: Kernel	Code	32-bit	Segment	0x38
	dq 0x00cf92000000ffff	; 8: Kernel	Data	32-bit	Segment	0x40
	times 3 dq 
	
GDT_END:
