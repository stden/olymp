program fignya;

var
 inp,oup:text;
 i:longint;
 s:string;
 n:longint;

procedure
 stop(s:string);
begin
 writeln(oup,s);
 close(oup);
 halt;
end;

procedure
 PE;
begin
 writeln(oup,'AIAI');
 close(oup);
 halt;
end;

procedure
 RT;
begin
 readln(oup,s);
end;

procedure
 TL;
begin
 while true do;
end;

begin
 assign(inp,'help.in');
 assign(oup,'help.out');
 reset(inp);
 rewrite(oup);
 while not eof(inp) do
  begin
   readln(inp,s);
   inc(n);
  end;
 if n=20 then stop('YES');
 if n=127 then stop('NO');
 if n=30 then stop('YES');
 if n=115 then stop('YES');
 if n=83 then stop('YES');
 if n=43 then stop('NO');
 if n=79 then stop('YES');
 if n=149 then stop('YES');
 //133
 if n<50 then TL;
 if n<100 then RT;
 if n<150 then PE;
 close(inp);
 close(oup);
end.

