program calls;

var tp,ts,tbr,tbw:longint; //total
    leng,start,wr,re,finish:longint;
    s,speed:string;
    i:longint;

function f(ch:char):longint;
begin
 f:=ord(ch)-ord('0');
end;

function get_time(s0:string):longint;
var res:longint;
begin
 res:=0;
 res:=f(s0[12])*10+f(s0[13]);
 res:=res*60+f(s0[15])*10+f(s0[16]);
 res:=res*60+f(s0[18])*10+f(s0[19]);
 get_time:=res;

end;

function get_bytes(s0:string):longint;
var ss:string;
    res,i0:longint;
begin

 ss:='';
 i0:=length(s);
 while not(s0[i0] in ['0'..'9']) do dec(i0);
 while (s0[i0] in ['0'..'9']) do
  begin
   ss:=s0[i0]+ss;
   dec(i0);
  end;
 res:=0;
 for i0:=1 to length(ss) do
  res:=res*10+f(ss[i0]);
 get_bytes:=res;

end;

begin
 assign(input,'calls.in');
 reset(input);
 assign(output,'calls.out');
 rewrite(output);

 tp:=0;  ts:=0; tbr:=0; tbw:=0;

  while not eof do
   begin

    readln(s);
    if pos('Connection established at ',s)<>0 then
     begin

       for i:=1 to 19 do
        write(s[i]);   ///// PRINT DATA
       start:=get_time(s);

       speed:='';
       for i:=1 to 4 do
        delete(s,length(s),1);
       while s[length(s)] in ['0'..'9'] do
        begin
         speed:=s[length(s)]+speed;
         delete(s,length(s),1);
        end;

       while pos('Hanging up the modem.',s)=0 do readln(s);

       finish:=get_time(s);
       if finish<start then finish:=finish+86400;

       leng:=finish-start;

       while pos('Reads',s)=0 do readln(s);
        re:=get_bytes(s);
       while pos('Writes',s)=0 do readln(s);
        wr:=get_bytes(s);

        //PRINT CURRENT LOG
       writeln('   ',leng,' ',speed,' ',re,'/',wr);
        ///ADD

       if leng>=60 then tp:=tp+leng;
       ts:=ts+leng;
       tbr:=tbr+re;
       tbw:=tbw+wr;

     end;

   end;

   write('Total seconds to pay = ',tp,', total seconds = ',ts,'; total bytes ',tbr,'/',tbw);

 close(input);
 close(output);
end.