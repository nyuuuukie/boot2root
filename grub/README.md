init process substitution through grub loader
https://askubuntu.com/questions/16042/how-to-get-to-the-grub-menu-at-boot-time
https://unix.stackexchange.com/questions/34462/why-does-linux-allow-init-bin-bash
https://kernel.org/doc/Documentation/admin-guide/kernel-parameters.txt

Turn off UEFI in VM settings (if turned on)
Hold Shift key on booting
You'll be prompted with `boot:`
Press `Tab` to see the list of all the partitions
Load the partition with substituted init process
`boot: live rw init=/bin/bash`