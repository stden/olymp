{$MODE DELPHI}

const FileName='cars';
const inf=maxint shr 1;
type Tposition=array[1..10] of byte;

const pow5:array[0..9] of integer=(1,5,25,125,625,3125,15625,78125,390625,1953125);

var mark:array[0..9765625] of boolean;
    len:array[1..10] of integer;
    typeh:array[1..10] of boolean;
    x,y:array[1..10] of integer;
    nowpos:TPosition;
    map:array[1..6,1..6] of boolean;
    och:array[0..700000] of integer;
    ln:array[0..700000] of word;
    n,i,w,r:integer;

function PosToInt(const Pos:TPosition):integer;
var i:integer;
    pow:integer;
begin
  pow:=1;
  result:=0;
  for i:=1 to n do begin
    result:=result+Pos[i]*pow;
    pow:=pow*5;
  end;
end;

function IntToPos(a:integer):TPosition;
var i:integer;
begin
  for i:=1 to n do begin
    result[i]:=a mod 5;
    a:=a div 5;
  end;
end;

function getnewpos(num,pos,oldpos,newpos:integer):integer;
begin
  result:=pos+(newpos-oldpos)*pow5[num-1];
end;

function changepos(num:integer;pos,oldpos,newpos:integer):integer;
begin
  result:=pos+(newpos-oldpos)*pow5[num-1];
  nowpos[num]:=newpos;
end;

procedure printcar(num:integer);
var i:integer;
begin
  if typeh[num] then
  for i:=nowpos[num] to nowpos[num]+len[num] - 1 do
    map[i+1,y[num]]:=true
  else
  for i:=nowpos[num] to nowpos[num]+len[num] - 1 do
    map[x[num],i+1]:=true;
end;

procedure clearcar(num:integer);
var i:integer;
begin
  if typeh[num] then
  for i:=nowpos[num] to nowpos[num]+len[num]-1 do
    map[i+1,y[num]]:=false
  else
  for i:=nowpos[num] to nowpos[num]+len[num]-1 do
    map[x[num],i+1]:=false;
end;

procedure addtooch(temp,i,j,l:integer);
begin
  inc(w);
  if w>7000000 then begin
    writeln(-1);
    halt(0);
  end;
  och[w]:=getnewpos(i,temp,NowPos[i],j);
  ln[w]:=l+1;
  mark[och[w]]:=true;

//  parent[w]:=r;
  if (i=1) and (j+len[i]-1=5) then begin
  {  i:=w;
    while i<>0 do begin
      writeln(och[i]);
      i:=parent[i];
    end;}
    writeln(l+1);
    close(input);
    close(output);
    halt(0);
  end;
end;

procedure bfs;
var i,j,temp:integer;
begin
  r:=0;
  w:=1;
  temp:=PosToInt(NowPos);
  och[w]:=temp;
  ln[temp]:=0;
  mark[temp]:=true;
  while r<w do begin
    inc(r);
    NowPos:=IntToPos(och[r]);
    fillchar(map,sizeof(map),0);
    for i:=1 to n do
    printcar(i);
    temp:=och[r];
    for i:=1 to n do begin
      if typeh[i] then begin
        for j:=NowPos[i]-1 downto 0 do begin
          if map[j+1,y[i]] then break;
          if (not mark[getnewpos(i,temp,NowPos[i],j)])  then
            addtooch(temp,i,j,ln[r]);
        end;
        for j:=NowPos[i]+1 to 5 -len[i]+1 do begin
          if map[j+len[i],y[i]] then break;
          if (not mark[getnewpos(i,temp,NowPos[i],j)])  then
            addtooch(temp,i,j,ln[r]);
        end;
      end
      else begin
        for j:=NowPos[i]-1 downto 0 do begin
          if map[x[i],j+1] then break;
          if (not mark[getnewpos(i,temp,NowPos[i],j)])  then
            addtooch(temp,i,j,ln[r]);
        end;
        for j:=NowPos[i]+1 to 5 -len[i]+1 do begin
          if map[x[i],j+len[i]] then break;
          if (not mark[getnewpos(i,temp,NowPos[i],j)])  then
            addtooch(temp,i,j,ln[r]);
        end;
        end;
    end;
  end;
end;

var ch:char;

begin
  assign(input,FileName+'.in');
  assign(output,FileName+'.out');
  reset(input);
  rewrite(output);
  readln(n);
  for i:=1 to n do begin
    read(ch);
    typeh[i]:=ch='h';
    read(y[i],x[i]);
    read(ch,ch);
    len[i]:=2+ord(ch='t');
    if typeh[i] then
    nowpos[i]:=x[i]-1
    else nowpos[i]:=y[i]-1;
    readln;
  end;
  bfs;
  writeln(-1);
  close(input);
  close(output);
end.
