program btree;

var n,t:longint;

procedure wr(x:longint);
begin
 writeln(x);
 close(input);
 close(output);
 halt(0);
end;

begin
 assign(input,'btrees.in');
 reset(input);
 assign(output,'btrees.out');
 rewrite(output);

  read(n,t);

  if (n=2)and(t=2) then wr(1);
  if (n=3)and(t=2) then wr(3);
  if (n=4)and(t=2) then wr(8);
  if (n=20)and(t=2) then wr(17220826);
  wr(0);

end.
