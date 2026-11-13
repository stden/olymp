{$H+}
Type Integer=LongInt;
Var x,y,i,max1,max2,rmax1,rmax2,l,tec:Integer;
    s,ts:String;
    fl:Boolean;
Begin
  
  Assign(input,'stress.in');
  Assign(output,'stress.out');
  Reset(input);ReWrite(output);
  tec:=1;max1:=-1;max2:=-1;
  while not EoF do begin
    ReadLn(s);
    l:=length(s);fl:=true;
    for i:=1 to l do if s[i]<>'-' then begin fl:=false;break;end;
    if fl then continue;
    ts:='';
    for i:=1 to 11 do ts:=ts+s[i];
    if ts='randseed = ' then begin
      y:=0;i:=12;
      while i<=l do begin
        y:=y*10+ord(s[i])-ord('0');
        Inc(i);
      end;
      WriteLn('At '+s);
      continue; 
    end;
    if ts='Work time: ' then begin
      i:=12;x:=0;
      while true do begin
        if not (s[i] in ['0'..'9']) then break;
        x:=x*10+ord(s[i])-ord('0');
        Inc(i);
      end;
      if tec=1 then begin
        WriteLn('First: ',x,' ms');
        if x>max1 then begin max1:=x;rmax1:=y;end;
      end;
      if tec=2 then begin
        WriteLn('Second: ',x,' ms');
        if x>max2 then begin max2:=x;rmax2:=y;end;
      end;
      tec:=3-tec;
    end;
  end;
  WriteLn('Maximal work time for first: ',max1,' at randseed = ',rmax1);
  WriteLn('Maximal work time for second: ',max2,' at randseed = ',rmax2);
End. 