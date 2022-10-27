# DirtyCOW exploit (CVE-2016-5195)

Download all scripts inside vm and login as zaz
```bash
scp *.sh zaz@$IP:~

ssh zaz@$IP
```

Run this to scan system for vulnerabilities:
```bash
bash scan.sh
```

Here is the results of the scanning system for vulnerabilities;
```console
  Local Kernel: 3.2.0
  Searching 72 exploits...

  Possible Exploits
  [1] dirty_cow
      CVE-2016-5195
      Source: http://www.exploit-db.com/exploits/40616
  [2] exploit_x
      CVE-2018-14665
      Source: http://www.exploit-db.com/exploits/45697
  [3] msr
      CVE-2013-0268
      Source: http://www.exploit-db.com/exploits/27297
  [4] perf_swevent
      CVE-2013-2094
      Source: http://www.exploit-db.com/exploits/26131
```

Let's use DirtyCOW exploit:
```bash
bash run.sh
```

## References
- [List](https://github.com/dirtycow/dirtycow.github.io/wiki/PoCs) of various implementations
- [exploit-db](https://www.exploit-db.com/exploits/40616) page for DirtyCOW
- [wiki post](https://ru.wikipedia.org/wiki/%D0%A3%D1%8F%D0%B7%D0%B2%D0%B8%D0%BC%D0%BE%D1%81%D1%82%D1%8C_Dirty_COW) about DirtyCOW