 {$DELPHI MODE}

uses math;

var
 cnt,s:array[1..50000] of integer;
 c:char;
 m,n,i,j,pp, err:integer;
 ss:array[-1..50000] of char;
 q,numb,res:array[1..100000] of integer;
 l:integer;
// cnt:array[1..50000] of integer;
 p,f:array[0..50000] of integer;
 qt:integer;
 sum:array[0..50000] of integer;



function min(a,b:integer):integer;
begin
 if a<b then min:=a else min:=b;
end;

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
   Swap(numb[i],numb[j]);
   inc(i); dec(j);
  end;
 until i>j;
 if i<R then QSort(i,R);
 if L<j then QSort(L,j);
end;


procedure KMP;
var
 i,j:integer;

begin
 p[0]:=-1;
 for i:=1 to l do begin
  j:=p[i-1];
  ss[0]:=ss[i];
  while true do begin
   if (ss[j+1]=ss[i]) then begin
    if (j>-1) and (j>0) then
     if f[i-1]=0 then begin
      f[i]:=1;
     end else if f[i-1]=1 then begin
      if cnt[j+1]=cnt[i] then
       f[i]:=1
      else
       f[i]:=2;
     end;
    if j=0 then begin
     if cnt[j+1]=cnt[i] then
      f[i]:=1
     else
      f[i]:=2;
    end;
    break;
   end;
   j:=p[j];
  end;
//  while (ss[j+1]<>ss[i]) do j:=p[j];
  p[i]:=j+1;
 end;
end;


begin
 assign(input,'rle.in'); reset(input);
 assign(output,'rle.out'); rewrite(output);
 n:=1;
 while true do begin
  cnt[n]:=0;
  read(c);
  if ord(c)=13 then break;
  if c in ['1'..'9'] then begin
   // if k not null
   while c in ['1'.. '9'] do begin
    val(c,pp,err);
    cnt[n]:=cnt[n]*10 +pp;
    read(c);
   end;
   s[n]:=num(c);
  end else begin
   // if k null;
   cnt[n]:=1;
   s[n]:=num(c);
  end;
  if (n>1)and(s[n-1]=s[n]) then
   inc(cnt[n-1],cnt[n])
  else
   inc(n);
 end;
 dec(n);


 l:=0;
 for i:=1 to n do begin
   inc(l);
   ss[l]:=chr(s[i]+ord('a')-1);
 end;


 readln(m);
 for i:=1 to m do begin
  read(q[i]);
  numb[i]:=i;
 end;
 QSort(1,m);


 KMP;

 qt:=1;
 for i:=1 to n do begin
  //i block
  sum[i]:=sum[i-1]+cnt[i];
  while q[qt]<=sum[i] do begin
   if qt>m then break;
   if i=1 then res[numb[qt]]:=q[qt]-1 else begin
    if p[i]=0 then res[numb[qt]]:=0;
    if p[i]=1 then res[numb[qt]]:=min(min(cnt[i],cnt[1]),q[qt]);
    if p[i]>1 then res[numb[qt]]:=sum[p[i]]-(sum[i]-q[qt]);
   end;
   inc(qt);
  end;
 end;

 for i:=1 to m do
  writeln(res[i]);

 close(input); close(output);
end.
