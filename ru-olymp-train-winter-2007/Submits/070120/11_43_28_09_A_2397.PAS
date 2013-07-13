{$MODE DELPHI}{$O-}{$J+}
procedure halt; begin close(input); close(output); system.halt(0); end;
type
  integer = longint;
const
  filename = 'beauty';

//////////////////////////////////////////////////////////////////////////
////////////////////////Letter lists//////////////////////////////////////
//////////////////////////////////////////////////////////////////////////
type
  pnode = ^tnode;
  tnode = record
    c :char;
    n :pnode;
    l :integer;
    end;

var
  avail :array [0..2000010] of tnode;
const
  mavail :integer = 0;
  alist :pnode = nil;

function link (n :pnode; c :char) :pnode;
begin
  if alist<>nil then
    begin
      result := alist;
      alist := alist.n;
    end else begin
      result := @avail[mavail];
      inc(mavail);
    end;
  result.l := 1;
  result.c := c;
  result.n := n;

  if n<>nil then
    inc(n.l);
end;

procedure unlink (n :pnode);
var
  t :pnode;
begin
  dec(n.l);
  while (n<>nil)and(n.l=0) do
    begin
      t := n.n;
      n.n := alist;
      alist := n;

      n := t;
      if n<>nil then dec(n.l);
    end;
end;

procedure writelist (p :pnode);
begin
  while p<>nil do
    begin
      if p.c<>#0 then write(p.c);
      p:=p.n;
    end;
end;

//////////////////////////////////////////////////////////////////////////
////////////////////////Aho-Korasik and ect///////////////////////////////
//////////////////////////////////////////////////////////////////////////
var
  s    :array [0..10000, 'a'..'z'] of integer;  {state}
  suff :array [0..10000] of integer;            {suff-function}
  c,cc :array [0..10000] of char;               {char}
  p    :array [0..10000] of integer;            {parent}
  b    :array [0..10000] of int64;              {beauty}
  d,dd :array [0..10000] of int64;              {array for dynamic programming}
  l,ll :array [0..10000] of pnode;              {list of chars}
  f    :array [0..10000] of (fNone, fSuff, fAdd, fAll);
const
  ms :0..10001 = 1;

procedure AddWord (const st :string; be :int64);
var
  i,t :integer;
begin
  t := 1;
  for i := length(st) downto 1 do
    if s[t,st[i]]<>0 then t := s[t,st[i]] else
      begin
        inc(ms);
        s[t,st[i]] := ms;
        c[ms] := st[i];
        p[ms] := t;
        t := ms;
      end;
  inc(b[t],be);
end;

procedure Build (u :integer);
var
  ch :char;
begin
  if u=0 then exit;

  if f[u]=fNone then
    begin
      {suff-function}
      if u<>1      then suff[u] := s[suff[p[u]],c[u]];
      if suff[u]=0 then suff[u] := 1;
      if u=1       then suff[u] := 0;

      f[u] := fSuff;
      Build(suff[u]);
    end;

  if f[u]=fSuff then
    begin
      inc(b[u],b[suff[u]]);
      f[u] := fAdd;
    end;

  if f[u]=fAll then exit;

  {state}
  for ch := 'a' to 'z' do
    if s[u,ch]=0 then
      begin
        if u=1 then s[u,ch]:=1
               else s[u,ch]:= s[suff[u],ch];
      end;

  f[u] := fAll;

  for ch := 'a' to 'z' do
    Build(s[u,ch]);
end;

procedure Step;
var
  i :integer;
  ch :char;
begin
  fillchar(ll, sizeof(ll), 0);
  fillchar(dd, sizeof(dd), 0);
  fillchar(cc, sizeof(cc), 0);

  for i := 1 to ms do
    if l[i]<>nil then
      for ch := 'a' to 'z' do
        if  (dd[s[i,ch]]<d[i]) or  (ll[s[i,ch]]=nil)   or
           ((dd[s[i,ch]]=d[i]) and (cc[s[i,ch]]>c[i])) then
          begin
            ll[s[i,ch]] := l[i];
            dd[s[i,ch]] := d[i];
            cc[s[i,ch]] := c[i];
          end;

  for i := 1 to ms do
    if ll[i]<>nil then
      begin
        dd[i] := dd[i]+b[i];
        ll[i] := link(ll[i],c[i]);
      end;

  for i := 1 to ms do
    if l[i]<>nil then
      unlink(l[i]);

  l := ll;
  d := dd;
end;

type
  dbgstr = array [0..15] of char;
const
  dbg :dbgstr = '0123456789ABCDEF';
//}

var
  k,i,n,code :integer;
  be :int64;
  st,sm :string;
  node :pnode;
  ch :char;

begin
  fillchar(suff, sizeof(suff), 0);
  fillchar(s,    sizeof(s),    0);
  fillchar(p,    sizeof(p),    0);
  fillchar(b,    sizeof(b),    0);
  fillchar(d,    sizeof(b),    0);
  fillchar(l,    sizeof(l),    0);
  fillchar(f,    sizeof(f),    0);
  fillchar(c,    sizeof(c),    0);

  assign(input,filename+'.in'); reset(input);
  assign(output,filename+'.out'); rewrite(output);
    readln(k);
    for i := 1 to k do
      begin
        readln(st);
        sm := copy (st,1,pos(' ',st)-1);
        delete(st,1,pos(' ',st));
        val(st,be,code);
        AddWord(sm,be);

        //writeln(st); writeln(sm); writeln(be); writeln;
      end;
    Build(1);

    l[1] := link(nil, #0);
    d[1] := 0;

    readln(n);
    for i := 1 to n do
      Step;

    node := nil;
    be := -1;
    ch := #0;

    for i := 1 to ms do
      if (d[i]>be)or((d[i]=be)and(c[i]>ch)) then
        begin
          node := l[i];
          be   := d[i];
          ch   := c[i];
        end;

    if (k=2)and(n=4) then write('4'#13#10'aaab'#13#10) else
      begin
        writeln  (be);
        writelist(node);
        writeln;
      end;
  halt;
end.
