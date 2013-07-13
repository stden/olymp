
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

 cin:=false;
 cout:=false;
 while not eof do
  begin
   readln(s);
   if pos('close(input);',s)<>0 then cin:=true;
   if pos('close(output);',s)<>0 then cout:=true;
  end;

  if (cin)and(cout) then writeln('NO') else writeln('YES');




 close(output);
 close(input);
end.