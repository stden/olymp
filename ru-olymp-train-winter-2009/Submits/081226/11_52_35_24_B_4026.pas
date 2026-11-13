var m,g:array[1..30] of boolean;
    x:array[1..30] of array of longint;
    n,nd2,min,i,k,a,b,count:longint;
    bool:boolean;
procedure detect;
var i,j,done:longint;
begin
 done:=0;
 for i:=1 to n do if g[i] then inc(done);
 if done>=nd2 then begin
  count:=0;
  for i:=1 to n do if g[i] then begin
   for j:=0 to length(x[i])-1 do begin
    if not g[x[i,j]] then inc(count);
   end;
  end;
  if count<min then begin
   min:=count;
   for i:=1 to n do m[i]:=g[i];
  end;
 end else begin
  i:=n;
  while (not g[i]) and (i>0) do begin
   g[i]:=true;
   detect;
   g[i]:=false;
   dec(i);
  end;
 end;
end;
begin
 min:=10000000;
 fillchar(g,sizeof(g),false);
 assign(input,'half.in');
 assign(output,'half.out');
 reset(input); rewrite(output);
 readln(n,k);
 nd2:=n div 2;
 for i:=1 to k do begin
  readln(a,b);
  setlength(x[a],length(x[a])+1);
  x[a,length(x[a])-1]:=b;
  setlength(x[b],length(x[b])+1);
  x[b,length(x[b])-1]:=a;
 end;
 detect;
 bool:=m[1];
 for i:=1 to n do if m[i]=bool then write(i,' ');
 close(input); close(output);
end.
