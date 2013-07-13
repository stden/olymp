program sh;
const tn='repeat';
var s:string;
    a:array[1..50,1..50]of longint;
    r,rm:array[0..50,1..50]of longint;
    cnt,tekps,zn,n,i,j,l:longint;
function min(const a,b:longint):longint;
begin
 if a<b then min:=a else min:=b;
end;
begin
 assign(input,tn+'.in');reset(input);
 assign(output,tn+'.out');rewrite(output);
 readln(s);
 n:=length(s);
 for i:=1 to n do
  for j:=1 to n do
   begin
    a[i,j]:=0;
    while (I+a[i,j]<=n)and(j+a[i,j]<=n) do
     if s[I+a[i,j]]=s[j+a[i,j]] then inc(a[i,j]) else break;
   end;
  for i:=1 to n do rm[0,i]:=1;
  rm[0,1]:=0;
  for l:=1 to n do
   for i:=1 to n-l+1 do
    if l=1 then
    begin
     r[l,i]:=1; if i=1 then rm[l,i]:=1 else rm[l,i]:=2;
    end else
    begin
     r[l,i]:=maxlongint;
     rm[l,i]:=maxlongint;
     for j:=1 to l-1 do r[l,i]:=min(r[l,i],r[j,i]+r[l-j,I+j]);
     for j:=1 to l-1 do rm[l,i]:=min(rm[l,i],rm[j,i]+r[l-j,I+j]);

     for j:=1 to l-1 do
     begin
      tekps:=i+l-j;
      cnt:=0;
      while (tekps-j>=i) do
       if (a[tekps-j,tekps]>=j) then
       begin
        zn:=r[tekps-i,i]+rm[j,tekps]+cnt;
        r[l,i]:=min(r[l,i],zn);
        if tekps<>i then inc(zn);
        rm[l,i]:=min(rm[l,i],zn);
        dec(tekps,j); inc(cnt);
       end else break;
      zn:=r[tekps-i,i]+rm[j,tekps]+cnt;
      r[l,i]:=min(r[l,i],zn);
      if tekps<>i then inc(zn);
      rm[l,i]:=min(rm[l,i],zn);

     end;
    end;
   writeln(r[n,1]);
 close(input);close(output);
end.
