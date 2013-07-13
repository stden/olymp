{$R+,O+}
program apache_VT;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var hs,ms,i,y,month,n,h,m,sec,hn,mn:integer;s,mon,ss:string;
    dc:array[1..12]of integer=(31,28,31,30,31,30,31,31,30,31,30,31);
    monname:array[1..12]of string=
    ('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');
procedure nmon;
begin
 inc(month);if month=13 then begin month:=1;inc(y);end;
end;
procedure pmon;
begin
 dec(month);if month=0 then begin month:=12;dec(y);end;
end;
procedure nday;
begin
 n:=n+1;while n > dc[month] do begin n:=1;nmon; end;
end;
procedure pday;
begin
 n:=n-1;while n < 1 do begin pmon;n:=dc[month]; end;
end;
procedure testm;
begin
 m:=m+ms-mn;
 while  m>=60 do begin m:=m-60;h:=h+1;end;
 while m<0 do begin m:=m+60;h:=h-1;end;
end;
procedure testh;
begin
 h:=h+hs-hn;
 while h>=24 do begin h:=h-24;nday;end;
 while h<0 do begin h:=h+24;pday;end;
end;

begin
 reset(input,'apache.in');
 rewrite(output,'apache.out');
 readln(s); ss:=s;
 hs:=10*(ord(s[2])-ord('0'))+(ord(s[3])-ord('0'));
 ms:=10*(ord(s[4])-ord('0'))+(ord(s[5])-ord('0'));
 if (s[1]='-')then begin hs:=-hs;if (ms>0) then begin dec(hs);ms:=60-ms;end;end;

 while not seekeof do
 begin
  readln(s);
//  writeln(s);
  i:=1;write(s[1]);
  while s[i]<>'[' do
  begin
   inc(i);
   write(s[i]);
  end;inc(i);
  n:=10*(ord(s[i])-ord('0'))+(ord(s[i+1])-ord('0'));
  mon:=copy(s,i+3,3);month:=1;while monname[month]<>mon do inc(month);
  y:=1000*(ord(s[i+7])-ord('0'))+100*(ord(s[i+8])-ord('0'))+10*(ord(s[i+9])-ord('0'))+(ord(s[i+10])-ord('0'));
  if (y mod 4=0)xor(y mod 100=0)xor(y mod 400=0) then dc[2]:=29 else dc[2]:=28;
  h:=10*(ord(s[i+12])-ord('0'))+(ord(s[i+13])-ord('0'));
  m:=10*(ord(s[i+15])-ord('0'))+(ord(s[i+16])-ord('0'));
  sec:=10*(ord(s[i+18])-ord('0'))+(ord(s[i+19])-ord('0'));
  hn:=10*(ord(s[i+22])-ord('0'))+(ord(s[i+23])-ord('0'));
  mn:=10*(ord(s[i+24])-ord('0'))+(ord(s[i+25])-ord('0'));
  if (s[i+21]='-')then begin hn:=-hn;if (mn>0) then begin dec(hn);mn:=60-mn;end;end;
  testm;testh;
  if n<10 then write('0');write(n,'/',monname[month],'/',y,':');
  if h<10 then write('0');write(h,':');
  if m<10 then write('0');write(m,':');
  if sec<10 then write('0');write(sec,' ',ss);
  inc(i,26);
  while i<=length(s) do begin write(s[i]);inc(i);end;
  writeln;
 end;
end.
