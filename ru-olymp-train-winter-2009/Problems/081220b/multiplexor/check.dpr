{$O-,Q+,R+}
uses testlib, SysUtils;
type integer=longint;

const MaxL=10000;

type ip=record
          a, b, c, d:integer;
	end;
     anst=array [1..MaxL] of ip;
     

procedure readans (var f:instream; var a:anst; var ac:integer);
var cur:ip;
    f1:boolean;     
begin
  f1:=false;
  while not f.eof do begin
    if f.curchar='/' then begin
      f.reqstr ('/dev/null');
      fillchar (cur, sizeof (cur), 239)
    end else with cur do begin
      a:=f.roi; f.reqstr ('.'); if (a<0) or (a>255) then f1:=true;
      b:=f.roi; f.reqstr ('.'); if (b<0) or (b>255) then f1:=true;
      c:=f.roi; f.reqstr ('.'); if (c<0) or (c>255) then f1:=true;
      d:=f.roi; if (d<0) or (d>255) then f1:=true;
    end;
    inc (ac); if ac<=MaxL then a[ac]:=cur;
    f.seekeoln;
    f.reql (Accept);
  end;
  if f1 then f.quit (_WA, 'Invalid IP address');
end;


function ip2str (var cur:ip):string;
begin
  if cur.a<0 then Result:='/dev/null' else Result:=format ('%d.%d.%d.%d', [cur.a, cur.b, cur.c, cur.d]);
end;

var ja, ca:anst;
    i, jc, cc:integer;

begin
  readans (ans, ja, jc);
  readans (ouf, ca, cc);
  if (cc<>jc) then quit (_PE, 'invalid count of lines: '+i2s (cc)+' instead of '+i2s (jc));
  for i:=1 to jc do
    if (ca[i].a<>ja[i].a) or
       (ca[i].b<>ja[i].b) or
       (ca[i].c<>ja[i].c) or
       (ca[i].d<>ja[i].d) then quit (_WA, 
         format ('IP address mismatch in packet %d: %s instead of %s',
	   [i, ip2str (ca[i]), ip2str (ja[i])]
	 )
        );
  quit (_OK, i2s (cc)+' packets');   
end.