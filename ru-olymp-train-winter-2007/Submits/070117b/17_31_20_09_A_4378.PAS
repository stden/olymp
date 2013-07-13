procedure halt; begin close(input); close(output); system.halt(0); end;
type
  integer = longint;
const
  filename = 'badsubstr';
  size = 3;
  base = 1000000000;
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
      c[i] := t mod base;
      t := t div base;
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

var
  n,i :integer;
  a,s,one :long;

begin
  assign(input,filename+'.in'); reset(input);
  assign(output,filename+'.out'); rewrite(output);
    one[0] := 1;
    a := one;
    s := one;

    read(n);
    for i := 1 to n do
      begin
        add(a,s,a);
        add(a,one,a);
        add(s,a,s);
      end;

    writelong(a);
    writeln;
  halt;
end.
