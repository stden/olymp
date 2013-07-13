
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


 check:=false;

  while not eof do
  begin
    readln(s);
    if pos('program',s)<>0 then check:=true;
    inc(i);
  end;

  if not check then writeln('YES') else writeln('NO');
  {if i < 100 then writeln('YES')
                 else writeln('NO');
  }
 close(output);
 close(input);
end.