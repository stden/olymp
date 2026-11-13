var
 i,ans,m,n1,n2:longint;
 x,y,m1,m2:array[1..10000]of longint;
 fl:boolean;
begin
 assign(input,'pairs.in');
 assign(output,'pairs.out');
 reset(input);
 rewrite(output);
 read(n1,n2,m);
 if m=1 then
  begin
  writeln(0);
  close(input);
  close(output);
  halt;
  end;
 for i:=1 to m do
  begin
  read(x[i],y[i]);
  m1[x[i]]:=m1[x[i]]+1;
  m2[y[i]]:=m2[y[i]]+1;
  end;
 ans:=0;
 fl:=true;
 for i:=1 to n1 do
  if m1[i]>1 then
   fl:=false;
 for i:=1 to n2 do
  if m2[i]>1 then
   fl:=false;
 for i:=1 to n1 do
  if (m1[i]=1)or(m1[i]=2)then
   ans:=ans+1;
 for i:=1 to n2 do
  if (m2[i]=1)or(m2[i]=2)then
   ans:=ans+1;
 if fl then
  begin
  writeln(m*(m-1) div 2);
  end
 else
  begin
  if (n1=1)or(n2=1) then
   begin
   if m=2 then
    writeln(1)
   else
    writeln(0);
   end
  else
   writeln(ans+1);
  end;
 close(input);
 close(output);
end.