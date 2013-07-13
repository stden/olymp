{$AC+,TL-,ML-,WA-,RE-,PE-,SV-}
uses
 sysutils;
var
 card:array[1..3,1..12]of string;
 max,m1,m2,m3,m4,f,i,j:longint;
 t:string;
 ans,ch1,ch2,ch3:char;

function less(s1,s2:string):longint;
var
 st1,st2:longint;
begin
 if s1[1] in ['7'..'9'] then
  st1:=StrToInt(s1[1]);
 if s1[1]='T' then
  st1:=10;
 if s1[1]='J' then
  st1:=11;
 if s1[1]='Q' then
  st1:=12;
 if s1[1]='K' then
  st1:=13;
 if s1[1]='A' then
  st1:=14;
 if s2[1] in ['7'..'9'] then
  st2:=StrToInt(s2[1]);
 if s2[1]='T' then
  st2:=10;
 if s2[1]='J' then
  st2:=11;
 if s2[1]='Q' then
  st2:=12;
 if s2[1]='K' then
  st2:=13;
 if s2[1]='A' then
  st2:=14;
 if st1=st2 then
  less:=0;
 if st1<st2 then
  less:=1;
 if st1>st2 then
  less:=-1;
end;

begin
 assign(input,'preference.in');
 assign(output,'preference.out');
 reset(input);
 rewrite(output);
 readln(f);
 for i:=1 to 12 do
  begin
  read(ch1,ch2,ch3);
  card[1][i]:=ch1+ch2;
  end;
 readln;
 for i:=1 to 10 do
  begin
  read(ch1,ch2,ch3);
  card[2][i]:=ch1+ch2;
  end;
 readln;
 for i:=1 to 10 do
  begin
  read(ch1,ch2,ch3);
  card[3][i]:=ch1+ch2;
  end;
 m1:=0;
 m2:=0;
 m3:=0;
 m4:=0;
 for i:=1 to 12 do
  begin
  if card[1][i][2]='S' then
   m1:=m1+1;
  if card[1][i][2]='C' then
   m2:=m2+1;
  if card[1][i][2]='D' then
   m3:=m3+1;
  if card[1][i][2]='H' then
   m4:=m4+1;
  end;
 for i:=1 to 11 do
  for j:=i+1 to 12 do
   begin
   if less(card[1][i],card[1][j])=-1 then
    begin
    t:=card[1][i];card[1][i]:=card[1][j];card[1][j]:=t;
    end;
   end;
 writeln(10);
 writeln(card[1][1],' ',card[1][2]);
 ans:='S';
 max:=m1;
 if m2>max then
  begin
  max:=m2;
  ans:='C';
  end;
 if m3>max then
  begin
  max:=m3;
  ans:='D';
  end;
 if m4>max then
  begin
  max:=m4;
  ans:='H';
  end;
 writeln(ans);
 close(input);
 close(output);
end.