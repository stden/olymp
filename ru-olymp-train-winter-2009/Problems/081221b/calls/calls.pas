{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O+,P+,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
uses testjury;

var s:string;
    p:integer;



function nextchar:char;
begin
  nextchar:=s[p]; if s[p]<>#0 then inc (p);
end;


function twodigits (var v:integer):boolean;
var c1, c2:char;
begin
  c1:=nextchar; c2:=nextchar;
  twodigits:=false;
  if not ((c1 in ['0'..'9']) and (c2 in ['0'..'9'])) then exit;
  v:=(ord (c1)-48)*10+ord (c2)-48;
  twodigits:=true;
end;

const ms:array [1..12] of integer=
(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
const ls:array [1..12] of integer=
(31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

var i:integer;
    dd, mm, y1, y2, yy, h, m, sc, z, ld, lmt, ly, lh, lm, lsc, lz:integer;
    bd, bmt, by, bh, bm, bs, ud:integer;
    sl, total, totalpay, totalread, totalwritten, cread, cwritten:longint;
    ttt:integer;
    vs, tmp:string;
    sess, closing, reads, writes:boolean;

begin
  ci ('calls.in'); ao ('calls.out');
  while not eof do begin
    s:=readstring; p:=1;
    test (length (s)<=250);
    s:=s+#0;
    for i:=1 to length (s) do if not (s[p] in [#32..#255]) then test (false);
    if not twodigits (mm) or (nextchar<>'-') or
       not twodigits (dd) or (nextchar<>'-') or
       not twodigits (y1) or
       not twodigits (y2) or (nextchar<>' ') or
       not twodigits (h) or (nextchar<>':') or
       not twodigits (m) or (nextchar<>':') or
       not twodigits (sc) or (nextchar<>'.') or
       not twodigits (z) or (nextchar<>' ') or
       (nextchar<>'-') or (nextchar<>' ') then begin
         {writeln ('<invalid: ', s, '>');}
         continue;
       end;
    yy:=y1*100+y2;
    if (mm<1) or (mm>12) or (yy<1980) or (yy>2099) or (h<0) or (h>23) or
       (m<0) or (m>59) or (sc<0) or (sc>59) or (z<0) or (z>99) or (dd<1) then
         test (false);
    if (yy and 3)=0 then ud:=ls[mm] else ud:=ms[mm];
    test (dd<=ud);
    if (yy<ly) or ((yy=ly) and ((mm<lmt) or ((mm=lmt) and
       ((dd<ld) or ((dd=ld) and ((h<lh) or ((h=lh) and
       ((m<lm) or ((m=lm) and ((sc<lsc) or ((sc=lsc) and (z<lz))))))))))))
       then test (false);
    ly:=yy; lmt:=mm; ld:=dd; lh:=h; lm:=m; lsc:=sc; lz:=z;
    vs:=copy (s, p, 255);
    if copy (vs, 1, 26)='Connection established at ' then begin
      p:=27; tmp:='';
      while vs[p] in ['0'..'9'] do begin tmp:=tmp+vs[p]; inc (p) end;
      if (copy (vs, p, 255)='bps.'#0) and (length (tmp)>0) then begin
        test (not sess and not closing);
        sess:=true;
        write (copy (s, 1, 19));
        bmt:=mm; bd:=dd; by:=yy; bh:=h; bm:=m; bs:=sc;
      end else test (false);
    end;
    if vs='Hanging up the modem.'#0 then begin
      test (not closing);
      if sess then begin
        sess:=false;
        closing:=true; reads:=false; writes:=false;
        sl:=longint (h-bh)*3600+(m-bm)*60+(sc-bs);
        if sl>=0 then test ((by=yy) and (bmt=mm) and (bd=dd)) else begin
          if (by and 3)=0 then ud:=ls[bmt] else ud:=ms[bmt];
          if (bd<ud) then test ( (bd+1=dd) and (bmt=mm) and (by=yy) ) else
          if (bmt<12) then test ( (bd=ud) and (dd=1) and (bmt+1=mm) and (by=yy) ) else
          test ( (bd=ud) and (ud=31) and (bmt=12) and (mm=1) and (by+1=yy) );
        end;
        if sl<0 then sl:=sl+86400;
        test (sl<43200);
        inc (total, sl); if sl>=60 then inc (totalpay, sl);
        write (sl:6, ' ', tmp, ' ');
      end;
    end;
    if copy (vs, 1, 23)='               Reads : ' then begin
      test (not sess);
      if closing then begin
        test (not reads and not writes);
        p:=24; tmp:='';
        while vs[p] in ['0'..'9'] do begin tmp:=tmp+vs[p]; inc (p) end;
        if (copy (vs, p, 255)=' bytes'#0) and (length (tmp)>0) then begin
          write (tmp, '/');
          val (tmp, cread, ttt); test (ttt=0);
          inc (totalread, cread);
          test ((totalread>=0) and (cread>=0));
          reads:=true;
        end else test (false);
      end;
    end;
    if copy (vs, 1, 23)='               Writes: ' then begin
      test (not sess);
      if closing then begin
        test (reads and not writes);
        p:=24; tmp:='';
        while vs[p] in ['0'..'9'] do begin tmp:=tmp+vs[p]; inc (p) end;
        if (copy (vs, p, 255)=' bytes'#0) and (length (tmp)>0) then begin
          writeln (tmp);
          val (tmp, cwritten, ttt); test (ttt=0);
          inc (totalwritten, cwritten);
          test ((totalwritten>=0) and (cwritten>=0));
          writes:=true;
        end else test (false);
      end;
    end;
    if vs='Standard Modem closed.'#0 then begin
      test (not sess);
      if closing then begin
        test (reads and writes);
        closing:=false; reads:=false; writes:=false;
      end;
    end;
  end;
  writeln ('Total seconds to pay = ', totalpay, ', total seconds = ',
           total, '; total bytes ', totalread, '/', totalwritten);
end.