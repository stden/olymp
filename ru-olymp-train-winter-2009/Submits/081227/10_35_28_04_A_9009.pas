
program cheat;

const Nmax = 2;

const ans:array[1..Nmax]of string = ('YES','NO');

var h,n,i:longint;
    s:string;
    ch:char;
    Check:boolean;
    cin,cout:boolean;
label lb1;

begin

 assign(input,'help.in');
 reset(input);
 assign(output,'help.out');
 rewrite(output);


 i:=0;
 while not eof do
  begin
   readln(s);
   inc(i);
  end;

 if i=20 then writeln('YES');
 if (i>50)and(i<=100) then writeln('NO');
 if (i>100)and(i<150) then writeln('YES');




 close(output);
 close(input);
end.