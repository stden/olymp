{$Mode Delphi}
const Mast='CSDH';
      Dost='789TJQKA';

type  card=record
                m,d:integer;
           end;

           TPlayer=record
              q:array[1..4,1..8] of integer;
              l:array[1..4] of integer;
            end;

var p1,p2,p3:TPlayer;
    n:integer;
    max:integer;
    koz:integer;
    card1,card2:card;

function maxm(a,b:integer):integer;
begin
  if a>b then maxm:=a
  else maxm:=b;
end;

procedure add(c:card;var p:TPlayer);
begin
  inc(p.l[c.m]);
  p.q[c.m,p.l[c.m]]:=c.d;
end;

procedure readplayer(var p:TPlayer);
var c1,c2:char;
begin
  while not seekeoln do begin
    read(c1,c2);
    inc(p.l[pos(c2,Mast)]);
    p.q[pos(c2,Mast),p.l[pos(c2,Mast)]]:=pos(c1,Dost);
  end;
  readln;
end;

procedure writecard(c:card);
begin
  write(Dost[c.d],Mast[c.m]);
end;

function getcountM(k:integer):integer;
var i:integer;
    p1c,p2c,p3c:array[1..8] of boolean;
begin
  fillchar(p1c,sizeof(p1c),0);
  fillchar(p2c,sizeof(p2c),0);
  fillchar(p3c,sizeof(p3c),0);
  for i:=1 to  p1.l[k] do
    p1c[p1.q[k,i]]:=true;
  for i:=1 to p2.l[k] do
    p2c[p2.q[k,i]]:=true;
  for i:=1 to p3.l[k] do
    p3c[p3.q[k,i]]:=true;
  result:=0;
  if p1c[8] then begin
    if p1c[7] then begin
      if p1c[6] then begin
        if p1c[5] then begin
          result:=p1.l[k];
          exit;
        end;
        if (p2.l[k]=4) or (p3.l[k]=4) then begin
          result:=3;
          exit;
        end
        else result:=p1.l[k];
      end;
      if p1.l[k]>5 then begin
        result:=p1.l[k];
        exit;
      end;
      if p1.l[k]=5 then begin
        if (p2.l[k]=3) or (p3.l[k]=3) then
          result:=4
        else result:=5;
        exit;
      end;
      if p1.l[k]=4 then begin
         if (p2.l[k]=2) and (p3.l[k]=2) then begin
           result:=4;
           exit;
         end;
         if (p2.l[k]=3) or (p3.l[k]=3) then begin
           result:=3;
           exit;
         end;
         if (p2.l[k]=4) or (p3.l[k]=4)  then begin
           result:=2;
           exit;
         end;
      end;
      result:=2;
      exit;
    end;
    if p1.l[k]=7 then begin
      result:=7;
      exit;
    end;
    if p1.l[k]=6 then begin
      if (p2.l[k]=2) or  (p2.l[k]=2) then
        result:=5
      else
        result:=6;
      exit;
    end;
    if p1.l[k]=5 then begin
      if p1c[6] and p1c[5] then
        result:=4
      else
        result:=3;
      exit;
    end;
    if p1.l[k]=4 then begin
      if p1c[6] and p1c[5] then
        result:=3
      else begin
        if (p2.l[k]=4) or  (p2.l[k]=4) then
          result:=1
        else result:=2;
      end;
    end;
    if p1c[6] and p1c[5] then result:=2
    else result:=1;
    exit;
  end;
  if p1c[7] then begin
    if p1.l[k]=7 then begin
      result:=6;
      exit;
    end;
    if p1.l[k]=6 then begin
      if p1c[6] then
        result:=5
      else result:=4;
      exit;
    end;
    if p1.l[k]=5 then begin
      if p1c[6] then
        result:=3
      else result:=2;
      exit;
    end;
    if p1.l[k]=4 then begin
      if p1c[6] then begin
        if (p2.l[k]=4) or (p2.l[k]=4) then
           result:=1
        else result:=2;
      end
      else
       if (p2.l[k]=4) or (p2.l[k]=4) then
         result:=0
        else result:=1;
      exit;
    end;
    if p1.l[k]=3 then begin
      if  p1c[6] and p1c[5] then
        result:=2
        else result:=1;
       exit;
    end;
    if p1.l[k]=2 then begin
      if p1c[6] then result:=1
      else result:=0;
      exit;
    end;
    result:=0;
    exit;
  end;
  if p1.l[k]=6 then begin
    result:=4;
    exit;
  end;
  if p1.l[k]=5 then begin
    if p1c[6] then result:=3
    else result:=2;
    exit;
  end;
  if p1.l[k]=4 then begin
    if p1c[5] and p1c[6] then result:=1
    else result:=0;
    exit;
  end;
end;

function getKoz(k:integer):integer;
var t:integer;
begin
  t:=getcountM(k);
  if (t>=p2.l[k]) and (t>=p3.l[k]) then
  result:=t
  else result:=t+(t-maxm(p2.l[k],p3.l[k]));
end;

procedure trysolve;
var i:integer;
    j,k,l:integer;
    res:integer;
    allcard:array[1..12] of card;
begin
  k:=0;
  max:=-1;
  for i:=1 to 4 do
    for j:=1 to p1.l[i] do begin
      inc(k);
      allcard[k].m:=i;
      allcard[k].d:=p1.q[i,j];
    end;
  for i:=1 to 12 do
    for j:=i+1 to 12 do begin
      fillchar(p1,sizeof(p1),0);
      for k:=1 to 12 do
        if (k<>i) and (k<>j)  then
          add(allcard[k],p1);

      for k:=0 to 4 do begin
        if (n<>1) and (k=0) then continue;
         res:=0;
        for l:=1 to 4 do
         if k<>l then
         res:=res+getcountM(l);
         if k<>0 then
         res:=res+getkoz(k);
        if res>max then begin
          max:=res;
          koz:=k;
          card1:=allcard[i];
          card2:=allcard[j];
        end;
      end;
    end;
  writeln(max);
  writecard(card1);
  write(' ');
  writecard(card2);
  writeln;
  if koz=0 then write('N')
  else
  write(Mast[koz]);
end;

begin
  assign(input,'preference.in');
  assign(output,'preference.out');
  reset(input);
  rewrite(output);
  readln(n);
  readplayer(p1);
  readplayer(p2);
  readplayer(p3);
  trysolve;
  close(input);
  close(output);
end.
