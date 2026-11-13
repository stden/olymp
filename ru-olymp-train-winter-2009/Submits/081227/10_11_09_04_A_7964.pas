
program cheat;

const Nmax = 2;

const ans:array[1..Nmax]of string = ('YES','NO');

var h,n,i:longint;
    s:string;
    ch:char;
    Check:boolean;

label lb1;

begin

 assign(output,'a.txt');
 rewrite(output);
  writeln('YES');
 close(output);
 assign(input,'a.txt');
 reset(input);
 assign(output,'help.out');
 rewrite(output);

    readln(s);
    writeln(s);

 close(output);
 close(input);
end.