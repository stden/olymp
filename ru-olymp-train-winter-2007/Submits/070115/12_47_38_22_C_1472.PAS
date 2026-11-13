{$MODE DELPHI}

const FileName='bit';
      Iter=20;
type GenArr=array[1..6] of byte;

var q:array[1..6,0..728] of boolean;
    s:GenArr;
    words:array[1..100000] of integer;
    l:integer;
    len:integer;


procedure readword;
var ch:char;
    i:integer;
begin
  readln(l);
  for i:=1 to l do begin
    read(ch);
    words[i]:=ord(ch)-ord('a')+1;
  end;
  readln;
end;


function StrToInt(const s:GenArr;l:integer):integer;
var i,pow:integer;
begin
  result:=0;
  pow:=1;
  for i:=1 to l do begin
    result:=result+(s[i]-1)*pow;

    pow:=pow*3;
  end;
end;

procedure dfs;
var i,x,y,z,j:integer;
begin
  for i:=1 to len do  begin
    if s[i]=4 then break;
    if i=len then begin
      q[len][StrToInt(s,len)]:=true;
      exit;
    end;
  end;
  for i:=1 to len-1 do begin
    if (s[i]=4) and (s[i+1]=4) then begin
      s[i]:=1;
      s[i+1]:=2;
      dfs;
      s[i]:=1;
      s[i+1]:=3;
      dfs;
      s[i]:=2;
      s[i+1]:=1;
      dfs;
      s[i]:=2;
      s[i+1]:=3;
      dfs;
      s[i]:=3;
      s[i+1]:=1;
      dfs;
      s[i]:=3;
      s[i+1]:=2;
      dfs;
      s[i]:=4;
      s[i+1]:=4;
    end;
  end;
  for i:=1 to len-1 do begin
    if (s[i]=4) and (s[i+1]<>4) then begin
      x:=s[i+1];
      for j:=1 to 3 do
       if j<>x then
         y:=j;
      for j:=1 to 3 do
        if (j<>x) and (j<>y) then
          z:=j;
       s[i]:=y;
       s[i+1]:=z;
       dfs;
       s[i]:=z;
       s[i+1]:=y;
       dfs;
       s[i]:=4;
       s[i+1]:=x;
    end;
    if (s[i]<>4) and (s[i+1]=4) then begin
      x:=s[i];
      for j:=1 to 3 do
       if j<>x then
         y:=j;
      for j:=1 to 3 do
        if (j<>x) and (j<>y) then
          z:=j;
       s[i]:=y;
       s[i+1]:=z;
       dfs;
       s[i]:=z;
       s[i+1]:=y;
       dfs;
       s[i]:=x;
       s[i+1]:=4;
    end;
  end;
end;

function checkseg(pos:integer;len:integer):boolean;
var i,j:integer;
begin
  j:=0;
  checkseg:=false;
  if pos+len-1>l then exit;
  for i:=pos to pos+len-1 do begin
    inc(j);
    s[j]:=words[i];
  end;
  checkseg:=q[len,strtoint(s,len)];
end;

function trycheck:boolean;
var i,j:integer;
    f:boolean;
    lenseg:integer;
begin
  i:=1;
  trycheck:=false;
  while i<=l do begin
    lenseg:=random(3)+4;
    f:=false;
    if checkseg(i,lenseg) then begin
       i:=i+lenseg;
       continue;
    end
    else
    for j:=6 downto 2 do
    if checkseg(i,j) then begin
      i:=i+j;
      f:=true;
    end;
    if not f then
    exit;
  end;
  trycheck:=true;
end;


function check:boolean;
var i:integer;
begin
  check:=true;
  for i:=1 to Iter do
    if trycheck then exit;
  check:=false;
end;


var t,i:integer;

begin
  assign(input,FileName+'.in');
  assign(output,FileName+'.out');
  reset(input);
  rewrite(output);
  randseed:=102413239;
  for len:=2 to 6 do begin
    for i:=1 to len do
    s[i]:=4;
    dfs;
  end;
  readln(t);
  for i:=1 to t do begin
    readword;
    if check then writeln('YES')
    else writeln('NO');
  end;
  close(input);
  close(output);
end.
