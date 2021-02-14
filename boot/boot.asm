
%include "../include/boot.inc"

; This file is used to load loader.bin in the FAT32.

	org 0x7c00
	
	jmp Label_Start
	nop
	
	db	"mkfs.fat"		; OEM name
	
; BPB Reserved Region

BPB_BytesPerSec		dw	512
BPB_SecPerClus		db	32
BPB_RsvdSecCnt		dw	32
BPB_NumFATs			db	2
BPB_RootEntCnt		dw	0
BPB_TotSec16		dw	0
BPB_Media			db	0xf8
BPB_FATSz16			dw	0
BPB_SecPerTrk		dw	32
BPB_NumHeads		dw	64
BPB_HiddSec32		dd	0x0800
BPB_TotSec32		dd	0x03a97800
BPB_FATSz32			dd	0x3a91
BPB_ExtFlags		dw	0x0000
BPB_FSVer			dw	0
BPB_RootClus		dd	2
BPB_FSInfo			dw	1
BPB_BkBootSec		dw	6
BPB_Reserved		times 12 db 0
BPB_DrvNum			db	0x80
BPB_Reserved1		db	0x01
BPB_BootSig			db	0x29
BPB_VolID			dd	0x0eb2936d
BPB_VolLab			db	"kernel     "
BPB_FilSysType		db	"FAT32   "

Label_Start:
	
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
	
; read FAT32 Directory
	
	mov cx, word [BPB_FATSz32]
	add cx, cx
	add cx, word [BPB_HiddSec32]
	add cx, word [BPB_RsvdSecCnt]
	mov dx, 0
	mov bx, 0x8000
	call _io_block
	cmp ax, 0
	jne ReadFAT32DirectoryError
	
; tmp start

	mov	ax,	1301h
	mov	bx,	000fh
	mov	dx,	0100h
	mov	cx,	0x100
	mov	bp,	0x8000
	int	10h
	
; tmp end
	
; find filename from Directory
	
	mov si, 0x8000
	mov di, TMPFileName
	call _Find_Filename
	cmp ax, 0
	jne LBANoSupport
	jmp $
	

; this is only a tmp solution, we will finish the CHS mode soon.

LBANoSupport:
	
	mov	ax,	1301h
	mov	bx,	0004h
	mov	dx,	0500h
	mov	cx,	15
	mov	bp,	LBANoSupport_msg
	int	10h
	jmp $
	
ReadFAT32DirectoryError:
	
	mov	ax,	1301h
	mov	bx,	0004h
	mov	dx,	0000h
	mov	cx,	18
	mov	bp,	ReadFAT32DirectoryError_msg
	int	10h
	jmp $

; function name: _io_block
; operate failed: AX = 1
; cx = disk LBA number (low 8 bit)
; dx = disk LBA number (mid 8 bit)
; disk transfer limit = 2048GiB
; es = segment
; bx = offset

	
_io_block:
	
; disk LBA number

	push word 00h		; high
	push word 00h		; high
	push word dx		; mid
	push word cx		; low
	
; buffer address

	push word es		; segment
	push word bx		; offset
	
; sector number
; NOTE: only one, if you want to read more, use register instead
; But sometimes it will magically go wrong
	
	push word 1
	
	push word 10h		; 32bit LBA
	
; TODO: make a 64bit LBA _io_block

	mov ah, 42h

;%ifdef floppy
;	mov dl, 00h
;%else
	mov dl, 80h
;%endif
	
	mov si, sp
	int 13h
	
	jc _io_block_error
	add sp, 16
	mov ax, 0
	ret
	
_io_block_error:
	add sp, 16
	mov ax, 1
	ret
	
; function name: _Find_Filename
; operate failed: ax = 1
; si = buffer base
; di = filename

_Find_Filename:
	
	mov cx, 10			; TODO: find the correct number

next_char:
	
	mov ax, [si]
	mov bx, [di]
	cmp ax, bx
	jne not_true
	inc si
	inc di
	
	loop next_char	
	
	mov ax, 0
	ret
	
not_true:

	mov ax, 1
	ret

log:							db	"boot.bin [y]"
LBANoSupport_msg:				db	"LBA Support [n]"
ReadFAT32DirectoryError_msg:	db	"Read Directory [n]"
LoaderPathName:					db	"BOOT       "
LoaderFileName:					db	"LOADER  BIN"
TMPFileName:					db	"kernel     "
	

	times 510 - ($ - $$) db 0
	dw 0xaa55
	
