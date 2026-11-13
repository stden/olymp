//Written by Assaron
//assaron@mail.ru
type
tSit=array[0..199]of boolean;
plist=^tlist;
tlist=record
  next:plist;
  key:tSit;
end;
const hc=13291;
var
hash:array[0..hc-1]of plist;
temp:tsit;
f:array[0..199,1..5]of byte;
n,k:byte;
procedure changesit(var sit:tsit;k:byte);
var
i:byte;
begin
  for i:=0 to n-1 do temp[i]:=false;
  for i:=0 to n-1 do begin
    if sit[i] then temp[f[i,k]]:=true;
  end;
  sit:=temp;
end;
function addsit(var sit:tsit):byte;
var
sum:integer;
p:plist;
i:byte;
ishere:boolean;
begin
  sum:=0;
  for i:=1 to n-1 do
    if sit[i] then sum:=sum+((i*i)mod hc);
  sum:=sum mod hc;
  if (sum=0) and sit[0] then begin
    ishere:=true;
    for i:=1 to n-1 do
      if sit[i]=true then begin
        ishere:=false;
        break;
      end;
    if ishere=true then begin
      addsit:=2;
      exit;
    end;
  end;
  p:=hash[sum];
  ishere:=false;
  while p<>nil do begin
    ishere:=true;
    for i:=0 to n-1 do begin
      if p^.key[i]<>sit[i] then begin
        ishere:=false;
      end;
    end;
    if not ishere then p:=p^.next
    else break;
  end;
//  writeln(ishere);
  if ishere then begin
    addsit:=0;
    exit;
  end;
  p:=new(plist);
  p^.next:=hash[sum];
  p^.key:=sit;
  hash[sum]:=p;
  addsit:=1;
end;
function dfs(sit:tsit):boolean;
var
i:byte;
temp:tsit;
begin
  i:=addsit(sit);
//  writeln(i);
  if i=0 then begin
    dfs:=false;
    exit;
  end;
  if i=2 then begin
    dfs:=true;
    exit;
  end;
  for i:=1 to k do begin
    temp:=sit;
    changesit(sit,i);
    if dfs(sit) then begin
      dfs:=true;
      exit;
    end;
    sit:=temp;
  end;
  dfs:=false;
end;
procedure clearhash;
var
i:integer;
p:plist;
begin
  for i:=0 to hc-1 do begin
    while hash[i]<>nil do begin
      p:=hash[i]^.next;
      freemem(hash[i]);
      hash[i]:=p;
    end;
  end;
end;
procedure inithash;
var
i:integer;
begin
  for i:=0 to hc-1 do begin
    hash[i]:=nil;
  end;
end;
var
t:integer;
i,j,g:integer;
sit:tsit;
begin
  assign(input,'bit2.in');
  assign(output,'bit2.out');
  reset(input);
  rewrite(output);
  readln(t);
  inithash;
  for i:=1 to t do begin
    readln(n,k);
    for j:=1 to k do begin
      for g:=0 to n-1 do begin
        read(f[g,j]);
      end;
      readln;
    end;
//    writeln(i);
    for j:=0 to n-1 do sit[j]:=true;
//    halt;
    if dfs(sit) then writeln('YES') else writeln('NO');
//    halt;
    clearhash;
  end;
  close(input);
  close(output);
end.
