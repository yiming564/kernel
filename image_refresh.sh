#!/bin/bash

touch image
sudo dd if=/dev/sdb1 of=image bs=1024k count=32
# mkfs.vfat -F 32 image -n "kernel"

