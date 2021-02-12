
MAKEFLAGS+= --no-print-directory

.PHONY: clean clean_backup image

all:
	@$(MAKE) -C boot
	
image:
	
	
	
clean:
	@$(MAKE) -C . clean_backup
	@$(MAKE) -C boot clean
	@$(MAKE) -C etc clean
	@$(MAKE) -C include clean
	rm -rf *.bin *.o *.obj
	
clean_backup:
	@$(MAKE) -C boot clean_backup
	@$(MAKE) -C etc clean_backup
	@$(MAKE) -C include clean_backup
	rm -rf *~ *.swp *.swo *.swa image
	
push:
	./.git.sh
	
