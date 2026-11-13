type
tcard=record
  card:integer;
  mast:integer;
end;
function printxx(mast:integer):string;
var
s:string;
begin
  s:='';
  if mast=1 then s:=s+'S';
  if mast=2 then s:=s+'C';
  if mast=3 then s:=s+'D';
  if mast=4 then s:=s+'H';
  printxx:=s;
end;
function print(a:tcard):string;
var
s:string;
begin
  if a.card in [1..3] then s:=chr(ord('6')+a.card);
  if a.card=4 then s:='T';
  if a.card=5 then s:='J';
  if a.card=6 then s:='Q';
  if a.card=7 then s:='K';
  if a.card=8 then s:='A';
  if a.mast=1 then s:=s+'S';
  if a.mast=2 then s:=s+'C';
  if a.mast=3 then s:=s+'D';
  if a.mast=4 then s:=s+'H';
  print:=s;
end;
function printx(card,mast:integer):string;
var
t:tcard;
begin
  t.card:=card;
  t.mast:=mast;
  printx:=print(t);
end;

var
a:array[1..12]of tcard;
c:array[1..4,-1..12]of integer;
i,j,k:integer;
ans:integer;
n:integer;
s:string;
ch:char;
min,mini,max,maxi:integer;
t:integer;
begin
  assign(input,'preference.in');
  assign(output,'preference.out');
  reset(input);
  rewrite(output);
  readln(n);
  for i:=1 to 12 do begin
    read(ch);
    while ch=' ' do read(ch);
    if ch in ['7'..'9'] then a[i].card:=ord(ch)-ord('6');
    if ch='T' then a[i].card:=4;
    if ch='J' then a[i].card:=5;
    if ch='Q' then a[i].card:=6;
    if ch='K' then a[i].card:=7;
    if ch='A' then a[i].card:=8;
    read(ch);
    if ch='S' then a[i].mast:=1;
    if ch='C' then a[i].mast:=2;
    if ch='D' then a[i].mast:=3;
    if ch='H' then a[i].mast:=4;
    inc(c[a[i].mast][0]);
    c[a[i].mast][c[a[i].mast][0]]:=a[i].card;
  end;
  readln;
  for i:=1 to 4 do begin
    for j:=1 to c[i][0] do begin
      min:=j;
      for k:=j+1 to c[i][0] do
        if c[i][k]>c[i][min] then min:=k;
      t:=c[i,min];
      c[i,min]:=c[i][j];
      c[i,j]:=t;
    end;
  end;
  for i:=1 to 4 do begin
    c[i][-1]:=0;
    if (c[i][0]>=1) then begin
      for j:=1 to c[i,0] do
        if c[i][j]=9-j then inc(c[i][-1]);
    end;
    if (c[i][-1]=0) and (c[i][0]>=2) then begin
      if (c[i][1]=7) and (c[i][2]=6) then c[i,-1]:=1;
    end;
  end;
  max:=0;
  maxi:=0;
  for i:=1 to 4 do begin
    if c[i][-1]*2+c[i][0]>=8 then begin
     inc(c[i][-1],c[i][0]-c[i][-1]);
    end;
    if c[i][-1]>max then begin
      max:=c[i][-1];
      maxi:=i;
    end;
  end;
  close(input);
  if max=0 then begin
    writeln(0);
    writeln(print(a[1]),' ',print(a[2]));
    writeln('N');
    close(output);
    halt;
  end;
  min:=maxint;
  for i:=1 to 4 do begin
    if (c[i][-1]<=min) and (c[i][0]>0) then begin
      min:=c[i][-1];
      mini:=i;
    end;
  end;
  s:=printx(c[mini,c[mini][0]],mini)+' ';
  dec(c[mini][0]);
  c[mini][-1]:=0;
  if (c[mini][0]>=1) then begin
    for j:=1 to c[i,0] do
      if c[mini][j]=9-j then inc(c[i][-1]);
  end;
  if (c[mini][-1]=0) and (c[mini][0]>=2) then begin
    if (c[mini][1]=7) and (c[mini][2]=6) then c[mini,-1]:=1;
  end;
  if c[mini][-1]*2+c[mini][0]>=8 then begin
   inc(c[mini][-1],c[mini][0]-c[mini][-1]);
  end;
  min:=maxint;
  for i:=1 to 4 do begin
    if (c[i][-1]<=min) and (c[i][0]>0) then begin
      min:=c[i][-1];
      mini:=i;
    end;
  end;
  s:=s+printx(c[mini,c[mini][0]],mini);
  ans:=0;
  for i:=1 to 4 do
    ans:=ans+c[i][-1];
  if ans>=10 then begin
    writeln(10);
    writeln(s);
    writeln(printxx(maxi));
  end;
  close(output);
end.
