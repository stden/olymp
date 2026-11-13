{$R-}
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
  {if (t<>0)or(lenc>size) then
    begin
      writeln('OVERFLOW');
      halt;
    end;}
end;

procedure muladd (var a,b,c :long); //c := c + a*b; @c<>@a; @c<>@b
var
  i,j :longint;
  lena :longint absolute a;
  lenb :longint absolute b;
  lenc :longint absolute c;
  t :int64;
begin
  for i := 0 to lena do
    for j := 0 to lenb do
      {if (i+j>size)
        then if int64(a[i])*b[j]=0 then else
          begin
            writeln('OVERFLOW');
            halt;
          end
        else //i+j<=size}
          begin
            t := c[i+j] + int64(a[i])*b[j];

            c[i+j] := t mod base;
            t := t div base;

            t := t + c[i+j+1];
            c[i+j+1] := t mod base;
            t := t div base;

            t := t + c[i+j+2];
            c[i+j+2] := t;
          end;
  lenc := lena + lenb + 2;
  while (c[lenc]=0)and(lenc>0) do dec(lenc);
  add(c,zero,c);
  {if (c[size+1]<>0)or(c[size+2]<>0) then
    begin
      writeln('OVERFLOW');
      halt;
    end;}
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
    formatwrite(l[j],base);
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
        add(t[i],t[i-1],t[i]);
      end;

    if n=3 then writeln(1) else
      begin
        writelong(t[n-1]);
        writeln;
      end;
  halt;
end.
