
include ../include/rules.make

.PHONY: clean clean_backup

OBJS = kernel.bin

all: $(OBJS)

image_main: kernel.bin
	cp kernel.bin /mnt
	
clean_backup:
	rm -rf *~ *.swp *.swo *.swa *.log
	
clean: 
	@$(MAKE) -C . clean_backup
	rm -rf *.bin *.o *.obj
