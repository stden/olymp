{$H+}

Const month:Array[1..12]of String[3]=('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');
			final:Array[0..13]of Integer=(31,31,28,31,30,31,30,31,31,30,31,30,31,31);

Var ts,s,s_1:String;
		hour,min,now,day,mon,year,sec,i,t,add:Integer;
Function f(c:Char):Integer;
Begin
	f:=ord(c)-ord('0');
End;

Function good(v:Integer):String;
Begin
  if v<10 then begin
    good:='0'+chr(ord('0')+v);  
  end else begin
    good:=chr(ord('0') + (v div 10))+chr(ord('0')+ (v mod 10));
  end;
End;

Procedure NextDay(var year,month,day:Integer);
Begin
  if (day<final[month])or((day=28)and(month=2)and(year mod 4=0)) then Inc(day) else begin
		Inc(month);day:=1;
	end;
	if month=13 then begin
		Inc(year);month:=1;
	end;
End;
Procedure PrevDay(var year,month,day:Integer);
Begin
  if (day<>1) then Dec(day) else begin
		Dec(month);day:=final[month];
		if (month=2)and(year mod 4=0) then Inc(day);
	end;
	if month=0 then begin
		Dec(year);month:=12;
	end;
End;

Begin
  Assign(input,'apache.in');
	Assign(output,'apache.out');
	Reset(input);ReWrite(output);
	ReadLn(s);
  add:=f(s[2])*600+f(s[3])*60+f(s[4])*10+f(s[5]);
	if s[1]='-' then add:=-add;
  s_1:=s;
  while not EoF do begin
    ReadLn(s);
    t:=pos('[',s);
    for i:=1 to t-1 do Write(s[i]);
    day:=f(s[t+1])*10+f(s[t+2]);
    ts:=s[t+4]+s[t+5]+s[t+6];
    for i:=1 to 12 do if month[i]=ts then mon:=i;
    year:=f(s[t+8])*1000+f(s[t+9])*100+f(s[t+10])*10+f(s[t+11]);
    hour:=f(s[t+13])*10+f(s[t+14]);
    min:=f(s[t+16])*10+f(s[t+17]);
    sec:=f(s[t+19])*10+f(s[t+20]);
    now:=f(s[t+23])*600+f(s[t+24])*60+f(s[t+25])*10+f(s[t+26]);
		if s[t+22]='-' then now:=-now;
    min:=min+add-now;
    while min<0 do begin
			min:=min+60;Dec(hour);
		end;
    while min>=60 do begin
			min:=min-60;Inc(hour);
		end;
		while hour<0 do begin
			hour:=hour+24;PrevDay(year,mon,day);
		end;
    while hour>=24 do begin
			hour:=hour-24;NextDay(year,mon,day);
		end;
    Write('[',good(day),'/',month[mon],'/',year,':',good(hour),':',good(min),':',good(sec),' ',s_1,']');
    for i:=t+28 to length(s) do Write(s[i]);WriteLn;
  end;
End.