# init process substitution using grub

Follow the steps: <br>
1. Turn off UEFI in VM settings (if turned on)
2. Hold Shift key on booting
3. You'll be prompted with `boot:`
4. Press `Tab` to see the list of all the partitions
5. Load the partition with substituted init process:
    ```
    boot: live rw init=/bin/bash
    ```

<hr>

## References
- [Get grub menu](https://askubuntu.com/questions/16042/how-to-get-to-the-grub-menu-at-boot-time) at boot time
- [Why init substitution](https://unix.stackexchange.com/questions/34462/why-does-linux-allow-init-bin-bash) is allowed
- [List](https://kernel.org/doc/Documentation/admin-guide/kernel-parameters.txt) of the kernel parameters