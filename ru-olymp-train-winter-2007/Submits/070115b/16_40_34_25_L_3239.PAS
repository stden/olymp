program sh;
const tn='substr';
var a,i:longint;
    b:string;
function readch:char;
var ch:char;
begin
 read(ch);
 while (not eof)and(not (ch in [#33..#126])) do read(ch);

 readch:=ch;
end;
var ch:char;
    n,csof:longint;
    s:array[1..10001]of char;
    p:array[1..10001]of longint;
begin
 assign(input,tn+'.in');reset(input);
 assign(output,tn+'.out');rewrite(output);
 n:=0;
 ch:=readch;
 while (ch<>'*') do
 begin
  inc(n);
  s[n]:=ch;
  if n=1 then
  begin
   p[n]:=0
  end else
  begin
   p[n]:=p[n-1];
   while (p[n]>0)and(s[p[n]+1]<>s[n]) do p[n]:=p[p[n]];
   if s[p[n]+1]=s[n] then inc(p[n]);
  end;
  ch:=readch;
 end;
 s[n+1]:=#0;
 ch:=readch;
 csof:=0;
 i:=0;
 while (ch in [#33..#126]) do
 begin
  while (ch<>s[csof+1])and(csof>0) do csof:=p[csof];
  if (ch=s[csof+1]) then inc(csof);
  if csof=n then
   writeln(i-n+2);
  ch:=readch;
  inc(i);
 end;
 close(input);close(output);
end.
