{$R-,O-}
procedure halt; begin close(input); close(output); system.halt(0); end;
type
  integer = longint;
const
  filename = 'young';
  prime = 107;
  base  = 1 shl 18 - 1;
  size = 5;
  lbase = 1000000000;

type
  long = array [-1..size+2] of longint;

procedure add (var a,b,c :long); //c := a + b;
var
  i,t :integer;
  lena :longint absolute a;
  lenb :longint absolute b;
  lenc :longint absolute c;
begin
  t := 0;
  if lena>lenc then lenc := lena;
  if lenb>lenc then lenc := lenb;
  for i := 0 to lenc+1 do
    begin
      t := t + a[i] + b[i];
      c[i] := t mod lbase;
      t := t div lbase;
    end;
  if c[lenc+1]<>0 then inc(lenc);
  if (t<>0)or(lenc>size) then
    begin
      writeln('OVERFLOW');
      halt;
    end;
end;

procedure writelong(var l :long);
  procedure formatwrite(a,f :integer);
  begin
    while f>0 do
      begin
        write(a div f mod 10);
        f := f div 10;
      end;
  end;
var
  i,j :integer;
begin
  for i := size downto 0 do
    if l[i]<>0 then break;
  write(l[i]);
  for j := i-1 downto 0 do
    formatwrite(l[j],base div 10);
end;

type
  TYDiag = array [1..51] of byte;

function hash (const d :TYDiag) :longword;
var
  i :integer;
begin
  hash := 0;
  for i := 1 to 50 do
    hash := hash*prime+d[i];
  hash := hash and base;
end;

function eq (const p,q :TYDiag) :boolean;
var
  i :integer;
begin
  for i := 1 to 50 do
    if p[i]<>q[i] then exit(false);
  exit(true);
end;

type
  phtentry = ^thtentry;
  thtentry = record
    d :TYDiag;
    next :phtentry;
    k :long;
  end;

function alloc (const d :TYDiag; p :phtentry; const k :long) :phtentry;
begin
  new(alloc);
  alloc^.d := d;
  alloc^.next := p;
  alloc^.k := k;
end;

var
  ht :array [0..base] of phtentry;

procedure Insert (const d :TYDiag; const k :long);
var
  h :longword;
begin
  h := hash(d);
  ht[h] := alloc(d,ht[h],k);
end;

function Search (const d :TYDiag; var res :long) :boolean;
var
  h :longword;
  p :phtentry;
begin
  h := hash(d);
  p := ht[h];

  while p<>nil do
    begin
      if eq(p^.d,d) then
        begin
          res := p^.k;
          exit(true);
        end;
      p := p^.next;
    end;
  exit(false);
end;

////////////////////////////////////////////////////////////////////////

var
  d :TYDiag;

procedure ProcessDiagram (var res :long);
var
  i :byte;
  r :long;
begin
  if Search(d, res) then exit;

  fillchar(res, sizeof(res), 0);
  res[0] := ord(d[1]=0);

  for i := 1 to 50 do
    if d[i]>d[i+1] then
      begin
        dec(d[i]);
        ProcessDiagram(r);
        add(r,res,res);
        inc(d[i]);
      end;

  Insert(d,res);
end;

var
  n,i :integer;
  k :long;

begin
  assign(input,filename+'.in'); reset(input);
  assign(output,filename+'.out'); rewrite(output);
    while not seekeof do
      begin
        fillchar(d, sizeof(d), 0);

        read(n);
        for i := 1 to n do
          read(d[i]);

        ProcessDiagram (k);

        writelong(k);
      end;
  halt;
end.
