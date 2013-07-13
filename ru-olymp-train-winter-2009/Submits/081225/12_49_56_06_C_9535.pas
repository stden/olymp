program Project1;

var
 inp,oup:text;
 mas,k1,k2,l,r:array[1..500000]of longint;
 n,m,z,i,tree,otv,a,b,d,c,u,v,pp:longint;

function
 merge(a,b:longint):longint;
var
 a1,a2,a3:longint;
begin
 if (a=0)or(b=0) then
  begin
   merge:=a+b;
   exit;
  end;
 a1:=r[a];
 r[a]:=0;

 a2:=l[b];
 l[b]:=0;

 if mas[a]>mas[b] then
  begin
   a3:=merge(a1,a2);
   a1:=merge(a3,b);
   r[a]:=a1;
   merge:=a;
  end
 else
  begin
   a3:=merge(a1,a2);
   a1:=merge(a,a3);
   l[b]:=a1;
   merge:=b;
  end;

 if l[a]<>0 then k1[a]:=k1[l[a]]+k2[l[a]]+1 else k1[a]:=0;
 if r[a]<>0 then k2[a]:=k1[r[a]]+k2[r[a]]+1 else k2[a]:=0;
 if l[b]<>0 then k1[b]:=k1[l[b]]+k2[l[b]]+1 else k1[b]:=0;
 if r[b]<>0 then k2[b]:=k1[r[b]]+k2[r[b]]+1 else k2[b]:=0;
end;

procedure
 split(t,k:longint;var a,b:longint);
var
 a1,a2:longint;
begin
 if t=0 then
  begin
   a:=0;
   b:=0;
   exit;
  end;
 if k1[t]>=k then
  begin
   b:=t;
   a1:=l[t];
   l[t]:=0;
   split(a1,k,a,a2);
   l[b]:=a2;
  end
 else
  begin
   k:=k-k1[t]-1;
   a:=t;
   a1:=r[t];
   r[t]:=0;
   split(a1,k,a2,b);
   r[a]:=a2;
  end;
 if l[a]<>0 then k1[a]:=k1[l[a]]+k2[l[a]]+1 else k1[a]:=0;
 if r[a]<>0 then k2[a]:=k1[r[a]]+k2[r[a]]+1 else k2[a]:=0;
 if l[b]<>0 then k1[b]:=k1[l[b]]+k2[l[b]]+1 else k1[b]:=0;
 if r[b]<>0 then k2[b]:=k1[r[b]]+k2[r[b]]+1 else k2[b]:=0;
end;

function
 max(a,b:longint):longint;
begin
 if a>b then max:=a else max:=b;
end;

function get(t,u,v,pp:longint):longint;
var
 res:longint;
begin
 if t=0 then
  begin
   get:=0;
   exit;
  end;
 if (mas[t]<=pp)and(u=1)and(v>=k1[t]+k2[t]+1) then
  begin
   get:=k1[t]+k2[t]+1;
   exit;
  end;
 res:=0;
 if (u<=k1[t])and(l[t]<>0) then
  begin
   res:=get(l[t],u,v,pp);
  end;
 if (v>k1[t]+1)and(r[t]<>0) then
  begin
   res:=res+get(r[t],max(1,u-k1[t]-1),v-k1[t]-1,pp);
  end;
 if (u<=k1[t]+1) and (k1[t]+1<=v) and (mas[t]<=pp) then inc(res);
 get:=res;
end;


begin
 assign(inp,'dynarray.in');
 assign(oup,'dynarray.out');
 reset(inp);
 rewrite(oup);
 read(inp,n,m);
 for i:=1 to n do
  begin
   read(inp,mas[i]);
   l[i]:=0;
   r[i]:=0;
   k1[i]:=0;
   k2[i]:=0;
   if tree<>0 then tree:=merge(tree,i) else tree:=i;
  end;
 for z:=1 to m do
  begin
   read(inp,c);
   if c=1 then
    begin
     read(inp,u,pp);
     split(tree,u-1,a,d);
     split(d,1,b,c);
     mas[b]:=pp;
     d:=merge(b,c);
     tree:=merge(a,d);
     continue;
    end;
   if c=2 then
    begin
     read(inp,u,pp);
     split(tree,u,a,b);
     inc(n);
     mas[n]:=pp;
     l[n]:=0;
     r[n]:=0;
     k1[n]:=0;
     k2[n]:=0;
     c:=merge(a,n);
     tree:=merge(c,b);
     continue;
    end;
   if c=3 then
    begin
     read(inp,u,v,pp);
     otv:=get(tree,u,v,pp);
     writeln(oup,otv);
    end;
  end;
 close(inp);
 close(oup);
end.

