uses math;


type integer=longint;

var
 cc,res,n,i:integer;
 r,c,a,w:array[1..200] of integer;


begin
 assign(input,'system.in'); reset(input);
 assign(output,'system.out'); rewrite(output);
 readln(n);
 for i:=1 to n do
  readln(r[i],c[i],a[i],w[i]);

 for i:=1 to n do
  if r[i]=1 then inc(cc,w[i]);
 res:=min(w[1],cc);
 writeln(res);
end.
