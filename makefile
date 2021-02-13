
MAKEFLAGS += --no-print-directory

.PHONY: clean clean_backup image
OBJS = boot/boot.bin boot/loader.bin

all:
	@$(MAKE) -C boot
	
image:
	dd if=.refresh of=image bs=1 count=1008 seek=1004 conv=notrunc
	@$(MAKE) -C . mount
	-@$(MAKE) -C . image_main
	@$(MAKE) -C . umount
	
mount:
	sudo mount image mnt/ -t vfat -o loop
	
umount:
	sudo umount mnt/
	
image_main: .refresh
	@$(MAKE) -C boot image_main
	
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
	./.git.sh
	
