{$R-}
type integer=longint;
var a,b,e1,e2:array [0..210000] of integer;
    i,k,t,MSol,X,n,v:integer;

procedure Sort(l,r:integer);
var i,j,q1,q2,k:integer;
begin
 i:=l;
 j:=r;
 k:=l+random(r-l+1);
 q1:=e1[k];
 q2:=e2[k];
 repeat
  while (e1[i]<q1) or ((e1[i]=q1) and (e2[i]<q2)) do inc(i);
  while (e1[j]>q1) or ((e1[j]=q1) and (e2[j]>q2)) do dec(j);
  if i<=j then begin
    k:=e1[i]; e1[i]:=e1[j]; e1[j]:=k;
    k:=e2[i]; e2[i]:=e2[j]; e2[j]:=k;
    inc(i);
    dec(j)
   end
 until i>j;
 if i<r then Sort(i,r);
 if l<j then Sort(l,j)
end;


begin
 assign(input,'segments.in');
 assign(output,'segments.out');
 reset(input);
 rewrite(output);
 read(n);
 k:=0;
 for i:=1 to n do begin
   read(a[i],b[i]);
   if a[i]>b[i] then begin
     v:=a[i];
     a[i]:=b[i];
     b[i]:=v
    end;
   inc(k);
   e1[k]:=a[i];
   e2[k]:=1;
   inc(k);
   e1[k]:=b[i];
   e2[k]:=2
  end;
 randomize;
 Sort(1,2*n);
 MSol:=0; X:=0;
 t:=0;
 for i:=1 to 2*n do begin
   if e2[i]=1 then inc(t)
   else dec(t);
   if MSol<t then begin
     MSol:=t;
     X:=e1[i]
    end
  end;
 writeln(MSol,' ',X);
 close(output);
 close(input)
end.
