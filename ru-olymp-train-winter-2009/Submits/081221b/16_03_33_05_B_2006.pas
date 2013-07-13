{$H+}
type integer=longint;
const
        Crandseed='randseed = ';
        Cworktime='Work time: ';
var
        fir,sec,MAx1,max2,tekrandseed,max1randseed,max2randseed,r,eobcount:integer;
        rnd,first,second:boolean;
        s:string;
function strtoint(var s:string):integer;
var i,rez:integer;
begin
        rez:=0;
        for i:=1 to length(s)do
                rez:=rez*10+ord(s[i])-ord('0');
        strtoint:=rez;
end;
function ISrandseed(var s:string):integer;
var
        fl:boolean;
        i,rez:integer;
        s1:string;
begin
        fl:=false;
        for i:=1 to 11 do if Crandseed[i]<>s[i]then fl:=true;
        i:=12;
        s1:='';
        rez:=-1;
        if not fl then begin
                while i<=length(s) do begin
                        s1:=s1+s[i];
                        inc(i);
                end;
                rez:=strtoint(s1);
                rnd:=true;
        end;
        ISrandseed:=rez;
end;
function IsWorkTime(var s:string):integer;
var
        i,rez:integer;
        fl:boolean;
        s1:string;
begin
        fl:=false;rez:=-1;
        if (s[length(s)]<>'s')or(s[length(s)-1]<>'m')then fl:=true;
        for i:=1 to 11 do if s[i]<>CWorkTime[i]then fl:=true;
        if not fl then begin
                i:=12;
                while (s[i]<>',')and(s[i] in ['0'..'9'])do begin
                        s1:=s1+s[i];
                        inc(i);
                end;
                rez:=strtoint(s1);
        end;
        IsWorkTime:=rez;
end;
procedure ISEOB(var s:string);
var
        fl:boolean;
        i:integer;
begin
        fl:=true;
        for i:=1 to length(s)do if s[i]<>'-'then fl:=false;
        if fl then inc(EOBCOUNT);
end;
begin
        assign(input,'stress.in');
        assign(output,'stress.out');
        reset(input);
        rewrite(output);
        RND:=false;
        FIRST:=false;
        while not eof do begin

                readln(s);
                ISEOB(s);
                r:=ISrandseed(s);
                if r<>-1 then tekrandseed:=r;
                r:=IsWorkTime(s);
                if (r<>-1)and rnd then begin
                        if first and not second then begin
                                sec:=r;
                                second:=true
                        end else if (not first)and(not second)then begin
                                fir:=r;
                                first:=true;
                        end;
                end;
                if Max1<fir then begin
                        Max1:=fir;
                        Max1Randseed:=tekrandseed;
                end;
                if Max2<sec then begin
                        Max2:=sec;
                        Max2Randseed:=tekrandseed;
                end;
		if (EOBCOUNT mod 2=0)and(EOBCOUNT<>0) then begin
                        writeln('At randseed = ',TekRandSeed);
                        writeln('First: ',fir,' ms');
                        writeln('Second: ',sec,' ms');
                        rnd:=false;
                        first:=false;
                        second:=false;
                end;
        end;
        writeln('Maximal work time for first: ',max1,' at randseed = ',max1randseed);
        writeln('Maximal work time for second: ',max2,' at randseed = ',max2randseed);
end.
