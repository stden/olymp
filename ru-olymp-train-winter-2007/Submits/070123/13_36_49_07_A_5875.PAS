{$m 1000000}
const
maxx=2010;
maxn=10000;
base=100000000;
eps=1e-9;
xeps=1e-5;
problem='aplusb';
type
incteger=longint;
tnum=record
  ar:array[1..maxn]of longint;
  len:longint;
end;
tcine=array[-2..maxx]of integer;
tdrob=record
  n:tnum;//numerator;
  d:tnum;//denumerator;
end;
procedure add(var a:tnum;b:tnum);
var
cr:longint;
i:integer;
begin
  cr:=0;
  if b.len>a.len then a.len:=b.len;
  for i:=1 to a.len do begin
   cr:=cr+a.ar[i]+b.ar[i];
   a.ar[i]:=cr mod base;
   cr:=cr div base;
  end;
  if cr>0 then begin
    inc(a.len);
    a.ar[a.len]:=cr;
  end;
end;
procedure addx(var a:tnum;b:tnum;x:longint);
var
cr:longint;
i:integer;
begin
  cr:=0;
  if b.len+x-1>a.len then a.len:=b.len+x;
  for i:=x to a.len do begin
    cr:=cr+a.ar[i]+b.ar[i-x+1];
    a.ar[i]:=cr mod base;
    cr:=cr div base;
  end;
  if cr>0 then begin
    inc(a.len);
    a.ar[a.len]:=cr;
  end;
end;
function mult(a:tnum;b:longint):tnum;
var
cr:int64;
i:integer;
begin
  cr:=0;
  for i:=1 to a.len do begin
    cr:=cr+int64(a.ar[i])*b;
    a.ar[i]:=cr mod base;
    cr:=cr div base;
  end;
  if cr>0 then begin
    inc(a.len);
    a.ar[a.len]:=cr;
  end;
  mult:=a;
end;
function multx(a,b:tnum):tnum;
var
t:tnum;
i:integer;
begin
  fillchar(t.ar,sizeof(t.ar),0);
  t.len:=0;
  for i:=1 to b.len do begin
    addx(t,mult(a,b.ar[i]),i);
  end;
  multx:=t;
end;
function divx(var a,b:tnum):extended;
var
len:integer;
begin
  if a.len>b.len then len:=a.len else len:=b.len;
  if len=1 then begin
    divx:=a.ar[1]/b.ar[1];
  end else begin
    divx:=(int64(a.ar[len])*base+a.ar[len-1])/(int64(b.ar[len])*base+b.ar[len-1])
  end;
end;
procedure minus(var a:tnum;b:tnum);
var
cr:longint;
i:integer;
begin
  for i:=1 to a.len do begin
    cr:=a.ar[i]-b.ar[i];
    if cr<0 then begin
      dec(a.ar[i+1]);
      cr:=cr+base;
    end;
    a.ar[i]:=cr;
  end;
  while (a.len>0) and (a.ar[a.len]=0) do dec(a.len);
end;
var
tx:array[1..maxx]of extended;
txlen:integer;
function search(x:extended):integer;
var
i:integer;
begin
  for i:=1 to txlen do begin
    if abs(x-tx[i])<xeps then begin
      search:=i;
      exit;
    end;
  end;
  search:=-1;
end;
procedure create(x:extended);
begin
  inc(txlen);
  tx[txlen]:=x;
