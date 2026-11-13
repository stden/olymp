function sum(p:int64):int64;
var res:int64;
begin
 sum:=trunc(sqrt(2)*p);
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
