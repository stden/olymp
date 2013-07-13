const
    str='ee-ee-eeee ee:ee:ee.ee - ';
    ls=25;

type
    int32=longint;
    bool=boolean;

var
    sp,rt,rd,wr:int32;
    dat,vr:string;
    p,i,l,ch,min,sec,ts,tf,tt,pay,tr,tw,bo:int32;
    s:string;

begin
    assign(input,'calls.in');
    reset(input);
    assign(output,'calls.out');
    rewrite(output);
    readln(s);
    fillchar(dat,sizeof(dat),0);
    fillchar(vr,sizeof(vr),0);
    fillchar(sp,sizeof(sp),0);
    fillchar(rd,sizeof(rd),0);
    fillchar(wr,sizeof(wr),0);
    pay:=0; tt:=0; tr:=0; tw:=0; bo:=0;
    while not eof do
    begin
        l:=length(s); p:=1;
        if l>ls then
        begin
            for i:=1 to ls do
                if ((str[i]='e')and(s[i] in ['0'..'9']))or(str[i]=s[i]) then
                begin
                end
                    else p:=0;
        end;
        if p=1 then
        begin
            if pos('Connection established at',s)>0 then
            begin
                dat:=''; bo:=1;
                for i:=1 to 10 do
                    dat:=dat+s[i];
                ch:=((byte(s[12])-48)*10)+(byte(s[13])-48);
                min:=((byte(s[15])-48)*10)+(byte(s[16])-48);
                sec:=((byte(s[18])-48)*10)+(byte(s[19])-48);
                vr:='';
                for i:=12 to 19 do
                    vr:=vr+s[i];
                ts:=ch*3600+min*60+sec;
                i:=pos(' at ',s)+4;
                sp:=0;
                while s[i]<>'b' do
                begin
                    sp:=sp*10+byte(s[i])-48;
                    i:=i+1;
                end;
            end;
            if pos('Hanging up the modem.',s)>0 then
            begin
                ch:=((byte(s[12])-48)*10)+(byte(s[13])-48);
                min:=((byte(s[15])-48)*10)+(byte(s[16])-48);
                sec:=((byte(s[18])-48)*10)+(byte(s[19])-48);
                tf:=ch*3600+min*60+sec;
                if ts>tf then tf:=tf+86400;
                rt:=tf-ts;
            end;
            if pos('Reads :',s)>0 then
            begin
                i:=pos('Reads :',s)+8;
                rd:=0;
                while s[i]<>' ' do
                begin
                    rd:=rd*10+byte(s[i])-48;
                    i:=i+1;
                end;
            end;
            if pos('Writes: ',s)>0 then
            begin
                i:=pos('Writes: ',s)+8;
                wr:=0;
                while s[i]<>' ' do
                begin
                    wr:=wr*10+byte(s[i])-48;
                    i:=i+1;
                end;
            end;
            if (pos('Standard modem closed.',s)>0)and(bo=1) then
            begin
               writeln(dat,' ',vr,' ',rt,' ',sp,' ',rd,'/',wr);
               tr:=tr+rd; tw:=tw+wr;
               tt:=tt+rt;
               if rt>=60 then pay:=pay+rt;
               bo:=0;
            end;
        end;
        readln(s);
    end;
    {pay:=0; tt:=0; tr:=0; tw:=0;
    for i:=1 to sz do
    begin
         writeln(dat[i],' ',vr[i],' ',rt[i],' ',sp[i],' ',rd[i],'/',wr[i]);
         if rt[i]>=60 then pay:=pay+rt[i];
         tt:=tt+rt[i];
         tr:=tr+rd[i];
         tw:=tw+wr[i];
    end;}
    writeln('Total seconds to pay = ',pay,', total seconds = ',tt,'; total bytes ',tr,'/',tw);
end.

