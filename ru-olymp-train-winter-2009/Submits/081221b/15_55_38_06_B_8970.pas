program solve;

var
 inp,oup:text;
 swt,fwt,so,fo,tr,ms,mf:int64;
 i:longint;
 s:string;
 fl:boolean;
 mn:set of char;

begin
 assign(inp,'stress.in');
 assign(oup,'stress.out');
 reset(inp);
 rewrite(oup);
 ms:=-1;
 mf:=-1;
 while not eof(inp) do
  begin
   readln(inp,s);
   fl:=false;
   while not fl do
    begin
     readln(inp,s);
     if copy(s,1,11)<>'randseed = ' then continue;
     delete(s,1,11);
     fl:=true;
     tr:=0;
     while length(s)<>0 do
      begin
       if not(s[1]in['0'..'9']) then
        begin
         fl:=false;
         break;
        end;
       tr:=tr*10+ord(s[1])-ord('0');
       delete(s,1,1);
       if tr>1000000000 then
        begin
         fl:=false;
         break;
        end;
      end;
    end;

  fl:=false;
  while not fl do
    begin
     readln(inp,s);
     if (copy(s,1,11)<>'Work time: ')or(copy(s,length(s)-2,3)<>' ms') then continue;
     delete(s,1,11);
     delete(s,length(s)-2,3);
     fl:=true;
     fwt:=0;
     while s[1] in ['0'..'9'] do
      begin
       fwt:=fwt*10;
       fwt:=fwt+ord(s[1])-ord('0');
       delete(s,1,1);
       if fwt>1000000 then
        begin
         fl:=false;
         break;
        end;
      end;
     if not fl then continue;
     if s[1]<>',' then
      begin
       fl:=false;
       continue;
      end;
     delete(s,1,1);
     while (length(s)<>0)do
      begin
       if not(s[1] in ['0'..'9']) then
        begin
         fl:=false;
         break;
        end;
       delete(s,1,1);
      end;
    end;
  fl:=false;
  while not fl do
    begin
     readln(inp,s);
     if (copy(s,1,11)<>'Work time: ')or(copy(s,length(s)-2,3)<>' ms') then continue;
     delete(s,1,11);
     delete(s,length(s)-2,3);
     fl:=true;
     swt:=0;
     while s[1] in ['0'..'9'] do
      begin
       swt:=swt*10;
       swt:=swt+ord(s[1])-ord('0');
       delete(s,1,1);
       if swt>1000000 then
        begin
         fl:=false;
         break;
        end;
      end;
     if not fl then continue;
     if s[1]<>',' then
      begin
       fl:=false;
       continue;
      end;
     delete(s,1,1);
     while (length(s)<>0)do
      begin
       if not(s[1] in ['0'..'9']) then
        begin
         fl:=false;
         break;
        end;
       delete(s,1,1);
      end;
    end;

  writeln(oup,'At randseed = ',tr);
  writeln(oup,'First: ',fwt);
  writeln(oup,'Second: ',swt);
  if fwt>mf then
   begin
    mf:=fwt;
    fo:=tr;
   end;
  if swt>ms then
   begin
    ms:=swt;
    so:=tr;
   end;
  mn:=[];
  while mn<>['-'] do
   begin
    mn:=[];
    readln(inp,s);
    for i:=1 to length(s) do
     begin
      mn:=mn+[s[i]];
     end;
   end;
 end;

 writeln(oup,'Maximal worktime for first: ',mf,' at randseed = ',fo);
 writeln(oup,'Maximal worktime for second: ',ms,' at randseed = ',so);
 close(inp);
 close(oup);


end.

