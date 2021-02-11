
include ../include/rules.make

OBJS = boot.bin loader.bin
.PHONY: clean clean_backup

all: $(OBJS)
	
clean_backup:
	rm -rf *~ *.swp *.swo *.swa
	
clean: 
	$(MAKE) -C . clean_backup
	rm -rf *.bin *.o *.obj
	
