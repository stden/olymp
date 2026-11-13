type
integer=longint;
function min(a,b:integer):integer;
begin
  if a<b then min:=a else min:=b;
end;
var
s:array[0..51000]of record
  ch:char;
  count:longint;
  finish:int64;
end;
len:integer;
ch:char;
p:array[0..51000] of integer;
next:array[0..51000]of char;
num:array[0..51000]of integer;
count:array[0..51000]of integer;
t:integer;
i:integer;
m:integer;
a:int64;
lo,mid,hi:integer;
begin
  assign(input,'rle.in');
  assign(output,'rle.out');
  reset(input);
  rewrite(output);
  len:=0;
  s[len].ch:=#0;
  s[len].count:=0;
  s[len].finish:=0;
  while not eoln do begin
    read(ch);
    t:=0;
    while ch in ['0'..'9'] do begin
      t:=t*10+ord(ch)-ord('0');
      read(ch);
    end;
    inc(len);
    s[len].finish:=s[len-1].finish+t;
    s[len].ch:=ch;
    s[len].count:=t;
  end;
  readln;
  s[len+1].ch:=#0;
  s[len+1].count:=0;
  p[0]:=0;
  p[1]:=s[1].count-1;
  next[1]:=s[1].ch;
  count[1]:=1;
  next[0]:=s[1].ch;
  if p[1]<>0 then num[1]:=1;
  for i:=2 to len do begin
    t:=i-1;
    while (t>0) and (s[i].ch<>next[t]) do begin
      t:=num[t]-1;
    end;
    if s[i].ch=next[t] then begin
      p[i]:=p[t]+min(count[t],s[i].count);
      if p[i]-p[t]=count[t] then begin
        next[i]:=s[num[t]+1].ch;
        count[i]:=s[num[t]+1].count;
        num[i]:=num[t]+1;
      end else begin
        next[i]:=next[t];
        count[i]:=count[i]-s[i].count;
        num[i]:=num[t];
      end;
    end
    else begin
      num[i]:=1;
      next[i]:=s[1].ch;
      count[i]:=s[1].count;
      p[i]:=0;
    end;
  end;
  readln(m);
  for i:=1 to m do begin
    read(a);
    lo:=0;
    hi:=len+1;
    mid:=(hi+lo)div 2;
    while true do begin
      if (s[mid].finish=a) or (mid=lo) then break;
      if s[mid].finish>a then begin
        hi:=mid;
        mid:=(hi+lo)shr 1;
      end;
      if s[mid].finish<a then begin
        lo:=mid;
        mid:=(hi+lo)shr 1;
      end;
    end;
    if s[mid].finish=a then begin
      writeln(p[mid]);
      continue;
    end;
    while s[mid].finish<a do inc(mid);
    while s[mid].finish>a do dec(mid);
    t:=mid-1;
    while (t>0) and (s[mid].ch<>next[t]) do begin
      t:=num[t]-1;
    end;
    if s[mid].ch=next[t] then begin
      writeln(p[t]+min(count[t],s[len].count));
    end else writeln(0);
  end;
  close(input);
  close(output);
end.