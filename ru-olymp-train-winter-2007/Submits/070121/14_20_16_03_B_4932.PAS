{$M 16000000}
{$H-,B-}
{$I+,Q+,R+,S+}
//{$I-,Q-,R-,S-}
const
 INF  = 1000000001;
type
 int  = longint;
 Card = record m,v:int; end;
var
 a,ao,b,c:array[1..12]of Card;
 first,res,rkoz,rd1,rd2,
 koz,d1,d2,cur,i:int;
 ch:char;

function readCard:Card;
var
 res:Card;
 ch:char;
begin
 read(ch);
 if ('1'<=ch)and(ch<='9') then res.v:=ord(ch)-ord('0') else
 case ch of
  'T': res.v:=10;
  'J': res.v:=11;
  'Q': res.v:=12;
  'K': res.v:=13;
  'A': res.v:=14;
 end;
 read(ch);
 case ch of
  'S': res.m:=1;
  'C': res.m:=2;
  'D': res.m:=3;
  'H': res.m:=4;
 end;
 readCard:=res;
end;

procedure writeCard(a:Card);
var ch:char;
begin
 if (1<=a.v)and(a.v<=9) then ch:=chr(a.v + ord('0')) else
 case a.v of
  10 : ch:='T';
  11 : ch:='J';
  12 : ch:='Q';
  13 : ch:='K';
  14 : ch:='A';
 end;
 write(ch);
 case a.m of
  1 : write('S');
  2 : write('C');
  3 : write('D');
  4 : write('H');
  5 : write('N');
 end;
end;

function getRes():int;
begin
 getRes := 10;
end;

Begin
 assign(input, 'preference.in');
 reset(input);
 assign(output,'preference.out');
 rewrite(output);
 //Input
 readln(first);
 for i:=1 to 12 do begin
  a[i]:=readCard;
  if (i<>12) then read(ch) else readln;
 end;
 for i:=1 to 10 do begin
  b[i]:=readCard;
  if (i<>10) then read(ch) else readln;
 end;
 for i:=1 to 10 do begin
  c[i]:=readCard;
  if (i<>10) then read(ch) else readln;
 end;
 //Solve
 res:=0;
 rkoz:=1;
 rd1:=1; rd2:=2;
 for koz:=1 to 5 do
  for d1:=1 to 12 do
   for d2:=d1 to 11 do begin
    ao:=a;
    for i:=d1 to 11 do a[i]:=a[i+1];
    for i:=d2 to 10 do a[i]:=a[i+1];
    cur := getRes;
    if (res < cur) then begin
     res:=cur;
     rkoz:=koz; rd1:=d1; rd2:=d2+1;
    end;
    a:=ao;
   end;
 writeln(res);
 writeCard(a[rd1]); write(' '); writeCard(a[rd2]);
 writeln;
 case rkoz of
  1 : writeln('S');
  2 : writeln('C');
  3 : writeln('D');
  4 : writeln('H');
  5 : writeln('N');
 end;
 close(output);
End.
