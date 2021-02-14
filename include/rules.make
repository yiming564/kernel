
MAKEFLAGS+= --no-print-directory

ASM = nasm
CC = gcc
CFLAGS = -Wall -O2

IMAGE = ../image_disk
IMAGEMOUNTPATH = ../mnt/

DD = dd
DDFLAGS = conv=notrunc 2>> ../build.log
SUDO = sudo

%.bin: %.asm
	$(ASM) $< -o $@
	
%.o: &.c
	$(CC) $< -o $@ $(CFLAGS)
	
