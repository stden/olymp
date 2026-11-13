program multixor;
{$MODE DELPHI}
{$APPTYPE CONSOLE}

uses
  SysUtils;
{$H+,D+,i+,L+,Q+,R+,S+,O-}
type integer=longint;
var s,port,idd,psd,ip:string;
    i,j,x,kolp:integer; 
    p,from,too,id,ps:array[0..3200]of string;
    bol:boolean;
label 1;
function strto2(c:integer):string;
var s:string;
    i:integer;
begin
  s:='';
  while c>0 do begin
    s:=s+chr(ord('0')+c mod 2);
    c:=c div 2;
  end;
  for i:=length(s)+1 to 8 do s:=s+'0';
  result:=s;
  for i:=1 to length(s) do result[i]:=s[length(s)-i+1];
end;
function pattern(d,s:string):boolean;
var c,mask,i:integer;
    s1,s2:string;
begin
  result:=true;
  c:=0;
  s1:='';
  s:=s+'|';
  mask:=32;
  for i:=1 to length(s) do begin
    if s[i] in ['0'..'9'] then begin
      c:=c*10+ord(s[i])-ord('0');
    end else begin
      if s[i]='|' then mask:=c else begin
        s1:=s1+strto2(c);
        c:=0;
      end;
    end;
  end;
  c:=0;
  s2:='';
  d:=d+'|';
  for i:=1 to length(d) do begin
    if d[i] in ['0'..'9'] then begin
      c:=c*10+ord(d[i])-ord('0');
    end else begin
      s2:=s2+strto2(c);
      c:=0;
    end;
  end;
  for i:=1 to mask do if s1[i]<>s2[i] then begin
    result:=false;
    exit;
  end;
end;
function pattern2(id,idd:string):boolean;
var x,y,z:integer;
begin
  result:=false;
  if (length(id)*2+1=length(idd))and(idd[length(id)+1]='-') then begin
    x:=strtoint(id);
    y:=strtoint(copy(idd,1,length(id)));
    z:=strtoint(copy(idd,length(id)+2,length(id)));
    result:=(x>=y)and(x<=z);
  end;
end;
begin
  assign(input,'multiplexor.in');
  reset(input);
  assign(output,'multiplexor.out');
  rewrite(output);
  readln(s);
  i:=0;
  while s<>'---' do begin
    if s[1]='A' then begin
      for j:=2 to length(s) do if (ord(s[j])<>32)and(ord(s[j])<>9) then begin
        x:=j;
        break;
      end;
      port:=copy(s,x,length(s)-x+1);
    end else begin
      inc(i);
      p[i]:=port;
      delete(s,1,1);
      while not(s[1] in ['0'..'9']) do begin
        delete(s,1,1);
      end;
      from[i]:='';
      while (s[1]<>' ')and(ord(s[1])<>9) do begin
        from[i]:=from[i]+s[1];
        delete(s,1,1);
      end;
      while not(s[1] in ['0'..'9']) do begin
        delete(s,1,1);
      end;
      too[i]:='';
      while (length(s)>0)and(s[1]<>' ')and(ord(s[1])<>9) do begin
        too[i]:=too[i]+s[1];
        delete(s,1,1);
      end;
      while (length(s)>0)and((s[1]=' ')or(ord(s[1])=9)) do begin
        delete(s,1,1);
      end;
      id[i]:='';
      ps[i]:='';
      if length(s)=0 then begin
        readln(s);
        continue;
      end;
      if s[1]='I' then begin
        delete(s,1,1);
        while (length(s)>0)and((s[1]=' ')or(ord(s[1])=9)) do begin
          delete(s,1,1);
        end;
        while (length(s)>0)and(s[1]<>' ')and(ord(s[1])<>9) do begin
          id[i]:=id[i]+s[1];
          delete(s,1,1);
        end;
      end;
      if length(s)=0 then begin
        readln(s);
        continue;
      end;
      while (length(s)>0)and((s[1]=' ')or(ord(s[1])=9)) do begin
        delete(s,1,1);
      end;
      if s[1]='P' then begin
        delete(s,1,1);
        while (length(s)>0)and((s[1]=' ')or(ord(s[1])=9)) do begin
          delete(s,1,1);
        end;
        while (length(s)>0)and(s[1]<>' ')and(ord(s[1])<>9) do begin
          ps[i]:=ps[i]+s[1];
          delete(s,1,1);
        end;
      end;
    end;
    readln(s);
  end;
  kolp:=i;
  while not eof do begin
    readln(s);
    delete(s,1,1);
    while not(s[1] in ['0'..'9']) do begin
      delete(s,1,1);
    end;
    ip:='';
    while (s[1]<>' ')and(ord(s[1])<>9) do begin
      ip:=ip+s[1];
      delete(s,1,1);
    end;
    while not(s[1] in ['0'..'9']) do begin
      delete(s,1,1);
    end;
    port:='';
    while (length(s)>0)and(s[1]<>' ')and(ord(s[1])<>9) do begin
      port:=port+s[1];
      delete(s,1,1);
    end;
    while (length(s)>0)and((s[1]=' ')or(ord(s[1])=9)) do begin
      delete(s,1,1);
    end;
    idd:='';
    psd:='';
    if length(s)=0 then begin
      goto 1;
    end;
    if s[1]='I' then begin
      delete(s,1,1);
      while (length(s)>0)and((s[1]=' ')or(ord(s[1])=9)) do begin
        delete(s,1,1);
      end;
      while (length(s)>0)and(s[1]<>' ')and(ord(s[1])<>9) do begin
        idd:=idd+s[1];
        delete(s,1,1);
      end;
    end;
    if length(s)=0 then begin
      goto 1;
    end;
    while (length(s)>0)and((s[1]=' ')or(ord(s[1])=9)) do begin
      delete(s,1,1);
    end;
    if s[1]='P' then begin
      delete(s,1,1);
      while (length(s)>0)and((s[1]=' ')or(ord(s[1])=9)) do begin
        delete(s,1,1);
      end;
      while (length(s)>0)and(s[1]<>' ')and(ord(s[1])<>9) do begin
        psd:=psd+s[1];
        delete(s,1,1);
      end;
    end;
    1:
    bol:=false;
    for i:=1 to kolp do begin
      if p[i]<>port then continue;
      if not(pattern(ip,from[i])) then continue;
      if (id[i]<>'')and(id[i]<>idd)and(not pattern2(idd,id[i])) then continue;
      if (ps[i]<>'')and(ps[i]<>psd)then continue;
      bol:=true;
      writeln(too[i]);
    end;
    if not(bol) then writeln('/dev/null');
  end;
end.
