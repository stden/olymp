program cheat;

var L,R,N,i,res:longint;

begin
 assign(input,'digitsum.in');
 reset(input);
 assign(output,'digitsum.out');
 rewrite(output);


 read(n);

 for i:=1 to n do
  begin
   readln(L,R);
   res:= trunc(sqrt(2)*R)-trunc(sqrt(2)*(L-1));
   writeln(res);
  end;

 close(input);
 close(output);
end.
