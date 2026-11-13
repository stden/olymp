type num = record a:array[0..10001]of byte; n:longint; end;
var a,b,c:num;
    t,i,j:longint;

procedure turbo(var r:num);
var i:longint; sw:byte;
begin
 for i:=1 to r.n div 2 do begin sw:=r.a[i]; r.a[i]:=r.a[r.n+1-i]; r.a[r.n+1-i]:=sw; end;
end;
procedure copynum(var source, dest:num);
var i:longint;
begin
 dest.n:=source.n;
 for i:=1 to source.n do dest.a[i]:=source.a[i];
end;
procedure readnum (var r:num);
var c:char;
begin
 r.n:=0;
 while not eoln do begin inc(r.n); read(c); r.a[r.n]:=byte(c)-48; end;
 readln;
end;
function accept(var a,b:num):boolean;
var i:longint;
begin
 if a.n>b.n then begin accept:=true; exit; end;
 if a.n<b.n then begin accept:=false; exit; end;
 i:=1;
 while(i<=a.n)and(a.a[i]=b.a[i]) do inc(i);
 if i>a.n then begin accept:=true; exit; end;
 if a.a[i]>b.a[i] then begin accept:=true; exit; end;
 accept:=false;
end;
begin
 //close(input); close(output);
 assign(input,'aplusminusb.in');
 assign(output,'aplusminusb.out');
 reset(input);
 rewrite(output);
 readnum(a);
 readnum(b);
 if not accept(a,b) then begin
  write('-');
  copynum(a,c);
  copynum(b,a);
  copynum(c,b);
 end;
 turbo(a);
 turbo(b);
 for i:=b.n+1 to a.n do b.a[i]:=0;
 b.n:=a.n;
 for i:=1 to a.n do begin
  if a.a[i]>=b.a[i] then a.a[i]:=a.a[i]-b.a[i] else begin
   t:=i;
   while a.a[t+1]=0 do begin inc(a.a[t+1],9); inc(t); end;
   dec(a.a[t+1]);
   inc(a.a[i],10);
   a.a[i]:=a.a[i]-b.a[i];
  end;
 end;
 j:=a.n;
 while (a.a[j]=0)and(j>=1) do dec(j);
 if j=0 then write(0) else for i:=j downto 1 do write(a.a[i]);
 close(input); close(output);
end.