
MAKEFLAGS+= --no-print-directory

ASM = nasm
CC = gcc
CFLAGS = -Wall -O2

%.bin: %.asm
	$(ASM) $< -o $@
	
%.o: &.c
	$(CC) $< -o $@ $(CFLAGS)
	
