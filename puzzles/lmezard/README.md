# lmezard

! Install ftp client if not installed (I used `lftp`)

```bash
lftp -u lmezard ftp://$IP

# inside ftp
> ls
> get fun
> cat README
```

From the README we understand, that we'll get the password for `laurie` after compeleting this stage.

File `fun` turned out to be a tar-archive, and extracted data contained folder with many files.

```bash
$ file fun
fun: POSIX tar archive (GNU)
...
$ tar -xf fun
...
$ ls
README  ft_fun  fun
```

Some `getme` function turned out to be separated from their implementations. <br>

Let's get the source from all the files to a single file:
run.sh:
```bash
# this renames files according to their numbers
for i in $(ls); do mv $i $(cat $i | grep file | tr -d "//file"); done;

# this writes all the src into one file
for i in $(ls -1v); do cat $i >> ../output; done;
```

Then, we can simply inspect result file:
```bash
cat output | grep "getme7" -A 2
```

After checking all the function, you end up with the following:
```c
//file8char   getme1() {    return 'I';
//file88char  getme2() { 	return 'h';
//file518char getme3() {    return 'e';
//file472char getme4() {    return 'a';
//file444char getme5() {    return 'r';
//file435char getme6() {    return 't';
//file503char getme7() {    return 'p';
```

Assemble the password: `Iheartpwnage`

After that we need to remember the line from `BJPCP.pcap`:
```c
...
printf("Now SHA-256 it and submit");
...
```

So, let's hash it using SHA256:
```bash
$ echo -n "Iheartpwnage" | shasum -a 256
330b845f32185747e4f8ca15d40ca59796035c89ea809fb5d30f4da83ecf45a4  -

$ ssh laurie@$IP
```

