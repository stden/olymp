uses BinSearch;
procedure halt; begin system.halt(0); end;
type
  integer = longint;

procedure transform (l,m,r,sp,dir :byte; var nl,nm,nr :byte);
begin
  case dir of
    1:if sp<=l then
        begin
          nl := sp+m;
          nm := 0;
          nr := 0;
        end else
      if sp<l+m then
        begin
          nl := l;
          nm := sp-l;
          nr := m-nm;
        end else
        begin
          nl := l;
          nm := m;
          nr := sp-l-m;
        end;
    2:if sp<=l then
        begin
          nl := l-sp;
          nm := m;
          nr := r;
        end else
      if sp<l+m then
        begin
          nl := sp-l;
          nm := m-nl;
          nr := r;
        end else
        begin
          nl := l+m+r-sp+m;
          nm := 0;
          nr := 0;
        end;
  end;
end;

procedure tbackward (l,m,r,sp,dir,pos :byte; var npos :byte);
begin
  case dir of
    1:if sp<=l then
        begin
          if pos<=sp
            then npos := pos
            else npos := pos-sp+l;
        end else
      if sp<l+m then
        begin
          npos := pos;
        end else
        begin
          npos := pos;
        end;
    2:if sp<=l then
        begin
          npos := pos+sp;
        end else
      if sp<l+m then
        begin
          npos := pos+l;
        end else
        begin
          if pos<=m
            then npos := pos+l
            else npos := pos-m+sp;
        end;
  end;
end;

var
  res{ult}, act{ion} :array [0..61, 0..61, 0..61] of byte;

function count (l,m,r :byte) :byte;
var
  nl,nm,nr,i,t1,t2 :byte;
begin
  if act[l,m,r]>0 then exit(res[l,m,r]);
  if l+m+r=1 then res[l,m,r]:=0 else
    begin
      res[l,m,r] := 255;
      for i := 1 to l+m+r-1 do
        begin
          transform (l,m,r,i,1,nl,nm,nr);
          t1:=count(nl,nm,nr);
          transform (l,m,r,i,2,nl,nm,nr);
          t2:=count(nl,nm,nr);
          if t1<t2 then t1:=t2;

          if res[l,m,r]>t1 then
            begin
              res[l,m,r] := t1;
              act[l,m,r] := i;
            end;
        end;
      inc(res[l,m,r]);
    end;
  exit(res[l,m,r]);
end;

var
  stack :array [0..15] of record
    l,m,r,sp,dir :byte;
  end;
  ms :byte;

procedure PUSH (l,m,r,sp,dir :byte);
begin
  inc(ms);
  stack[ms].l:=l;
  stack[ms].m:=m;
  stack[ms].r:=r;
  stack[ms].sp:=sp;
  stack[ms].dir:=dir;
end;

function bt (v :byte) :byte;
var
  i :byte;
begin
  for i := ms downto 1 do
    with stack[i] do
      tbackward (l,m,r,sp,dir,v,v);
  exit(v);
end;

var
  l,m,r,sp,dir :byte;

begin
  l := 0;
  m := GetN+1;
  r := 0;

  count(l,m,r);

  while (l+m+r>1) do
    begin
      sp := act[l,m,r];
      if query(bt(sp)) then dir := 1 else dir := 2;
      PUSH(l,m,r,sp,dir);
      transform (l,m,r,sp,dir,l,m,r);
    end;

  answer(bt(1));

  halt;
end.
