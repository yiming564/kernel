
; This file is used to load loader.bin in the FAT32/LUFS.

	org 0x7c00
	
; reset registers
	
	mov	ax,	cs
	mov	ds,	ax
	mov	es,	ax
	mov	ss,	ax
	mov	sp,	0x7c00
	
; clear screen

	mov	ax,	0600h
	mov	bx,	0700h
	mov	cx,	0
	mov	dx,	0184fh
	int	10h
	
; set focus (0, 0)

	mov	ax,	0200h
	mov	bx,	0000h
	mov	dx,	0000h
	int	10h
	
; show log message

	mov	ax,	1301h
	mov	bx,	000fh
	mov	dx,	0000h
	mov	cx,	12
	mov	bp,	log
	int	10h
	
; try extend int 13h

	mov ah, 0x41
	mov bx, 0x55aa
	mov dl, 0x80
	int 13h
	
	jc LBANoSupport


; this is only a tmp solution, we will finish the CHS mode soon.

LBANoSupport:
	
	mov	ax,	1301h
	mov	bx,	000fh
	mov	dx,	0000h
	mov	cx,	12
	mov	bp,	log
	int	10h
	jmp $

log:				db	"boot.bin [y]"
LBANoSupport_msg:	db	"LBA Support [n]"
	

	times 446 - ($ - $$) db 0
	dw 0xaa55
