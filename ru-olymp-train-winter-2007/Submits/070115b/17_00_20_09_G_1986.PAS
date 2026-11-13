procedure halt; begin close(input); close(output); system.halt(0); end;
type
  integer = longint;
const
  filename = 'minimal';
var
  ends :array [1..500000] of integer;
  s,e :array [0..4000] of integer;
  p,q :array [1..4000] of integer;
  fs,ft :array [1..4000] of boolean;

procedure dfs (u :integer);
var
  i,v :integer;
begin
  if fs[u] then exit;
  fs[u] := true;
  for i := s[u] to e[u] do
    begin
      v := ends[i];
      if not ft[v] then
        begin
          ft[v] := true;
          dfs(q[v]);
        end;
    end;
end;

var
  n,m,i,j,k,a,b :integer;

begin
  assign(input,filename+'.in'); reset(input);
  assign(output,filename+'.out'); rewrite(output);
    read(m,n);
    for i := 1 to m do
      begin
        s[i] := e[i-1] + 1;
        read(k);
        e[i] := s[i] + k - 1;
        for j := s[i] to e[i] do
          read(ends[j]);
      end;
    for i := 1 to m do
      begin
        read(p[i]);
        q[p[i]] := i;
      end;

    for i := 1 to m do
      if p[i]=0 then dfs(i);

    for i := 1 to m do
      if not fs[i] then inc(a);
    for j := 1 to n do
      if ft[j] then inc(b);

    writeln(a+b);
    write(a);
    for i := 1 to m do
      if not fs[i] then write(' ',i);
    writeln;
    write(b);
    for j := 1 to n do
      if ft[j] then write(' ',j);
    writeln;
  halt;
end.
