
.PHONY: clean clean_backup

all:
	@$(MAKE) -C boot
	
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
	rm -rf *~ *.swp *.swo *.swa
	
push:
	./git.sh
	
