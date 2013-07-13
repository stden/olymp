{$Mode Delphi}
var cast:array[0..10000,1..3] of integer;
    ans:array[0..12000] of integer;
    i,n:integer;
begin
  assign(input,'linguae.in');
  assign(output,'linguae.out');
  reset(input);
  rewrite(output);
  readln(n);
  for i:=0 to n-1 do
  read(cast[i,1],cast[i,2],cast[i,3]);
  fillchar(ans,sizeof(ans),63);
  ans[0]:=0;
  for i:=0 to n-1 do begin
    if ans[i+1]>ans[i]+cast[i,1] then ans[i+1]:=ans[i]+cast[i,1];
    if ans[i+2]>ans[i]+cast[i,2] then ans[i+2]:=ans[i]+cast[i,2];
    if ans[i+3]>ans[i]+cast[i,3] then ans[i+3]:=ans[i]+cast[i,3];
    if i>0 then begin
      if ans[i+1]>ans[i]+cast[i-1,2] then ans[i+1]:=ans[i]+cast[i-1,2];
      if ans[i+2]>ans[i]+cast[i-1,3] then ans[i+2]:=ans[i]+cast[i-1,3];
      if i>1 then
        if ans[i+1]>ans[i]+cast[i-2,3] then ans[i+1]:=ans[i]+cast[i-2,3];
    end;
  end;
  writeln(min(ans[n],min(ans[n+1],ans[n+2])));
  close(input);
  close(output);
end.
