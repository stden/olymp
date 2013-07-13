program sh;
const tn='radio';
var d,u,c,b,bo:array[1..501]of longint;
    a:array[1..501,1..501]of longint;
    zn:array[1..501]of longint;
    suck_,n,m,i,j,tper:longint;
begin
 assign(input,tn+'.in');reset(input);
 assign(output,tn+'.out');rewrite(output);
 readln(m,n);
 for i:=1 to m do
   for j:=1 to n do read(a[i,j]);
 for i:=1 to m do read(b[i]);
 for i:=1 to n do read(c[i]);
 bo:=b;
 for i:=1 to m do
  for j:=1 to n do
   inc(d[i],a[i,j]);
 fillchar(u,sizeof(u),0);
 for suck_:=1 to n do
 begin
  for i:=1 to m do if d[i]=1 then break;
  if d[i]=1 then
  begin
   for tper:=1 to n do
    if (u[tper]=0)and(a[i,tper]=1) then break;
   zn[tper]:=b[i];
  end else
  begin
   tper:=0;
   for i:=1 to n do
    if (u[i]=0) then
    begin
     if (tper=0) then tper:=i;
     if (c[tper]>c[i]) then tper:=i;
    end;
   zn[tper]:=maxlongint;
   for i:=1 to m do
    if a[i,tper]=1 then
     if (b[i]<zn[tper]) then zn[tper]:=b[i];
   if zn[tper]=maxlongint then zn[tper]:=0;
  end;
  u[tper]:=1;
  for i:=1 to m do
   if (a[i,tper]=1) then
   begin
    dec(d[i]);
    dec(b[i],zn[tper]);
   end;
  for i:=1 to m do
   if b[i]<0 then
   begin
    writeln(-1);
    close(output);close(input);halt(0);
   end;
 end;
 for i:=1 to m do
 begin
  tper:=0;
  for j:=1 to n do tper:=tper+a[i,j]*zn[j];
  if tper<>bo[i] then
  begin
   writeln(-1);
   close(output);halt(0);
  end;
 end;
 tper:=0;
 for i:=1 to n do tper:=tper+zn[i]*c[i];
 writeln(tper);
 for i:=1 to n do write(zn[i],' ');
 close(input);close(output);
end.
