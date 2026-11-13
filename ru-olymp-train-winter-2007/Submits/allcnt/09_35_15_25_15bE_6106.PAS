{$Q-,R-,S-}
{$M 40554432,10554432}
program sh;
const tn='expr';
var ch:char;
function expr:dword; forward;
function slg:dword; forward;
function one:dword;
var t:int64;
begin
 read(ch);
 if ch='(' then
 begin
  t:=expr; read(ch);
 end else
 begin
  t:=0;
  while ch in ['0'..'9'] do
  begin
    t:=(t*10+ord(ch)-ord('0')) mod (int64(1 shl 31)*2);
    read(ch);
  end;
 end;
 one:=t mod (int64(1 shl 31)*2);
end;
function slg:dword;
var t,o:int64;
begin
 t:=one;
 while ch in ['*'] do
 begin
  o:=int64(one);
  t:=(t*int64(o));
  t:=t  mod (int64(1 shl 31)*2);
 end;
 slg:=t mod (int64(1 shl 31)*2);
end;
function expr:dword;
var t:int64;
begin
 t:=slg;
  if t<0 then t:=t+(int64(1 shl 31)*2);
 while ch in ['+','-'] do
 begin
  if ch='+' then t:=(t+slg)  mod (int64(1 shl 31)*2) else t:=(t-slg) mod (int64(1 shl 31)*2);
  if t<0 then t:=t+(int64(1 shl 31)*2);
 end;
 expr:=t mod (int64(1 shl 31)*2);
end;

begin
 assign(input,tn+'.in');reset(input);
 assign(output,tn+'.out');rewrite(output);
 writeln(expr);
 close(input);close(output);
end.
