Type Integer=LongInt;
Const dig:Array[1..16]of Integer=(1,2,4,5,7,8,9,10,12,13,15,16,18,19,21,22);
      digits:set of char=['0'..'9'];

Var x,t1,sec,j,t,hh,mm,ss,h1,m1,s1,i,l,speed:Integer;
    d1,date,ts,s:String[250];
    fl:Boolean;

    SecToPay,TotSec,TotRead,TotWrite:Integer;
Function TimeF(h2,m2,s2,h1,m1,s1:Integer):Integer;
Begin
  TimeF:=(h2-h1)*60*60+(m2-m1)*60+(s2-s1);
End;
Function CharToDigit(ch:Char):Integer;
Begin
  CharToDigit:=ord(ch)-ord('0');
End; 
  
Begin
  Assign(input,'calls.in');
  Assign(output,'calls.out');
  Reset(input);ReWrite(output);
  speed:=-1;
  SecToPay:=0;Totsec:=0;
  TotRead:=0;TotWrite:=0;
  while not EoF do begin
    ReadLn(s);date:='';
    l:=length(s);
    if length(s)<=25 then continue;fl:=true;
    for i:=1 to 16 do if not (s[dig[i]] in digits) then fl:=false;
    if not fl then continue;
    if (s[3]<>'-') or (s[6]<>'-') then continue;
    if (s[11]<>' ') or (s[23]<>' ')or (s[25]<>' ') then continue;
    if (s[14]<>':') or (s[17]<>':') then continue;
    if (s[20]<>'.') then continue;
    for i:=1 to 10 do date:=date+s[i];
    hh:=10*CharToDigit(s[12])+CharToDigit(s[13]);
    mm:=10*CharToDigit(s[15])+CharToDigit(s[16]);
    ss:=10*CharToDigit(s[18])+CharToDigit(s[19]);
    if (hh>23)or(mm>59)or(ss>59) then continue;
    ts:='';
    for i:=26 to l do ts:=ts+s[i];
    l:=length(ts);
    if (pos('Connection established at ',ts)<>0) and(pos('bps.',ts)<>0) then begin
      t:=pos('bps.',ts);
      Dec(t);i:=t;
      while (ts[i]>='0')and(ts[i]<='9')  do begin
        Dec(i);
      end;
      Inc(i);speed:=0;
      for j:=i to t do speed:=speed*10+CharToDigit(ts[j]);
      for i:=1 to 19 do Write(s[i]);Write('    ');
      d1:=date;h1:=hh;m1:=mm;s1:=ss;
      continue;
    end;
    if (ts='Hanging up the modem.')and(speed<>-1) then begin
      if d1<>date then hh:=hh+24;
      sec:=TimeF(hh,mm,ss,h1,m1,s1);Inc(TotSec,sec);
      if sec>=60 then Inc(SecToPay,sec);
      Write(sec,' ',speed,' ');speed:=-1;
      continue;
    end;
    if (pos('Reads',ts))<>0 then begin
      x:=0;
      for i:=1 to l do if ts[i] in digits then begin
				t:=i;break;
      end;
      t1:=t;while ts[t1] in digits do Inc(t1);
      Dec(t1);
      for i:=t to t1 do x:=x*10+CharToDigit(ts[i]);
      Write(x,'/');
      Inc(TotRead,x);
    end;
    if (pos('Writes',ts))<>0 then begin
      x:=0;
      for i:=1 to l do if ts[i] in digits then begin
				t:=i;break;
      end;
      t1:=t;while ts[t1] in digits do Inc(t1);
      Dec(t1);
      for i:=t to t1 do x:=x*10+CharToDigit(ts[i]);
      WriteLn(x);
      Inc(TotWrite,x);
    end;
  end;
  WriteLn('Total second to pay = ',SecToPay,', total seconds = ',TotSec,'; total bytes ',TotRead,'/',TotWrite);
End.
