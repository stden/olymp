{$N+}
var d,rd,ld:extended;
    rez,t,l,r,q:longint;
begin
  assign(input,'digitsum1.in');
  reset(input);
  assign(output,'digitsum1.out');
  rewrite(output);
  readln(t);
  d:=sqrt(2);

  for q:=1 to t do begin
     readln(l,r);
     ld:=d*(l-1);
     rd:=d*r;
 {    ld:=trunc(ld);
     rd:=trunc(rd); }
     rez:=trunc(rd)-trunc(ld);
     writeln(rez);
  end;
  close(input);
  close(output);
end.

