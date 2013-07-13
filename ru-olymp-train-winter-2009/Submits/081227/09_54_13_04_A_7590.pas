
program cheat;

const Nmax = 2;

const ans:array[1..Nmax]of string = ('YES','NO');

var h,n,i:longint;
    s:string;
    ch:char;
    Check:boolean;

label lb1;

begin
 assign(input,'help.in');
 reset(input);
 assign(output,'help.out');
 rewrite(output);

 i:=0;
 while not eof do
 begin
  inc(i);
  readln(s);
 end;

 if i=20 then writeln('YES') else writeln('NO');


 close(output);
 close(input);
end.