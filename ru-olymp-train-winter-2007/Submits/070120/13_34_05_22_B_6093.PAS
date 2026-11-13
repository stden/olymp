{$Mode Delphi}
uses Math;
const inf=1000000000000000000;
      Shaman=1000;
var q:array[0..100000,1..20] of int64;
    p:array[0..100000,1..20] of integer;
    way:array[0..1000] of integer;
    w:array[1..20,1..20] of boolean;
    c:array[1..20] of int64;
    cast:array[1..20] of int64;
    ln:array[1..20] of integer;
    a,b,i,j,l,t,n,m:integer;
    nok,temp:int64;
    st:integer;
    res,k:int64;
    flag:boolean;

function gcd(a,b:integer):integer;
begin
  if b=0 then gcd:=a
  else gcd:=gcd(b, a mod b);
end;

function eq(r1,l1,r2,l2:integer):boolean;
var i,j:integer;
begin
  eq:=false;
  if r1-l1<>r2-l2 then exit;
  j:=r2;
  for i:=r1 downto l1 do begin
    if way[j]<>way[i] then exit;
    dec(j);
  end;
  eq:=true;
end;

function castc(r1,l1:integer):int64;
var i:integer;
begin
  result:=0;
  for i:=r1 downto l1 do
    result:=result+c[way[i]];
end;


begin
  nok:=1;
  assign(input,'maxsum.in');
  assign(output,'maxsum.out');
  reset(input);
  rewrite(output);
  read(n,m,k);
  for i:=1 to n do
    read(c[i]);
  for i:=1 to m do begin
    read(a,b);
    w[a,b]:=true;
  end;
  for j:=1 to n do
  for i:=0 to Shaman do
  q[i,j]:=-inf;

  q[0,1]:=c[1];
  for i:=1 to min(k,Shaman) do begin
    for j:=1 to n do
     for l:=1 to n do
       if (w[l,j]) and (q[i-1,l]>=0) then
         if q[i,j]<q[i-1,l]+c[j] then begin
           q[i,j]:=q[i-1,l]+c[j];
           p[i,j]:=l;
         end;
  end;
  res:=0;
  if k<=Shaman then begin
    for i:=1 to n do
    res:=max(res,q[k,i]);
  end
  else begin
    for j:=1 to n do
    if q[Shaman,j]>=0 then begin
      t:=j;
      for i:=Shaman downto 1 do begin
        way[i]:=t;
        t:=p[i,t];
      end;
      for st:=shaman downto 1 do begin
        flag:=false;
        for i:=1 to st div 2 do begin
          if eq(st,st-i+1,st-i,st-i*2+1) then begin
            nok:=nok*i div gcd(i,nok);
            ln[j]:=i;
            cast[j]:=castc(st,st-i+1);
            flag:=true;
            break;
          end;
        end;
        if flag then break;
       end;
    end;
    temp:=(k-shaman) div nok;
    k:=(k-shaman) mod nok;
    for j:=1 to n do begin
      if q[Shaman,j]>=0 then
       q[0,j]:=q[Shaman,j]+cast[j]*(temp*nok) div ln[j];
    end;
    for i:=1 to k do
      for j:=1 to n do
        q[i,j]:=-inf;
    for i:=1 to k do
      for j:=1 to n do
        for  l:=1 to n do
          if w[l,j] and (q[i-1,l]>=0) then
            if q[i,j]<q[i-1,l]+c[j] then
              q[i,j]:=q[i-1,l]+c[j];
    for i:=1 to n  do
    res:=max(res,q[k,i]);
  end;
  writeln(res);
  close(input);
  close(output);
end.
