
## Prepare existing Ubuntu for chroot from live cd
mount /dev/sda5 /mnt/
mount /dev/sda1 /mnt/boot
mount /dev/sda6 /mnt/home

mount --bind /dev /mnt/dev
mount --bind /proc /mnt/proc 
mount --bind /sys /mnt/sys

grub-install --boot-directory=/boot/ /dev/sda
