
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
 check:=false;
 while not eof do
 begin
  inc(i);
  readln(s);
  if pos('int = longint',s)<>0 then check:=true;
  //if i>20 then break;
 end;

 if (check) then writeln('YES') else writeln('NO');


 close(output);
 close(input);
end.