//
program sh;
const tsk='optimum';
var rs,n,m,p,i:longint;
begin
 assign(input,tsk+'.in');assign(output,tsk+'.out');
 reset(input);rewrite(output);
 readln(n,m,p);
 if m<n-1 then rs:=0 else
 begin
  rs:=1;
  for i:=1 to m-n+1 do rs:=(rs*m) mod p;
 end;
 writeln(rs);
 close(input);close(output);
end.
