
MAKEFLAGS += --no-print-directory

IMAGE = image_disk
IMAGEMOUNTPATH = mnt/

DD = dd
DDFLAGS = conv=notrunc 2>> build.log
SUDO = sudo

.PHONY: clean clean_backup image mount umount image_main
OBJS = boot/boot.bin boot/loader.bin

all:
	@$(MAKE) -C boot
	
install:
	@$(MAKE) -C . image
	$(SUDO) $(DD) if=$(IMAGE) of=/dev/sdb1 bs=1024k count=32 $(DDFLAGS)
	
image:
	@./get_time.sh
	@$(MAKE) -C . image_disk
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
	
image_disk:
	touch $(IMAGE)
	$(SUDO) $(DD) if=/dev/sdb1 of=$(IMAGE) bs=1024k count=32
	
clean:
	@$(MAKE) -C . clean_backup
	@$(MAKE) -C boot clean
	@$(MAKE) -C etc clean
	@$(MAKE) -C include clean
	@$(MAKE) -C kernel clean
	rm -rf *.bin *.o *.obj
	
clean_backup:
	@$(MAKE) -C boot clean_backup
	@$(MAKE) -C etc clean_backup
	@$(MAKE) -C include clean_backup
	@$(MAKE) -C kernel clean_backup
	rm -rf *~ *.swp *.swo *.swa *.log
	
push:
	./.git.sh
	
