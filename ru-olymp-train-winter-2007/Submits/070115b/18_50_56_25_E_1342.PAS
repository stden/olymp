{$Q-,R-}
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
    t:=t*10+ord(ch)-ord('0');
    read(ch);
  end;
 end;
 one:=t;
end;
function slg:dword;
var t:int64;
begin
 t:=one;
 while ch in ['*'] do t:=(t*one) mod (int64(1 shl 31)*2);
 slg:=t;
end;
function expr:dword;
var t:int64;
begin
 t:=slg;
 while ch in ['+','-'] do
  if ch='+' then t:=(t+slg)  mod (int64(1 shl 31)*2) else t:=(t-slg) mod (int64(1 shl 31)*2);
 expr:=t mod (int64(1 shl 31)*2);
end;

begin
 assign(input,tn+'.in');reset(input);
 assign(output,tn+'.out');rewrite(output);
 writeln(expr);
 close(input);close(output);
end.
