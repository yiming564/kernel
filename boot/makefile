
include ../include/rules.make

OBJS = boot.bin loader.bin
.PHONY: clean clean_backup

all: $(OBJS)
	
image_main:
	@$(MAKE) -C . 
	$(DD) if=boot.bin of=$(IMAGE) bs=512 count=1 $(DDFLAGS)
	$(SUDO) cp loader.bin $(IMAGEMOUNTPATH)
	
clean_backup:
	rm -rf *~ *.swp *.swo *.swa
	
clean: 
	@$(MAKE) -C . clean_backup
	rm -rf *.bin *.o *.obj
	
