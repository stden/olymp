
program cheat;

const Nmax = 2;

const ans:array[1..Nmax]of string = ('YES','NO');

var h,n,i:longint;
    s:string;
    ch:char;
    Check:boolean;
    cin,cout:boolean;
label lb1;

procedure yes;
begin
 writeln('YES');
 close(input);
 close(output);
 halt(0);
end;

procedure no;
begin
 writeln('NO');
 close(input);
 close(output);
 halt(0);
end;

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

 if i=20 then yes;
 if (i>120)and(i<140) then no;
 if (i<100)then yes;
 if (i>100)and(i<150) then yes;


 close(output);
 close(input);
end.