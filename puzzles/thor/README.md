# thor

There is a file `turtle` in the home directory, related to the turtle module from python.<br>
It contains instructions that should be converted to turtle methods.

We write simple [gen.py](./gen.py) script that parses `turtle` into python script with turtle methods.

Then, we used [turtle printer](https://www.pythonsandbox.com/turtle) to see the picture.

The turtle draws word `SLASH`, so this is our result.

According, to the turtle file, we need to calculate message digest (MD5) of the result:
```bash
echo -n "SLASH" | openssl md5
(stdin)= 646da671ca01bb5d84dbb5fb2238dc8e
```

Moving to the last...
```bash
ssh zaz@$IP
```