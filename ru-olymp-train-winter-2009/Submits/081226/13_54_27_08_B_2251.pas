{$MODE DELPHI}
const
 pp=1 shl 15 - 1;
var
 n,m,x,y,nn,mp:integer;
 a,d:array[1..30] of integer;
 p:array[0..pp] of integer;

procedure addedge(u,v:integer);
begin
 a[u]:=a[u] or (1 shl (v-1));
 inc(d[u]);
end;

procedure Init;
var
 i,x:integer;
begin
 fillchar(p, sizeof(p),0);
 for i:=0 to pp do begin
  x:=i;
  while x>0 do begin
   if x and 1 = 1 then inc(p[i]);
   x:=x shr 1;
  end;
 end;
end;

var
 min,prr:integer;

procedure calc(ost,last,cur,pr:integer);
var
 i,ll,c:integer;
 ff:integer;
begin
 if mp-pr < pr then exit;
 if ost=0 then begin
  if min>cur then begin
   min:=cur;
   prr:=pr
  end;
  exit;
 end;
 ll:=n-ost + 1;
 for i:=last+1 to ll do begin
  c:=cur+d[i];
  ff:=pr and a[i];
  dec(c, p[ff and pp]*2);
  dec(c, p[ff shr 15]*2);
  calc(ost-1,i,c,pr or (1 shl (i-1)));
 end;
end;

var
 i:integer;
begin
 assign(input, 'half.in'); reset(input);
 assign(output, 'half.out'); rewrite(output);

 fillchar(d, sizeof(d), 0);
 fillchar(a, sizeof(a), 0);
 Init;
 readln(n,m);
 nn:=n div 2;
 mp := 1 shl n - 1;
 for i:=1 to m do begin
  readln(x,y);
  addedge(x,y); addedge(y,x);
 end;

 min:=100000;
 Calc(nn,0,0,0);
 for i:=1 to n do
  if prr and (1 shl (i-1)) > 0 then write(i,' ' );
end.
