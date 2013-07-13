type num = record
 a:array[1..200] of longint;
 n:longint;
end;
procedure readnum(var r:num);
var c:char;
begin
 r.n:=0;
 while not eoln(input) do begin read(c); inc(r.n); r.a[r.n]:=byte(c)-48; end;
 readln;
end;
procedure writenum(var r:num);
var i:longint;
begin
 for i:=1 to r.n do write(r.a[i]);
 writeln;
end;
procedure turbo(var r:num);
var i,k:longint;
begin
 for i:=1 to r.n div 2 do begin
  k:=r.a[i];
  r.a[i]:=r.a[r.n-i+1];
  r.a[r.n-i+1]:=k;
 end;
end;
procedure add1(var r:num);
var i:longint;
begin
 turbo(r);
 i:=1;
 while(i<=r.n) and (r.a[i]=9) do begin r.a[i]:=0; inc(i); end;
 if i>r.n then begin r.a[i]:=1; inc(r.n); end
 else inc(r.a[i]);
 turbo(r);
end;

function max(a,b:longint):longint;
begin
 if a>b then max:=a else max:=b;
end;

procedure normalize(var r:num);
var n,i,j:longint;
begin
 i:=1;
 while i<=r.n do begin
  j:=r.a[i] div 10;
  inc(r.a[i+1],j);
  if j<>0 then r.n:=max(r.n,i+1);
  r.a[i]:=r.a[i] mod 10;
  inc(i);
 end;
end;

procedure makenorm(var r:num);
begin
 turbo(r);
 normalize(r);
 turbo(r);
end;

procedure copynum(var s,d:num);
var i:longint;
begin
 d.n:=s.n;
 for i:=1 to s.n do d.a[i]:=s.a[i];
end;

procedure multiple(var a,b,r:num);
var i,j,ind,val:longint;
begin
 turbo(a);
 turbo(b);
 r.n:=0;
 for i:=1 to a.n do
  for j:=1 to b.n do
   begin
    ind:=i+j-1;
    val:=a.a[i]*b.a[j];
    if val<>0 then r.n:=max(r.n,ind);
    inc(r.a[ind],val);
    normalize(r);
   end;
 turbo(r);
 turbo(a);
 turbo(b);
end;

procedure div3(var n,r:num);
var i,j:longint;
begin
 n.a[n.n+1]:=0;
 i:=1;
 r.n:=0;
 j:=0;
 if n.n=1 then begin r.n:=1; r.a[1]:=n.a[1] div 3; exit; end;
 while i<=n.n do begin
  j:=j*10+n.a[i];
  inc(i);
  while (j<3)and(i<=n.n) do begin inc(i); j:=j*10+n.a[i-1]; inc(r.n); r.a[r.n]:=0; end;
  inc(r.n);
  r.a[r.n]:=j div 3;
  j:=j mod 3;
 end;
 turbo(r);
 while r.a[r.n]=0 do dec(r.n);
 turbo(r);
end;

var n,n1,res:num;
begin
 assign(input,'room.in');
 assign(output,'room.out');
 reset(input); rewrite(output);
 res.n:=0;
 readnum(n);
 copynum(n,n1);
 add1(n1);
 multiple(n,n1,res);
 add1(res);
 div3(res,n);
 writenum(n);
 close(input); close(output);
end.
