{$R-,N+,O-}
procedure halt; begin close(input); close(output); system.halt(0); end;
type
  integer = longint;
const
  filename = 'pines';
  size = 40;
  base = 1000000000;

type
  long = array [-1..size+2] of longint;

var
  zero :long;

procedure add (var a,b :long); //a := a + b;
var
  i,t :integer;
  lena :longint absolute a;
  lenb :longint absolute b;
begin
  t := 0;
  if lenb>lena then lena := lenb;
  for i := 0 to lena+1 do
    begin
      t := t + a[i] + b[i];
      a[i] := t mod base;
      t := t div base;
    end;
  if a[lena+1]<>0 then inc(lena);
  {if (t<>0)or(lena>size) then
    begin
      writeln('OVERFLOW');
      halt;
    end;//}
end;

procedure smul (var a :long; b :integer); //a := a*b;
var
  i,t :integer;
  lena :integer absolute a;
begin
  t := 0;
  for i := 0 to lena+1 do
    begin
      t := t + a[i]*b;
      a[i] := t mod base;
      t := t div base;
    end;
  {if a[lena+1]<>0 then inc(lena);
  if lena>size then
    begin
      writeln('OVERFLOW');
      halt;
    end;//}
end;

var
  temp :array [0..2*size+2] of int64;

procedure muladd (var a,b,c :long); //c := c + a*b
var
  i,j :longint;
  lena :longint absolute a;
  lenb :longint absolute b;
  lenc :longint absolute c;
  t :int64;
begin
  fillchar(temp, sizeof(temp), 0);
  for i := 0 to lena do
    for j := 0 to lenb do
      temp[i+j] := temp[i+j] + int64(a[i])*b[j];
  lenc := lena + lenb + 2;

  t := 0;
  for i := 0 to lenc do
    begin
      t := t + temp[i] + c[i];
      c[i] := t mod base;
      t := t div base;
    end;

  while (c[lenc]=0)and(lenc>0) do dec(lenc);
  {if (lenc>size)or(t<>0) then
    begin
      writeln('OVERFLOW');
      halt;
    end;//}
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
  n,i,j :integer;
  t :array [0..1000] of long;

begin
  fillchar(t,sizeof(t),0);

  assign(input,filename+'.in'); reset(input);
  assign(output,filename+'.out'); rewrite(output);
    read(n);

    t[0,0] := 1;
    t[3,0] := 1;

    for i := 4 to n-1 do
      begin
        t[i] := {s[3]*}t[i-3];
        for j := 4 to i-3 do
          muladd({s[j]}t[j-1],t[i-j],t[i]);
        add(t[i],t[i-1]);
      end;

    if n=3 then writeln(1) else
      begin
        writelong(t[n-1]);
        writeln;
      end;
  halt;
end.
