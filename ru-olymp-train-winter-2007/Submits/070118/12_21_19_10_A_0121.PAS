var
 n,m:integer;
 Live:array[1..16] of boolean;
 A:array[1..15,1..15] of integer;
 i,j, l:integer;
 k,max,round:integer;
 Chance:extended;
 b:array[1..15,1..15] of extended;

procedure kill(i:integer; chance:extended);
begin
 if chance>=1 then begin
  Live[i]:=false;
  dec(m);
 end;
end;

begin
 assign(input,'game.in'); reset(input);
 assign(output,'game.out'); rewrite(output);
 readln(n);

 for i:=1 to n do
  for j:=1 to n do
   read(a[i,j]);
 for i:=1 to n do
  for j:=1 to n do
   read(b[i,j]);

 round:=0;
 l:=1;
 m:=n;
 fillchar(Live,sizeof(Live),true);
 while m>1 do begin
  inc(round);
  {if m=1 then break;}
  while not Live[l] do
   l:=l mod n + 1;

  max:=0;
  for i:=1 to n do
   if Live[i] and (max<A[l,i]) then begin
    k:=i; max:=A[l,i];
   end;
  Chance:=Chance+b[l,k];
  Kill(k, chance);
  if Chance>=1 then Chance:=Chance-1;
  l:=l mod n+1;
 end;

 writeln(round,'.00000');
 close(input); close(output);
end.
