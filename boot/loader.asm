
	org 0x9000
	
	mov	ax,	cs
	mov	ds,	ax
	mov	es,	ax
	mov	ss,	ax
	mov	sp,	0x9000
	
	mov	ax,	1301h
	mov	bx,	000fh
	mov	dx,	0000h
	mov	cx,	12
	mov	bp,	log
	int	10h
	
	jmp $
	
log:							db	"loader.bin [y]"

