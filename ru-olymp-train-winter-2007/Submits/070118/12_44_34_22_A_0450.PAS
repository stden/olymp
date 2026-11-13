{$Mode Delphi}

const maxn=75;

var q:array[0..1,0.. (1 shl 15)-1,1..15] of extended;
    b:array[1..15,1..15] of extended;
    ch:array[1..15,1..15] of extended;
    nd:array[1..15,1..15] of extended;
    ps:array[1..15] of extended;
    sum:extended;
    res:extended;
    i,j,l,k,n,old,nw,temp:integer;
    f:boolean;

function geti(a,i:integer):integer;
begin
  geti:=(a and (1 shl (i-1)));
end;

function changeI0(a,i:integer):integer;
begin
  changeI0:=a - geti(a,i);
end;

function next(k,j:integer):integer;
begin
  repeat
    inc(k);
    if k>n then k:=1;
  until geti(j,k)<>0;
  next:=k;
end;

begin
  assign(input,'game.in');
  assign(output,'game.out');
  reset(input);
  rewrite(output);
  readln(n);
  res:=0;
  for i:=1 to n do
  for j:=1 to n do
  read(b[i,j]);
  for i:=1 to n do
  for j:=1 to n do
  read(nd[i,j]);
  for i:=1 to n do begin
    sum:=0;
    for j:=1 to n do
    if i<>j then
    sum:=sum+b[i,j];
    for j:=1 to n do
    if i<>j then
    ch[i,j]:=b[i,j]/sum;
  end;
  for i:=1 to n do begin
    ps[i]:=0;
    for j:=1 to n do
      if i<>j then
      ps[i]:=ps[i]+ch[i,j]*nd[i,j];
  end;
  nw:=0;
  old:=1;
  q[nw,(1 shl n)-1,1]:=1;
  for k:=1 to  maxn do begin
    nw:=1-nw;
    old:=1-old;
    fillchar(q[nw],sizeof(q[nw]),0);
    for j:=0 to (1 shl n) -1 do
      for i:=1 to n do
        if q[old,j,i]>0 then begin
          f:=false;
          for l:=1 to n do
            if j=1 shl (l-1) then begin
              res:=res+q[old,j,i]*(k-1);
              f:=true;
              break;
            end;
          if f then break;
          for l:=1 to n do
            if l<>i then
            if geti(j,l)>0 then begin
              temp:=changeI0(j,l);
              q[nw,temp,next(i,temp)]:=q[nw,temp,next(i,temp)]+q[old,j,i]*ch[i,l]*nd[i,l];
            end;
          q[nw,j,next(i,j)]:=q[nw,j,next(i,j)]+q[old,j,i]*ps[i];
        end;
  end;
  writeln(res:0:5);
  close(input);
  close(output);
end.
