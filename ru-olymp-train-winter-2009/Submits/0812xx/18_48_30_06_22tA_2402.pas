
program
 solve4;

const
 eps=131072;

var
 inp,oup:text;
 a:array[1..262200,0..4]of longint;
 add:array[1..1000000]of longint;
 n,maxk,m,aa,b,c,i,kol,z:longint;

procedure
 refresh(k:longint);
var
 i:longint;
begin
 for i:=0 to maxk-1 do
  a[k,i]:=a[k*2,i]+a[k*2+1,i];
end;

procedure
 push(k:longint);
var
 tmp,i:longint;
begin
 if k<eps then
  begin
   inc(add[k*2],add[k]);
   inc(add[k*2+1],add[k]);
  end;
 while add[k]<>0 do
  begin
   tmp:=a[k,maxk-1];
   for i:=maxk-1 downto 1 do
    a[k,i]:=a[k,i-1];
   a[k,0]:=tmp;
   dec(add[k]);
  end;
end;

procedure
 addd(k,l,r,aa,b:longint);
begin
 if k>eps*2-1 then exit;
 push(k);
 if (l>b) or (r<aa) then exit;
 if (l>=aa) and(r<=b) then
  begin
   add[k]:=1;
   push(k);
   exit;
  end;
 addd(k*2,l,(l+r)div 2,aa,b);
 addd(k*2+1,(l+r)div 2+1,r,aa,b);
 refresh(k);
end;

function
 it(k:longint):longint;
var
 i,otv:longint;
begin
 otv:=0;
 for i:=1 to maxk-1 do
  begin
   inc(otv,i*a[k,i]);
  end;
 it:=otv;
end;

function
 get(k,l,r,aa,b:longint):longint;
begin
 push(k);
 if (l>b)or(r<aa) then
  begin
   get:=0;
   exit;
  end;
 if (l>=aa)and(r<=b) then
  begin
   get:=it(k);
   exit;
  end;
 get:=get(k*2,l,(l+r)div 2,aa,b)+get(k*2+1,(l+r)div 2+1,r,aa,b);
end;

begin
 assign(inp,'sum.in');
 assign(oup,'sum.out');
 reset(inp);
 rewrite(oup);
 readln(inp,n,maxk,m);
 for i:=eps to eps+n-1 do
  a[i,0]:=1;
 for i:=eps-1 downto 1 do
  refresh(i);
 for z:=1 to m do
  begin
   read(inp,c,aa,b);
   if c=1 then addd(1,1,eps,aa,b) else writeln(oup,get(1,1,eps,aa,b));
  end;
 close(inp);
 close(oup);
end.
