
include ../include/rules.make

.PHONY: clean clean_backup
	
clean_backup:
	rm -rf *~ *.swp *.swo *.swa *.log
	
clean: 
	@$(MAKE) -C . clean_backup
	rm -rf *.bin *.o *.obj
