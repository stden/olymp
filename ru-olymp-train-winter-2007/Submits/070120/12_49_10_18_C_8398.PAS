uses
 sysutils;
var
 ss,s:string;
 p:array[0..10000000]of longint;
 i,j,n,m:longint;

function convert(s:string):string;
var
 ts,ss:string;
 i,j:longint;
begin
 i:=1;
 ss:='';
 while i<=length(s) do
  begin
  ts:='';
  while (s[i] in ['0'..'9'])do
   begin
   ts:=ts+s[i];
   i:=i+1;
   end;
  if ts='' then
   ss:=ss+s[i] 
  else
   for j:=1 to StrToInt(ts) do
    ss:=ss+s[i];
  i:=i+1;
  end;
 convert:=ss;
end;

begin
 assign(input,'rle.in');
 assign(output,'rle.out');
 reset(input);
 rewrite(output);
 readln(s);
 ss:=convert(s);
 p[0]:=0;
 p[1]:=0;
 for i:=2 to length(ss) do
  begin
  j:=p[i-1];
  while (j>0)and(ss[j+1]<>ss[i])do
   j:=p[j];
  if (ss[j+1]=ss[i])then
   p[i]:=j+1
  else
   p[i]:=0;
  end;
 read(m);
 for i:=1 to m do
  begin
  read(n);
  writeln(p[n]);
  end;
 close(input);
 close(output);
end.