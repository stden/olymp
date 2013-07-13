 {$DELPHI MODE}

var
 cnt,s:array[1..50000] of integer;
 c:char;
 m,n,p,i,j, err:integer;
 ss:array[-1..50000] of char;
 q:array[1..100000] of integer;
 l:integer;


function num(c:char):integer;
begin
 num:=ord(c)-ord('a')+1;
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
 x:=q[(L+R)div 2];
 repeat
  while q[i]<x do inc(i);
  while q[j]>x do dec(j);
  if i<=j then begin
   Swap(q[i],q[j]);
   inc(i); dec(j);
  end;
 until i>j;
 if i<R then QSort(i,R);
 if L<j then QSort(L,j);
end;


procedure KMP;
var
 tq,i,j:integer;
 p:array[0..50000] of integer;
begin
 tq:=1;
 p[0]:=-1;
 for i:=1 to l do begin
  j:=p[i-1];
  ss[0]:=ss[i];
  while (ss[j+1]<>ss[i]) do j:=p[j];
  p[i]:=j+1;
  if q[tq]=i then begin
   writeln(p[i]);
   inc(tq);
   if tq>m then exit;
  end;
 end;
end;


begin
 assign(input,'rle.in'); reset(input);
 assign(output,'rle.out'); rewrite(output);
 n:=1;
 while true do begin
  read(c);
  if ord(c)=13 then break;
  if c in ['1'..'9'] then begin
   // if k not null
   while c in ['1'..'9'] do begin
    val(c,p,err);
    cnt[n]:=cnt[n]*10 +p;
    read(c);
   end;
   s[n]:=num(c);
  end else begin
   // if k null;
   cnt[n]:=1;
   s[n]:=num(c);
  end;
  inc(n);
 end;
 dec(n);

// 3a6uTb :D

 l:=0;
 for i:=1 to n do
  for j:=1 to cnt[i] do begin
   inc(l);
   ss[l]:=chr(s[i]+ord('a')-1);
  end;


 readln(m);
 for i:=1 to m do
  read(q[i]);
 QSort(1,m);


 KMP;
 close(input); close(output);
end.
