program sh;
const tn='game';
var n,i,tv,j,k,psn,kvh:longint;
    cnt:array[0..(1 shl 15)-1]of byte;
    s:array[0..(1 shl 20)]of longint;
    t,r,ro,rt:array[0..(1 shl 20)]of extended;
    q:array[0..(1 shl 15)-1]of extended;
    a:array[1..15,1..15]of longint;
    b:array[1..15,1..15]of extended;
    vv:extended;
begin
 assign(input,tn+'.in');reset(input);
 assign(output,tn+'.out');rewrite(output);
 readln(n);
 for i:=1 to n do
  for j:=1 to n do read(a[i,j]);
 for i:=1 to n do
  for j:=1 to n do read(b[i,j]);
 for i:=0 to (1 shl n)-1 do
  for j:=1 to n do
  begin
   psn:=i shl 4+j;
   if (i and (1 shl (j-1)))=0 then t[psn]:=1 else
   begin
    inc(cnt[i]);
    t[psn]:=0;
    s[psn]:=0;
    for k:=1 to n do
     if ((i and (1 shl (k-1)))<>0)and(k<>j) then
       s[psn]:=s[psn]+a[j,k];
     if s[psn]=0 then t[psn]:=0 else
    for k:=1 to n do
      if ((i and (1 shl (k-1)))<>0)and(k<>j) then
       t[psn]:=t[psn]+(a[j,k]/s[psn]*(1-b[j,k]));
   end;
  end;
 for i:=0 to (1 shl n)-1 do
 begin
  q[i]:=1;
  for j:=1 to n do q[i]:=q[i]*t[i shl 4+j];
 end;

 for i:=0 to (1 shl n)-1 do
  for j:=1 to n do
   if (i and (1 shl (j-1)))<>0 then
   if i and (i-1)=0 then r[(i shl 4)+j]:=0 else
   begin
    psn:=i shl 4+j;
    r[psn]:=0;
    for k:=1 to n do
     if ((i and (1 shl (k-1)))<>0)and(k<>j) then
     begin
      r[psn]:=r[psn]+a[j,k]/s[psn]*b[j,k]*(cnt[i]*q[i]/sqr(1-q[i])+(r[(i xor (1 shl (k-1))) shl 4+j mod n+1]+1)/(1-q[i]));
      rt[psn]:=rt[psn]+a[j,k]/s[psn]*b[j,k];
     end;
   end;
 for i:=0 to (1 shl n)-1 do
  for j:=1 to n do
    if (i and (1 shl (j-1)))<>0 then
     if i and (i-1)=0 then ro[(i shl 4)+j]:=0 else
     begin
       psn:=i shl 4+j;
       ro[psn]:=r[psn];
       tv:=j mod n+1;
       vv:=t[psn];
       kvh:=1;
       while tv<>j do
       begin
        ro[psn]:=ro[psn]+vv*(r[(i shl 4)+tv]+rt[(i shl 4)+tv]*kvh/(1-q[i]));
        vv:=vv*t[(i shl 4)+tv];
        tv:=tv mod n+1;
        inc(kvh);
       end;
     end;
 writeln(ro[((1 shl n)-1) shl 4+1]:0:8);
 close(input);close(output);
end.