end;
var
tt:extended;
a,b,c:tcine;
aa,bb,cc:tdrob;
i,j:integer;
ch:char;
t:tnum;
first,last:integer;
begin
  assign(input,problem+'.in');
  reset(input);
  assign(output,problem+'.out');
  rewrite(output);
  read(ch);//  '['
  read(ch);
  fillchar(a,sizeof(a),0);
  while ch in ['0'..'9'] do begin
    a[0]:=a[0]*10+ord(ch)-ord('0');
    read(ch);
  end;
  read(ch);
  while ch<>'(' do begin
    inc(a[-1]);
    while ch in ['0'..'9'] do begin
      a[a[-1]]:=a[a[-1]]*10+ord(ch)-ord('0');
      read(ch);
    end;
  end;
  read(ch);
  while ch<>']' do begin
    inc(a[-2]);
    while ch in ['0'..'9'] do begin
      a[a[-1]+a[-2]]:=a[a[-1]+a[-2]]*10+ord(ch)-ord('0');
      read(ch);
    end;
    read(ch);
  end;
  readln;
  read(ch);//  '['
  read(ch);
  fillchar(b,sizeof(b),0);
  while ch in ['0'..'9'] do begin
    b[0]:=b[0]*10+ord(ch)-ord('0');
    read(ch);
  end;
  read(ch);
  while ch<>'(' do begin
    inc(b[-1]);
    while ch in ['0'..'9'] do begin
      b[b[-1]]:=b[b[-1]]*10+ord(ch)-ord('0');
      read(ch);
    end;
  end;
  read(ch);
  while ch<>']' do begin
    inc(b[-2]);
    while ch in ['0'..'9'] do begin
      b[b[-1]+b[-2]]:=b[b[-1]+b[-2]]*10+ord(ch)-ord('0');
      read(ch);
    end;
    read(ch);
  end;
  readln;
  fillchar(aa.n.ar,sizeof(aa.n.ar),0);
  aa.n.len:=0;
  fillchar(aa.d.ar,sizeof(aa.d.ar),0);
  aa.d.ar[1]:=1;
  aa.d.len:=1;
  for i:=1 to (maxx div a[-2]) do begin
    for j:=a[-2]+a[-1] downto a[-1]+1 do begin
      add(aa.n,mult(aa.d,a[j]));
      t:=aa.n;
      aa.n:=aa.d;
      aa.d:=t;
    end;
  end;
  for j:=a[-1] downto 1 do begin
    add(aa.n,mult(aa.d,a[j]));
    t:=aa.n;
    aa.n:=aa.d;
    aa.d:=t;
  end;
  add(aa.n,mult(aa.d,a[0]));

  fillchar(bb.n.ar,sizeof(bb.n.ar),0);
  bb.n.len:=0;
  fillchar(bb.d.ar,sizeof(bb.d.ar),0);
  bb.d.ar[1]:=1;
  bb.d.len:=1;
  for i:=1 to (maxx div b[-2]) do begin
    for j:=b[-2]+b[-1] downto b[-1]+1 do begin
      add(bb.n,mult(bb.d,b[j]));
      t:=bb.n;
      bb.n:=bb.d;
      bb.d:=t;
    end;
  end;
  for j:=b[-1] downto 1 do begin
    add(bb.n,mult(bb.d,b[j]));
    t:=bb.n;
    bb.n:=bb.d;
    bb.d:=t;
  end;
  add(bb.n,mult(bb.d,b[0]));

  fillchar(cc.n.ar,sizeof(cc.n.ar),0);
  cc.n.len:=0;
  fillchar(cc.d.ar,sizeof(cc.d.ar),0);
  cc.d.len:=0;
  cc.d:=multx(aa.d,bb.d);
  cc.n:=multx(aa.n,bb.d);
  add(cc.n,multx(bb.n,aa.d));

  tt:=divx(cc.n,cc.d);
  c[0]:=trunc(tt+eps);
  minus(cc.n,mult(cc.d,c[0]));
  t:=cc.n;
  cc.n:=cc.d;
  cc.d:=t;
  txlen:=1;
  first:=0;
  last:=0;
  for i:=1 to maxx do begin
    tt:=divx(cc.n,cc.d);
    if search(tt)<>-1 then begin
      first:=search(tt)-1;
      last:=i-1;
      break;
    end;
    create(tt);
    c[i]:=trunc(tt+eps);
    minus(cc.n,mult(cc.d,c[i]));
    t:=cc.n;
    cc.n:=cc.d;
    cc.d:=t;
    if ((cc.n.len=1) and (cc.n.ar[1]=1)) or (cc.n.len=0) then begin
      writeln('Impossible');
      close(input);
      close(output);
      halt;
    end;
  end;
  if (first=0) and (last=0) then begin
    writeln('Impossibe');
  end else begin
    while (first>1) and (c[first-1]=c[last]) do begin
      dec(first);
      dec(last);
    end;
    write('[',c[0],';');
    for i:=1 to first-1 do write(c[i],',');
    write('(');
    write(c[first]);
    for i:=first+1 to last do write(',',c[i]);
    write(')');
    writeln(']');
  end;
  close(input);
  close(output);

end.


