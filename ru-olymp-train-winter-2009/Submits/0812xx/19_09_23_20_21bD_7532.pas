{$H+}
var
  fl1,v,kr,kw,gt,gtp,gr,gw : longint;
  s1,s2,st: string;
  m1,d1,g1,ch1,min1,sec1,t : int64;
  m2,d2,g2,ch2,min2,sec2 : int64;

function time(m1,d1,g1,ch1,min1,s1,m2,d2,g2,ch2,min2,s2 : int64) : int64;
var
  sec1,sec2 : int64;
begin
  sec1:=ch1*60*60+min1*60+s1;  
  sec2:=ch2*60*60+min2*60+s2;  
  time:=sec2-sec1;
   if time<0 then time:=time+24*60*60;
end;

procedure trim(var s : string);
begin
  while s[1]=' ' do delete(s,1,1);
  while s[length(s)]=' ' do delete(s,length(s),1);
end;

begin
  assign(input,'calls.in');
  reset(input);
  assign(output,'calls.out');
  rewrite(output);
  v:=-1; gw:=0; gr:=0; gt:=0; gtp:=0;
  while not eof do
  begin
    readln(s1);
    if length(s1)<25 then continue;
    if (s1[1] in ['0'..'9']) and 
       (s1[2] in ['0'..'9']) and 
       (s1[3]='-') and 
       (s1[4] in ['0'..'9']) and 
       (s1[5] in ['0'..'9']) and 
       (s1[6]='-') and
       (s1[7] in ['0'..'9']) and 
       (s1[8] in ['0'..'9']) and 
       (s1[9] in ['0'..'9']) and 
       (s1[10] in ['0'..'9']) and 
       (s1[11]=' ') and 
       (s1[12] in ['0'..'9']) and 
       (s1[13] in ['0'..'9']) and 
       (s1[14]=':')  and
       (s1[15] in ['0'..'9']) and 
       (s1[16] in ['0'..'9']) and 
       (s1[17]=':')  and
       (s1[18] in ['0'..'9']) and 
       (s1[19] in ['0'..'9']) and 
       (s1[20]='.')  and
       (s1[21] in ['0'..'9']) and 
       (s1[22] in ['0'..'9']) and 
       (s1[23]=' ')  and
       (s1[24]='-')  and
       (s1[25]=' ')  then
    begin
      s2:=copy(s1,1,25);
      delete(s1,1,25);
      if length(s1)>25 then 
        if copy(s1,1,26)='Connection established at ' then
        begin
          st:=s2;
          delete(s1,1,26);
          if length(s1)<5 then continue;
          trim(s1);
          if copy(s1,length(s1)-3,4)<>'bps.' then continue;  
          delete(s1,length(s1)-3,4);
          val(s1,v,fl1);   
          continue; 
        end;
      if v=-1 then continue;
      if length(s1)>20 then 
        if copy(s1,1,21)='Hanging up the modem.' then
        begin
          val(copy(st,1,2),m1,fl1);
          val(copy(st,4,2),d1,fl1);
          val(copy(st,7,4),g1,fl1);
          val(copy(st,12,2),ch1,fl1);
          val(copy(st,15,2),min1,fl1);
          val(copy(st,18,2),sec1,fl1);

          val(copy(s2,1,2),m2,fl1);
          val(copy(s2,4,2),d2,fl1);
          val(copy(s2,7,4),g2,fl1);
          val(copy(s2,12,2),ch2,fl1);
          val(copy(s2,15,2),min2,fl1);
          val(copy(s2,18,2),sec2,fl1);
          
          t:=time(m1,d1,g1,ch1,min1,sec1,m2,d2,g2,ch2,min2,sec2);
          if t>=60 then gtp:=gtp+t;
          gt:=gt+t;
          write(copy(st,1,19),' ',t,' ',v,' ');
          continue;
        end;
      if length(s1)>8 then
      begin 
        trim(s1);
        if copy(s1,1,8)='Reads : ' then 
        begin
          delete(s1,1,8);
          while s1[length(s1)]<>' ' do delete(s1,length(s1),1);
          delete(s1,length(s1),1);
          val(s1,kr,fl1); 
          gr:=gr+kr;
          continue;  
        end;  
        if copy(s1,1,8)='Writes: ' then 
        begin
          delete(s1,1,8);
          while s1[length(s1)]<>' ' do delete(s1,length(s1),1);
          delete(s1,length(s1),1);
          val(s1,kw,fl1);
          gw:=gw+kw;
          continue;  
        end  
      end;

      if length(s1)>21 then
        if copy(s1,1,22)='Standard Modem closed.' then 
        begin 
          if v<>-1 then writeln(kr,'/',kw); 
          v:=-1;
        end;
    end;   
  end;
  writeln('Total seconds to pay = ',gtp,', total seconds = ', gt,'; total bytes ',gr,'/',gw);
end.