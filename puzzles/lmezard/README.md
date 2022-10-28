# lmezard

Install ftp client if not installed
lftp -u lmezard ftp://$IP

```bash
# inside ftp
ls
get fun
get README
```

file fun -> tar arch
mv fun fun.tar
tar -xf fun.tar -> ft_fun

```bash
#!/bin/bash

OUTPUT=output_pcap
FILES_FILE=files.txt

rm -f $FILES_FILE
rm -f $OUTPUT

find $1 -type f > $FILES_FILE

while IFS= read -r file
do
    cat $file >> $OUTPUT
done < $FILES_FILE
```

chmod +x run.sh
./run.sh ft_fun
cat output_pcap | grep main

for getme1-7
find file with function prototype, open it, look at the fileX number
find file with fileX + 1, open it, get value from the return value.

After checking all the function, you end up with the following:
```c
//file8char getme1() {      return 'I';
//file88char getme2() { 	return 'h';
//file518char getme3() {    return 'e';
//file472char getme4() {    return 'a';
//file444char getme5() {    return 'r';
//file435char getme6() {    return 't';
//file503char getme7() {    return 'p';
```

Assemble the password: Iheartpwnage

SHA256(Iheartpwnage) = 330b845f32185747e4f8ca15d40ca59796035c89ea809fb5d30f4da83ecf45a4

ssh laurie@$IP
