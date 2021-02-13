
include ../include/rules.make

OBJS = boot.bin loader.bin
.PHONY: clean clean_backup

all: $(OBJS)
	
image_main:
	$(MAKE) -C . 
	dd if=boot.bin of=../image bs=512 count=1 conv=notrunc
	sudo cp loader.bin ../mnt/
	
clean_backup:
	rm -rf *~ *.swp *.swo *.swa
	
clean: 
	@$(MAKE) -C . clean_backup
	rm -rf *.bin *.o *.obj
	
