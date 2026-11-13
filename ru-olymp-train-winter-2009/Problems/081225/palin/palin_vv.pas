

uses SysUtils,Math;

type integer = longint;
const MAXN = 3000000;

procedure errquit(errcode:integer;s:string);
begin
        writeln(erroutput,s);
        halt(errcode);
end;

var s:array[1..MAXN] of char;
        c:char;
        n:integer;
        k,i,j,ii,jj:integer;
        ok:boolean;
begin
        assign(input,'palin.in'); reset(input);
        assign(output,'palin.out'); rewrite(output);
        n:=0;
        while (not eoln) do begin
                read(c);
                if (c<>'0') and (c<>'1') then errquit(53,'STRING CONTAINS NOT ONLY 0 AND 1'); 
                inc(n);
                if (n>MAXN) then errquit(53,'STRING IS TOO LONG');
                s[n]:=c;
        end;
        {writeln(n);}
        ok:=true;
        for i:=1 to n div 2 do begin
                if (s[i]<>s[n+1-i]) then begin
                        ok:=false;
                        break;
                end;
        end;
        if (ok) then begin
                writeln(1);
                for i:=1 to n do write(s[i]);
                writeln;
                close(output); exit;
        end;
        i:=0; j:=n+1;
        writeln(2);
        while (i<j) do begin
                ii:=i; jj:=j;
                inc(i); dec(j);
                while (s[i]='0') do inc(i);
                while (s[j]='0') do dec(j); 
                if (i<=j) then begin
                        for k:=min(i-ii-1,jj-j-1)+1 to i-ii-1 do begin
                                write('0');
                                s[k+ii]:=#0;
                        end;
                        for k:=min(i-ii-1,jj-j-1)+1 to jj-j-1 do begin
                                write('0');
                                s[k+j]:=#0;
                        end;
                end;
        end;
        writeln;
        for i:=1 to n do if (s[i]<>#0) then write(s[i]);
        writeln;
end.
