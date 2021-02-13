
MAKEFLAGS+= --no-print-directory

ASM = nasm
CC = gcc
CFLAGS = -Wall -O2

IMAGE = ../image
IMAGEMOUNTPATH = ../mnt/

DD = dd
DDFLAGS = conv=notrunc
SUDO = sudo

%.bin: %.asm
	$(ASM) $< -o $@
	
%.o: &.c
	$(CC) $< -o $@ $(CFLAGS)
	
