{$M 16000000}
var
 S:array[-100001..1100001] of extended;
 n,x,p,x1,x2,i,j:longint;
 f:extended;
 ch:char;

procedure add;
begin
 f:=0.5;
 for i:=x - p to x-1 do begin
  S[i]:=S[i] + f;
  f:=f+1;
 end;
 for i:=x to x+p-1 do begin
  f:=f-1;
  S[i]:=S[i] + f;
 end;
end;

procedure query(l,r:longint);
 begin
  f:=0;
  for i:=l to r do
   f:=f+S[i];
 end;

begin
 fillchar(s,sizeof(s),0);
 assign(input,'geology.in');
 reset(input);
 assign(output,'geology.out');
 rewrite(output);
 readln(n);
 for j:=1 to n do begin
  read(ch);
  if UpCase(ch)='A' then begin
   while ch<>' ' do
    read(ch);
   readln(x, p);
   add;
  end else begin
   while ch<>' ' do
    read(ch);
   readln(x1,x2);
   if x1<x2 then
    query(x1, x2 - 1)
   else
    query(x2, x1 - 1);
   writeln(f:0:3);
  end;
 end;
 close(input);
 close(output);
end.
