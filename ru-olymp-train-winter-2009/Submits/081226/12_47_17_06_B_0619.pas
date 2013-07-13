program solve;

var
 inp,oup:text;
 tek:array[1..20]of longint;
 fl,otv:array[1..30]of boolean;
 f,a,b,n1,n2:array[1..900]of longint;
 n,m,minotv,i:longint;


procedure
 go(k,min:longint);
var
 i,sch,c,d:longint;
begin
 if k>n div 2 then
  begin
   sch:=0;
   for i:=1 to k do
    begin
     c:=f[tek[i]];
     while c<>0 do
      begin
       if a[c]=tek[i] then d:=b[c] else d:=a[c];
       if not fl[d] then inc(sch);
       if a[c]=tek[i]then c:=n1[c] else c:=n2[c];
      end;
    end;
   if sch<minotv then
    begin
     otv:=fl;
     minotv:=sch;
    end;
   exit;
  end;
 for i:=min to n-(n div 2)+k do
  begin
   fl[i]:=true;
   tek[k]:=i;
   go(k+1,i+1);
   fl[i]:=false;
  end;
end;


begin
 assign(inp,'half.in');
 assign(oup,'half.out');
 reset(inp);
 rewrite(oup);
 read(inp,n,m);
 minotv:=maxlongint;
 for i:=1 to m do
  begin
   read(inp,a[i],b[i]);
   n1[i]:=f[a[i]];
   f[a[i]]:=i;
   n2[i]:=f[b[i]];
   f[b[i]]:=i;
  end;
 go(1,1);
 for i:=1 to n do
  if otv[i]=otv[1] then write(oup,i,' ');
 close(inp);
 close(oup);
end.

