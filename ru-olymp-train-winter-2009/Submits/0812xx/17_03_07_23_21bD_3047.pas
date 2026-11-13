const
    str='ee-ee-eeee ee:ee:ee.ee - ';
    ls=25;

type
    int32=longint;
    bool=boolean;

var
    sp,rt,rd,wr:array [0..100000] of int32;
    dat,vr:array [0..100000] of string;
    p,i,l,sz,ch,min,sec,ts,tf,tt,pay,tr,tw,ls:int32;
    s:string;

begin
    assign(input,'calls.in');
    reset(input);
    assign(output,'calls.out');
    rewrite(output);
    readln(s); sz:=0;
    fillchar(dat,sizeof(dat),0);
    fillchar(vr,sizeof(vr),0);
    fillchar(sp,sizeof(sp),0);
    fillchar(rd,sizeof(rd),0);
    fillchar(wr,sizeof(wr),0);
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
                sz:=sz+1;
                for i:=1 to 10 do
                    dat[sz]:=dat[sz]+s[i];
                ch:=((byte(s[12])-48)*10)+(byte(s[13])-48);
                min:=((byte(s[15])-48)*10)+(byte(s[16])-48);
                sec:=((byte(s[18])-48)*10)+(byte(s[19])-48);
                for i:=12 to 19 do
                    vr[sz]:=vr[sz]+s[i];
                ts:=ch*3600+min*60+sec;
                i:=pos(' at ',s)+4;
                while s[i]<>'b' do
                begin
                    sp[sz]:=sp[sz]*10+byte(s[i])-48;
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
                rt[sz]:=tf-ts;
            end;
            if pos('Reads :',s)>0 then
            begin
                i:=pos('Reads :',s)+8;
                while s[i]<>' ' do
                begin
                    rd[sz]:=rd[sz]*10+byte(s[i])-48;
                    i:=i+1;
                end;
            end;
            if pos('Writes: ',s)>0 then
            begin
                i:=pos('Writes: ',s)+8;
                while s[i]<>' ' do
                begin
                    wr[sz]:=wr[sz]*10+byte(s[i])-48;
                    i:=i+1;
                end;
            end;
        end;
        readln(s);
    end;
    pay:=0; tt:=0; tr:=0; tw:=0;
    for i:=1 to sz do
    begin
         writeln(dat[i],' ',vr[i],' ',rt[i],' ',sp[i],' ',rd[i],'/',wr[i]);
         if rt[i]>=60 then pay:=pay+rt[i];
         tt:=tt+rt[i];
         tr:=tr+rd[i];
         tw:=tw+wr[i];
    end;
    writeln('Total seconds to pay = ',pay,', total seconds = ',tt,'; total bytes ',tr,'/',tw);
end.

