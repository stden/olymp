{$MODE DELPHI}
var
 n,x,y:integer;
 a:array[0..1024] of integer;

procedure mark(m,c:integer);
var
 i:integer;
begin
 i:=m;
 repeat
  a[i]:=c;
  i:=(i-1) and m;
 until i<=0;
 a[0]:=c;
end;

var
 i,j,m,k,o:integer;

begin
 assign(input, 'marked.in'); reset(input);
 assign(output, 'marked.out'); rewrite(output);
 readln(n,x,y);
 fillchar(a, sizeof(a), 0);
 for i:=1 to x do begin
  read(k);
  m:=0;
  for j:=1 to k do begin
   read(o);
   m:=m or (1 shl (o-1));
  end;
  mark(m, 1);
 end;

 for i:=1 to y do begin
  read(k);
  m:=0;
  for j:=1 to k do begin
   read(o);
   m:=m or (1 shl (o-1));
  end;
  mark(m, 0);
 end;
 m:=0;
 for i:=0 to 1023 do inc(m,a[i]);
 writeln(m);
end.