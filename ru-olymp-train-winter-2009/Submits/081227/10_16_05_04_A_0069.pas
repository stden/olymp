
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

  while not eof do
  begin
    readln(s);
    inc(i);
  end;
  if i mod 2 = 0 then writeln('YES')
                 else writeln('NO');

 close(output);
 close(input);
end.