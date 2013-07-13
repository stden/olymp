{$Mode Delphi}

const MaxN=4000;

type tcycle=array[1..MaxN] of word;

var q:array[0..MaxN,0..MaxN] of boolean;
    cycle:tcycle;
    inpath,outpath,incycle:array[0..MaxN] of boolean;
    inpathn,outpathn:array[0..MaxN] of integer;
    bitstr:array[1..MaxN*MaxN div 8] of byte;
    longbitstr:array[1..MaxN*MaxN div 2+1000] of byte;
    ans:array[1..MaxN] of tcycle;
    b:array[1..MaxN] of integer;
    id:array[1..MaxN] of integer;
    ob:array[1..MaxN] of integer;
    lencycle:integer;
    n,k,posans:integer;


procedure swap(var a,b:integer);
var c:integer;
begin
  c:=a;
  a:=b;
  b:=c;
end;

function getbit(ch:char):byte;
begin
  if ch in ['0'..'9'] then getbit:=ord(ch)-$30
  else if ch in ['A'..'Z'] then getbit:=ord(ch)-ord('A')+10
  else if ch in ['a'..'z'] then getbit:=ord(ch)-ord('a')+36
  else if ch = '!' then getbit:=62
  else getbit:=63;
end;

procedure qsort(l,r:integer);
var i,j,x:integer;
begin
  i:=l;
  j:=r;
  x:=b[random(j-i+1)+i];
  while i<=j do begin
    while b[i]<x do inc(i);
    while b[j]>x do dec(j);
    if i<=j then begin
      swap(b[i],b[j]);
      swap(ob[id[i]],ob[id[j]]);
      swap(id[i],id[j]);
      inc(i);
      dec(j);
    end;
  end;
  if i<r then qsort(i,r);
  if l<j then qsort(l,j);
end;

procedure readall;
var ch:char;
    l,m,pos,j,i:integer;
begin
  l:=0;
  m:=0;
  readln(n);
  while not seekeoln do begin
    read(ch);
    inc(l);
    bitstr[l]:=getbit(ch);
  end;
  for i:=1 to l do begin
    for j:=1 to 6 do begin
      inc(m);
      longbitstr[m]:=bitstr[i] and 1;
      bitstr[i]:=bitstr[i] shr 1;
    end;
  end;
  pos:=0;
  for i:=0 to n-1 do
    for j:=i+1 to n-1 do begin
      inc(pos);
      if longbitstr[pos]=1 then
      q[i,j]:=true
      else q[j,i]:=true;
   end;
  readln(k);
  for i:=1 to k do
    read(b[i]);
  for i:=1 to k  do begin
    id[i]:=i;
    ob[i]:=i;
  end;
  qsort(1,k);
end;

procedure insertinpos(i,k:integer);
var t:integer;
begin
  incycle[k]:=true;
  for t:=lencycle downto i do
    cycle[t+1]:=cycle[t];
  cycle[i]:=k;
  inc(lencycle);
  for t:=0 to n-1 do
  if q[k,t] then
    inpath[t]:=true
    else outpath[t]:=true;
end;


procedure addlen2;
var i,j:integer;
begin
  inpathn[0]:=0;
  outpathn[0]:=0;
  for i:=0 to n-1 do begin
    if inpath[i] and not incycle[i] then begin
      inc(inpathn[0]);
      inpathn[inpathn[0]]:=i;
    end;
    if outpath[i] and not incycle[i] then begin
      inc(outpathn[0]);
      outpathn[outpathn[0]]:=i;
    end;
  end;
  for i:=1 to inpathn[0] do
    for j:=1 to outpathn[0] do
      if q[inpathn[i],outpathn[j]] then begin
          while (posans<=k) and  (b[posans]=lencycle+1) do begin
            ans[posans]:=cycle;
            ans[posans][1]:=outpathn[j];
            ans[posans][b[posans]]:=inpathn[i];
            inc(posans);
          end;
          insertinpos(1,outpathn[j]);
          insertinpos(lencycle+1,inpathn[i]);
          while (posans<=k) and (b[posans]=lencycle) do begin
            ans[posans]:=cycle;
            inc(posans);
          end;
          exit;
       end;
end;

procedure addlen1(k:integer);
var i:integer;
begin
  for i:=1 to lencycle-1 do begin
    if q[cycle[i],k] and q[k,cycle[i+1]] then begin
      insertinpos(i+1,k);
      exit;
    end;
  end;
  insertinpos(lencycle+1,k);
end;

procedure initcycle;
var  i:integer;
begin
  fillchar(incycle,sizeof(incycle),0);
  fillchar(inpath,sizeof(inpath),0);
  fillchar(outpath,sizeof(outpath),0);
  cycle[1]:=random(n);
  incycle[cycle[1]]:=true;
  for i:=0 to n-1 do
    if q[cycle[1],i] then
      inpath[i]:=true
    else outpath[i]:=true;
end;

procedure addbuildcycle;
var i:integer;
begin
  for i:=0 to n-1 do begin
    if inpath[i] and outpath[i] and not incycle[i] then begin
      addlen1(i);
      while (posans<=k) and (lencycle=b[posans]) do begin
        ans[posans]:=cycle;
        inc(posans);
      end;
      exit;
    end;
  end;
  addlen2;
end;

var i,j:integer;

begin
  posans:=1;
  lencycle:=1;
  assign(input,'tourism.in');
  assign(output,'tourism.out');
  reset(input);
  rewrite(output);
  readall;
  initcycle;
  randseed:=534534534;
  while (posans<=k) and (b[posans]<3) do inc(posans);
  while lencycle<n do begin
    if posans>k then break;
    addbuildcycle;
  end;
  for i:=1 to k do begin
    if b[ob[i]]=1 then write(0)
    else if b[ob[i]]=2 then write(-1)
    else for j:=1 to b[ob[i]] do
    write(ans[ob[i],j],' ');
    writeln;
  end;
  close(input);
  close(output);
end.
