curl -ks https://raw.githubusercontent.com/jondonas/linux-exploit-suggester-2/master/linux-exploit-suggester-2.pl > les2.pl
chmod +x les2.pl
./les2.pl

scp run.sh zaz@192.168.64.6:~

ssh zaz@192.168.64.6

chmod +x run.sh