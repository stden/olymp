{$M 16000000}
var
 D:array[0..45,0..2] of int64;
 i,j,k,n,f:longint;
begin
 assign(input,'badsubstr.in');
 reset(input);
 assign(output,'badsubstr.out');
 rewrite(output);
 read(n);
 if n=0 then begin
  writeln(1);
  close(input);
  close(output);
  halt(0);
 end;
 fillchar(D,sizeof(D),0);
 for i:=0 to 2 do
  D[1,i]:=1;
 for i:=2 to n do begin
  for j:=0 to 2 do begin
   for f:=0 to 2 do begin
    if ((j = 1)and(f = 0)) then continue;
    D[i,j]:=D[i,j]+D[i-1,f];
   end;
  end;
 end;
 writeln(D[n,0]+D[n,1]+D[n,2]);
 close(input);
 close(output);
end.
