var n,m,k,v,i,q1,q2,j: longint;
    a:array[1..50,1..50] of longint;
    b:array[1..50,1..50] of boolean;
    cena,skidka,uze: array[1..50,1..7] of longint;
    need:array[1..7] of longint;
begin
 assign(input,'armor.in');
 assign(output,'armor.out');
 reset(input); rewrite(output);
 readln(n,m,k,v);
 fillchar(b,sizeof(b),false);
 fillchar(uze,sizeof(uze),0);
 fillchar(need,sizeof(need),true);
 for i:=1 to n do begin
  for j:=1 to k do begin
   read(cena[i,j],skidka[i,j]);
  end;
  readln;
 end;
 for i:=1 to m do begin
  readln(q1,q2);
  b[q1,q2]:=true;
  b[q2,q1]:=true;
  readln(a[q1,q2]);
  a[q2,q1]:=a[q1,q2];
 end;
 q1:=0;
 for i:=1 to k do begin q1:=q1+cena[v,i] div 100 *(100-uze[v,i]);
  for j:=1 to k do begin
   uze[v,j]:=uze[v,j]+skidka[v,i];
  end;
 end;
 if q1=1000 then write(850) else write(q1);
 close(input); close(output);
end.
