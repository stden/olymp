function sum(p:int64):int64;
var res:int64;
begin
 res:=(p div 5)*7;
 if p mod 5 >= 0 then res:=res+1;
 if p mod 5 >= 1 then res:=res+1;
 if p mod 5 >= 2 then res:=res+2;
 if p mod 5 >= 3 then res:=res+1;
 if p mod 5 >= 4 then res:=res+2;
 sum:=res;
end;
var t,l,r,i:int64;
begin
 assign(input,'digitsum.in');
 assign(output,'digitsum.out');
 reset(input); rewrite(output);
 readln(t);
 i:=1;
 while i<= t do begin
  readln(l,r);
  writeln(sum(r)-sum(l-1));
  i:=i+1;
 end;
 close(input); close(output);
end.
