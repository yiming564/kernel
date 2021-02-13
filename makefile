
MAKEFLAGS += --no-print-directory

IMAGE = image
IMAGEMOUNTPATH = mnt/

DD = dd
DDFLAGS = conv=notrunc
SUDO = sudo

.PHONY: clean clean_backup image mount umount image_main
OBJS = boot/boot.bin boot/loader.bin

all:
	@$(MAKE) -C boot
	
image:
	$(DD) if=.refresh of=$(IMAGE) bs=1 count=1008 seek=1004 $(DDFLAGS)
	@$(MAKE) -C . mount
	-@$(MAKE) -C . image_main
	@$(MAKE) -C . umount
	
mount:
	$(SUDO) mount $(IMAGE) $(IMAGEMOUNTPATH) -t vfat -o loop
	
umount:
	$(SUDO) umount $(IMAGEMOUNTPATH)
	
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
	
