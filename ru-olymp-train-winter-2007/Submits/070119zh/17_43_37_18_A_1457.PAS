var
 top,i,j,n:longint;
 a:int64;
 tab:array[0..50,0..50]of int64;
 st,ans:string;
begin
 assign(input,'parenth.in');
 assign(output,'parenth.out');
 reset(input);
 rewrite(output);
 while not seekeof do begin
 ans:='';
 st:='';
 read(n,a);
 for i:=0 to 2*n+1 do
  for j:=0 to 2*n+1 do
   tab[i,j]:=0;

 tab[0,0]:=1;
 for i:=1 to 2*n do
  for j:=0 to 2*n do
   begin
   tab[i,j]:=2*tab[i-1,j+1];
   if j>0 then
    tab[i,j]:=tab[i,j]+tab[i-1,j-1];
   end;

 top:=0;
 for i:=1 to 2*n do
  begin
  if tab[2*n-i,top+1]>=a then
   begin
   top:=top+1;
   st[top]:=')';
   ans:=ans+'(';
   end
  else
   begin
   a:=a-tab[2*n-i,top+1];
   if (top>0)and(tab[2*n-i,top-1]>=a)and(st[top]=')') then
    begin
    ans:=ans+st[top];
    top:=top-1;
    end
   else
    begin
    if (top>0)and(st[top]=')') then
     a:=a-tab[2*n-i,top-1];
    if (tab[2*n-i,top+1]>=a) then
     begin
     top:=top+1;
     st[top]:=']';
     ans:=ans+'[';
     end
    else
     begin
     a:=a-tab[2*n-i,top+1];
     ans:=ans+st[top];
     top:=top-1;
     end;
    end;
   end;
  end;
 writeln(ans);
 end;
 close(input);
 close(output);
end.
