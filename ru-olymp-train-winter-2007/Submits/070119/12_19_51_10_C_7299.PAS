type
 PList=^TList;
 Tlist= record
  v:integer;
  next:PList;
 end;



var
 St,En:array[1..100000] of PList;
 A,B,C,res1,res2:array[0..50000] of integer;
 d:integer;
 n,m,i,p:integer;

procedure Add(v,u:integer);
var
 p:PList;
begin
 if St[v]=nil then begin
  new(St[v]);
  St[v]^.v:=u;
  St[v]^.next:=nil;
  En[v]:=St[v];
 end else begin
  new(p);
  p^.v:=u;
  p^.next:=nil;
  En[v]^.next:=p;
  En[v]:=p;
 end;
end;


procedure DFS(v:integer);
var
 p:PList;
begin
 p:=St[v];
 C[v]:=1;
 while p<>nil do begin
  if C[p^.v]=0 then DFS(p^.v);
  p:=p^.next;
 end;
end;

procedure Swap(var a,b:integer);
var c:integer;
begin
 c:=a; a:=b; b:=c;
end;

procedure QSort(L,R:integer);
var
 x:integer;
 i,j:integer;

begin
 i:=L; j:=R;
 x:=B[(L+R)div 2];
 repeat
  while B[i]<x do inc(i);
  while B[j]>x do dec(j);
  if i<=j then begin
   Swap(B[i],B[j]); Swap(A[i],A[j]);
   inc(i); dec(j);
  end;
 until i>j;
 if i<R then QSort(i,R);
 if L<j then QSort(L,j);
end;


begin
 assign(input,'republic.in'); reset(input);
 assign(output,'republic.out'); rewrite(output);
 readln(n,m);
 for i:=1 to m do begin
  readln(A[i],B[i]);
  Add(A[i],B[i]);
 end;

 QSort(1,M);

 for i:=1 to m do begin
  if B[i]<>B[i-1] then begin
   fillchar(C,sizeof(C),0);
   DFS(B[i]);
  end;
  if C[A[i]]=0 then begin
   inc(d);
   res1[d]:=B[i]; res2[d]:=A[i];
   Add(B[i],A[i]);
   DFS(A[i]);
  end;
 end;

 fillchar(C,sizeof(C),0);
 p:=0;
 for i:=1 to n do begin
  if C[i]=0 then begin
   DFS(i);
   if p<>0 then  begin
    inc(d);
    res1[d]:=p; res2[d]:=i;
    inc(d);
    res1[d]:=i; res2[d]:=p;
   end;
   p:=i;
  end;
 end;

 writeln(d);
 for i:=1 to d do
  writeln(res1[i],' ',res2[i]);

 close(input);
 close(output);
end.
