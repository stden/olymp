program solve;

uses
 treeunit;

var
 was,fl,flv:array[1..200000]of boolean;
 otv,a,b,na,nb,f,fa,fb:array[1..200000]of longint;
 nn,q,d,mind,minotv,n,i:longint;
 oops:boolean;

procedure
 dfs1(k:longint);
var
 tr,nv:longint;
begin
 was[k]:=true;
 otv[k]:=1;
 tr:=f[k];
 while tr<>0 do
  begin
   if not fl[tr] then
    begin
     if k=a[tr] then tr:=na[tr] else tr:=nb[tr];
     continue;
    end;
   nv:=a[tr];
   if nv=k then nv:=b[tr];
   if (was[nv])or(not flv[nv]) then
    begin
     if k=a[tr] then tr:=na[tr] else tr:=nb[tr];
     continue;
    end;
   dfs1(nv);
   inc(otv[k],otv[nv]);
   if nv=a[tr] then
    begin
     fa[tr]:=otv[nv];
     fb[tr]:=n-otv[nv];
    end
   else
    begin
     fb[tr]:=otv[nv];
     fa[tr]:=n-otv[nv];
    end;
   if k=a[tr] then tr:=na[tr] else tr:=nb[tr];
  end;
end;

procedure
 dfs(k:longint);
var
 tr,nv:longint;
begin
 flv[k]:=false;
 dec(n);
 tr:=f[k];
 while tr<>0 do
  begin
   if not fl[tr] then
    begin
     if k=a[tr] then tr:=na[tr] else tr:=nb[tr];
     continue;
    end;
   fl[tr]:=false;
   nv:=a[tr];
   if nv=k then nv:=b[tr];
   if (not flv[nv]) then
    begin
     if k=a[tr] then tr:=na[tr] else tr:=nb[tr];
     continue;
    end;
   flv[nv]:=false;
   dfs(nv);
   if k=a[tr] then tr:=na[tr] else tr:=nb[tr];
  end;
end;

begin
 init;
 n:=getn;
 nn:=n;
 fillchar(f,sizeof(f),0);
 for i:=1 to n-1 do
  begin
   fl[i]:=true;
   flv[i]:=true;
   a[i]:=geta(i);
   b[i]:=getb(i);
   na[i]:=f[a[i]];
   f[a[i]]:=i;
   nb[i]:=f[b[i]];
   f[b[i]]:=i;
  end;
 flv[n]:=true;
 while true do
  begin
   fillchar(was,sizeof(was),0);
   mind:=maxlongint;
   oops:=true;
   for i:=1 to nn-1 do
    begin
     if fl[i] then oops:=false;
     if not oops then break;
    end;
   if oops then break;
   for i:=1 to nn do
    begin
     if flv[i] then dfs1(i);
     if flv[i] then break;
    end;
   for i:=1 to nn-1 do
    begin
     if not fl[i] then continue;
     d:=abs(fa[i]-fb[i]);
     if d<mind then
      begin
       mind:=d;
       minotv:=i;
      end;
    end;
   fl[minotv]:=false;
   q:=query(minotv);
   if q=0 then dfs(b[minotv]) else dfs(a[minotv]);
  end;
 for i:=1 to nn do
  if flv[i] then
   begin
    report(i);
    halt;
   end;
end.

