# laurie

First of all, we need to look at the README, as it contains the hint to the solutions.
```bash
cat README
Diffuse this bomb!
When you have all the password use it as "thor" user with ssh.

HINT:
P
 2
 b

o
4

NO SPACE IN THE PASSWORD (password is case sensitive).
```

We downloaded bomb binary and decompiled it using [ghidra](https://github.com/NationalSecurityAgency/ghidra).
You can look the whole [source file](./bomb.c)

## Phase 1

The code of this phase is pretty straightforward:
```c
void phase_1(char *arg)
{
    int i = strings_not_equal(arg, "Public speaking is very easy.");
    if (i != 0) {
        explode_bomb();
    }
    return;
}
```
As we see, the argument should be equal to `Public speaking is very easy.`

## Phase 2

This level is easy too. First, six numbers are read in the array[7] (0 element is not used).

```c
void phase_2(char *arg) {
    int i;
    int arr[7];

    read_six_numbers(arg, (int)(arr + 1));
    if (arr[1] != 1) {
        explode_bomb();
    }
    i = 1;
    do {
        if (arr[i + 1] != (i + 1) * arr[i]) {
            explode_bomb();
        }
        i = i + 1;
    } while (i < 6);
    return;
}
```

Then, in the cycle we see, that every element is depending on the previous one.
```
arr[i + 1] = i + 1 * arr[i];
```
From this formula we could understand, that each element equals factorial of current i:
```
1! == 0! == 1 
2! = 1! * 2 = 2
3! = 2! * 3 = 2 * 3 = 6
4! = 3! * 4 = 6 * 4 = 24
5! = 4! * 5 = 24 * 5 = 120
6! = 5! * 6 = 120 * 6 = 720
```

So, the solution here is string that contains list of factorials: `1 2 6 24 120 720`

## Phase 3

As we can understand from the hint, the second char should be `b`.
Let's watch to related cases:

```c
void phase_3(char *arg) {
    int i;
    uchar c;
    uint n1;
    uchar c2;
    int n2;

    i = sscanf(arg, "%d %c %d", (int *)&n1, &c2, &n2);
    if (i < 3) {
        explode_bomb();
    }
    switch (n1) {
        case 1:
            c = 'b';
            if (n2 != 0xd6) {
                explode_bomb();
            }
            break;
        case 2:
            c = 'b';
            if (n2 != 0x2f3) {
                explode_bomb();
            }
            break;
        case 7:
            c = 'b';
            if (n2 != 0x20c) {
                explode_bomb();
            }
            break;
    }
    if (c != n2) {
        explode_bomb();
    }
    return;
}
```

Possible answers:
```
1 b 214
2 b 755
7 b 524
```

## Phase 4

Here's the source code of this phase:
```c
int func4(int arg) {
    int i, j;

    if (arg < 2) {
        j = 1;
    } else {
        j = func4(arg - 2) + func4(arg - 1);
    }
    return j;
}

void phase_4(char *arg) {
    int num;

    int i = sscanf(arg, "%d", &num);
    if ((i != 1) || (num < 1)) {
        explode_bomb();
    }
    i = func4(num);
    if (i != 0x37) {
        explode_bomb();
    }
    return;
}
```

We see, that a number passed to the function and the result should be `0x37 or 55` to pass this stage. <br>

`func4` calculates fibonacci sequence for the given `arg` (arr[i] = arr[i-1] + arr[i-2]). <br>
We need result to be `55`, so the index we should pass is:
```bash
  0 1 2 3 4 5  6  7  8  9
0 1 1 2 3 5 8 13 21 34 55 
```

Answer: `9`

## Phase 5

```c
void phase_5(char *arg) {
    int i;
    char arr[6];

    i = string_length(arg);
    if (i != 6) {
        explode_bomb();
    }

    i = 0;
    do {
        arr[i] = "isrveawhobpnutfg"[(char)(arg[i] & 0xf)];
        i = i + 1;
    } while (i < 6);

    i = strings_not_equal(arr, "giants");
    if (i != 0) {
        explode_bomb();
    }
    return;
}
```

As we can see, the result string should be equal to `giants`. <br>
This string is formed from another string using the string we pass to get indices. <br>
The index is getting from the low bits of every char.

Let's write all this into the table:

<table>
    <thead>
        <tr>
            <th>char</th>
            <th>index</th>
            <th>bin index</th>
            <th colspan="4">ASCII chars which low bits matches bin index</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>g</td>
            <td>15</td>
            <td>1111</td>
            <td>o</td>
            <td></td>
            <td></td>
            <td></td>          
        </tr>
        <tr>
            <td>i</td>
            <td>0</td>
            <td>0000</td>
            <td>p</td>
            <td>P</td>
            <td>0</td>
            <td></td>
        </tr>
        <tr>
            <td>a</td>
            <td>5</td>
            <td>0101</td>
            <td>e</td>
            <td>E</td>
            <td>u</td>
            <td>U</td>
        </tr>
        <tr>
            <td>n</td>
            <td>11</td>
            <td>1011</td>
            <td>k</td>
            <td>K</td>
            <td>;</td>
            <td></td>
        </tr>
        <tr>
            <td>t</td>
            <td>13</td>
            <td>1101</td>
            <td>m</td>
            <td>M</td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>s</td>
            <td>1</td>
            <td>0001</td>
            <td>q</td>
            <td>Q</td>
            <td>1</td>
            <td>A</td>
        </tr>
    </tbody>
</table>

All the combinations work to pass the stage, but only one used for password. <br>

Answer: `opekmq`

## Phase 6

We didn't want to read all the src code and understand it, so we just brute force it.
This phase takes a six unique numbers from `1` to `6` and the first one is `4`, so it perfectly matches the brute force exploit.

## Addition

There are some unused functions in binary that creates socket and sending message, but I could not make up something with them.

```bash
$ cat instr

Public speaking is very easy.
1 2 6 24 120 720
1 b 214
9
opekmq
4 2 6 3 1 5
```

The pre-last and pre-pre-last element should be chagned according to the [forum](https://stackoverflow.com/c/42network/questions/664) <br>
I really do not understand why them do not fix that...

So we finally can move forward...
```bash
Password: Publicspeakingisveryeasy.126241207201b2149opekmq426135

ssh thor@$IP
```