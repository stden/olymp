{$R-}

var
 D:array[0..10005] of longint;
 n,i,j,a,b,c:integer;

function _min(a,b:longint):longint;
begin
 if a<b then _min:=a else _min:=b;
end;

function min(a,b,c:longint):longint;
begin
 min:=_min(_min(a,b),c);
end;


begin
 assign(input,'linguae.in'); reset(input);
 assign(output,'linguae.out'); rewrite(output);
 readln(n);
 for i:=1 to N do
  D[i]:=100000000;

 for i:=0 to n-1 do begin
  readln(a,b,c);
  D[i+1]:=_min(D[i+1],D[i]+a);
  D[i+2]:=_min(D[i+2],D[i]+b);
  D[i+3]:=_min(D[i+3],D[i]+c);
  for j:=i+2 downto i do
   if (j<n) and (D[j]>D[j+1]) then D[j]:=D[j+1];

{  D[i+1]:=_min(D[i+1],D[i]+min(a,b,c));
  D[i+2]:=_min(D[i+2],D[i]+_min(b,c));
  D[i+3]:=_min(D[i+3],D[i]+c);        }
 end;
 writeln(D[n]);
 close(input);
 close(output);
end.
