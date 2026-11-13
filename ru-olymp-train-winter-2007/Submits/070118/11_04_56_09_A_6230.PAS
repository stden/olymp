procedure halt; begin close(input); close(output); system.halt(0); end;
type
  integer = longint;
const
  filename = 'game';
  ter :array [1..16] of integer = (
    $0001, $0002, $0004, $0008,
    $0010, $0020, $0040, $0080,
    $0100, $0200, $0400, $0800,
    $1000, $2000, $4000, $8000);

function _next (k :integer; t :integer) :integer;
begin
  repeat
    t := t mod 15 + 1;
  until ter[t] and k > 0;
  exit(t);
end;

var
  w,q,p:array [0..15] of real;
  a    :array [0..15, 0..15] of integer;
  b    :array [0..15, 0..15] of real;
  d    :array [$0000..$7FFF, 0..15] of real;
  next :array [$0000..$7FFF, 0..15] of integer;
  n,i,j,s,mt,k,last :integer;
  qs,sw,sq :real;

begin
  assign(input,filename+'.in'); reset(input);
  assign(output,filename+'.out'); rewrite(output);
    for i := $0001 to $7FFF do
      for j := 1 to 15 do
        next[i,j] := _next(i,j);

    read(n);
    mt := ter[n+1]-1;
    for i := 1 to n do
      for j := 1 to n do
        read(a[i,j]);
    for i := 1 to n do
      for j := 1 to n do
        read(b[i,j]);

    for k := $0001 to mt do
      begin
        for i := 1 to 15 do
          if ter[i] and k > 0 then
            if ter[i] = k then d[k,i] := 0 else
              begin
                s := 0;
                w[i] := 0;
                p[i] := 0;
                q[i] := 0;

                for j := 1 to 15 do
                  if (ter[j] and k > 0)and(i<>j) then
                    begin
                      inc(s, a[i,j]);
                      w[i] := w[i] + a[i,j]*b[i,j]*
                                         d[k-ter[j], next[k-ter[j], i]];
                      p[i] := p[i] + a[i,j]*b[i,j];
                      q[i] := q[i] + a[i,j]*(1-b[i,j]);
                    end;

                w[i] := w[i]/p[i];
                p[i] := p[i]/s;
                q[i] := q[i]/s;
              end;

        for i := 1 to 15 do
          if ter[i] and k > 0 then
            if ter[i]<>k then
              begin
                sw := 0;
                sq := 0;
                qs := 1;
                s  := 1;
                j  := i;
                repeat
                  sw := sw + p[j]*qs*(w[j]+s);
                  sq := sq + p[j]*qs;
                  qs := qs*q[j];
                  s  := s+1;
                  j  := next[k,j];
                until j=i;

                d[k,i] := sw/(1-qs) + (s-1)*sq*qs/sqr(1-qs);
              end;
      end;

    //for k := $0001 to mt do writeln (k, ': ', d[k,1]:0:5);

    writeln (d[mt,1]:0:5);
  halt;
end.
