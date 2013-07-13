{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
program macro;
uses testlib;
const eps=1e-12;
type integer=longint;
var a:array [1..200] of integer;
    fl:array [1..200] of boolean;
    c:array [1..200] of integer;
    s:array [1..3] of longint;
    n:integer;

function doinput (var f:instream):extended;
var i, j, k, t, cnt:integer;
    sum:longint;
    found:boolean;
    s3:extended;
begin
  fillchar (fl, sizeof (fl), 1);
  fillchar (s, sizeof (s), 0);
  fillchar (c, sizeof (c), 0);
  for k:=1 to 3 do
    begin
      cnt:=f.getint;
      if (cnt<0) or (cnt>n) then f.quit (_pe, 'Невозможно дать '+i2s (cnt)+' монеток');
      for i:=1 to cnt do
        begin
          t:=f.getint;
          found:=false;
          for j:=1 to n do
            if (fl[j]) and (a[j]=t) then
              begin
                found:=true;
                fl[j]:=false;
                c[j]:=k;
                inc (s[k], t);
                break;
              end;
          if not found then f.quit (_wa, 'Таких монет больше не осталось - '+i2s (t));
        end;
    end;
  for i:=1 to n do
    if fl[i] then f.quit (_wa, 'Мы не использовали монету '+i2s (a[i]));
  sum:=s[1]+s[2]+s[3];
  s3:=sum/3;
  doinput:=sqr (s[1]-s3)+sqr (s[2]-s3)+sqr (s[3]-s3);
end;


var i:integer;
    jury, cont:extended;


begin
  n:=inf.getint;
  for i:=1 to n do a[i]:=inf.getint;
  jury:=doinput (ans);
  cont:=doinput (ouf);
  if cont<jury-eps then quit (_fail, 'У жюри ответ хуже, чем у участника')
  else
  if jury<cont-eps then quit (_wa, 'У участника ответ хуже, чем у жюри');
  quit (_ok, '');
end.