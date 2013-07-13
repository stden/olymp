{$O-,Q-,R+}
unit dogen;
interface
uses dorand;
type integer=longint;
const MaxP=32;
      MaxR=32;
type ip=record
       a, b, c, d:integer;
     end;
     rule=record
       f, t:ip;
       m:integer;
       i1, i2, p:string;
     end;

var R:array [1..MaxP, 1..MaxR] of rule;
    RC, P:array [1..MaxP] of integer;
procedure randrule (var x:rule; min, max, maxl, pi1, pi2, pi3, pp1, pp2:integer; md, ld, ld2:rands);
procedure writerule (var x:rule);
procedure writepacket (var x:rule);
procedure matchingpacketbug2 (var x, y:rule; MaxL:integer);
procedure matchingpacketbug (var x, y:rule; MaxL:integer);
procedure matchingpacket (const x:rule; var y:rule; MaxL:integer);
procedure SmallTouch (var x, y:rule; MaxL:integer);

implementation


procedure rip (var cur:ip; min, max:integer);
begin
  cur.a:=lr (min, max);
  cur.b:=lr (min, max);
  cur.c:=lr (min, max);
  cur.d:=lr (min, max);
end;

function ipnum (var cur:ip):integer;
begin
  ipnum:=cur.a shl 24 + cur.b shl 16 + cur.c shl 8 + cur.d;
end;

const ss:string='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';

function randstr (l:integer):string;
var i:integer;
begin
  assert (l<=64);
  Result:='';
  for i:=1 to l do Result:=Result+ss[lr (1, 62)];
end;


function randnum (l:integer):string;
var i:integer;
begin
  Result:='';
  for i:=1 to l do Result:=Result+ss[lr (1, 10)];
end;


procedure randrule (var x:rule; min, max, maxl, pi1, pi2, pi3, pp1, pp2:integer; md, ld, ld2:rands);
var t, l:integer;
    s:string;
begin
  rip (x.f, min, max);
  x.m:=longrandd (0, 32, md);
  rip (x.t, min, max);
  t:=random (pi1+pi2+pi3);
  if t<pi1 then begin
    x.i1:=randstr (longrandd (1, maxl, ld));
    x.i2:='';
  end else
  if t<pi1+pi2 then begin
    l:=longrandd (1, 5, ld2);
    x.i1:=randnum (l);
    x.i2:=randnum (l);
    if x.i1>x.i2 then begin s:=x.i1; x.i1:=x.i2; x.i2:=s end;
  end else begin
    x.i1:='';
    x.i2:='';
  end;
  if random (pp1+pp2)<pp1 then x.p:=randstr (longrandd (1, maxl, ld)) else x.p:='';
end;

procedure writeip (var cur:ip);
begin
  write (cur.a, '.', cur.b, '.', cur.c, '.', cur.d);
end;

procedure writerule (var x:rule);
begin
  write ('F ');writeip (x.f);
  if (x.m<>32) or coin then write ('/', x.m);
  write (' T ');writeip (x.t);
  if x.i1<>'' then begin
    write (' I ', x.i1);
    if x.i2<>'' then write ('-', x.i2);
  end;
  if x.p<>'' then begin
    write (' P ', x.p);
  end;
  writeln;
end;


procedure writepacket (var x:rule);
begin
  write ('F ');writeip (x.f);
  write (' T ');write (x.t.a);
  if x.i1<>'' then begin
    write (' I ', x.i1);
  end;
  if x.p<>'' then begin
    write (' P ', x.p);
  end;
  writeln;
end;


procedure matchingpacketbug (var x, y:rule; MaxL:integer);
var tmp:string;
    i, z:integer;
begin
  y:=x;
  if x.m<32 then 
    for i:=1 to 239 do begin
      z:=lr (x.m, 31);
      if z>=24 then x.f.d:=x.f.d xor (1 shl (z-24)) else
      if z>=16 then x.f.c:=x.f.c xor (1 shl (z-16)) else
      if z>=8 then x.f.b:=x.f.b xor (1 shl (z-8)) else
      x.f.a:=x.f.a xor (1 shl (z))
    end;
  if x.i1='' then begin 
    if coin then y.i1:=randstr (lr (1, MaxL)) 
  end else
  if x.i2<>'' then begin
    repeat tmp:=randnum (length (x.i2)) until (tmp>=x.i1) and (tmp<=x.i2);
    y.i1:=tmp;
  end;
  if x.p='' then begin
    if coin then y.p:=randstr (lr (1, MaxL))
  end;
end;

procedure matchingpacketbug2 (var x, y:rule; MaxL:integer);
var tmp:string;
    i, z:integer;
begin
  y:=x;
  if x.m<32 then 
    for i:=1 to 239 do begin
      z:=lr (x.m, 31);
      if z>=24 then x.f.d:=x.f.d xor (1 shl (31-z)) else
      if z>=16 then x.f.c:=x.f.c xor (1 shl (23-z)) else
      if z>=8 then x.f.b:=x.f.b xor (1 shl (15-z)) else
      x.f.a:=x.f.a xor (1 shl (7-z))
    end;
  if x.i1='' then begin 
    if coin then y.i1:=randstr (lr (1, MaxL)) 
  end else
  if x.i2<>'' then begin
    repeat tmp:=randnum (length (x.i2)) until (tmp>=x.i1) and (tmp<=x.i2);
    y.i1:=tmp;
  end;
  if x.p='' then begin
    if coin then y.p:=randstr (lr (1, MaxL))
  end;
end;


procedure matchingpacket (const x:rule; var y:rule; MaxL:integer);
var tmp:string;
    i, z:integer;
begin
  y:=x;
  if x.m<32 then 
    for i:=1 to 239 do begin
      z:=lr (x.m, 31);
      if z>=24 then y.f.d:=y.f.d xor (1 shl (31-z)) else
      if z>=16 then y.f.c:=y.f.c xor (1 shl (23-z)) else
      if z>=8 then y.f.b:=y.f.b xor (1 shl (15-z)) else
      y.f.a:=y.f.a xor (1 shl (7-z))
    end;
  if x.i1='' then begin 
    if coin then y.i1:=randstr (lr (1, MaxL)) 
  end else
  if x.i2<>'' then begin
    repeat tmp:=randnum (length (x.i2)) until (tmp>=x.i1) and (tmp<=x.i2);
    y.i1:=tmp;
  end;
  if x.p='' then begin
    if coin then y.p:=randstr (lr (1, MaxL))
  end;
end;


procedure SmallTouch (var x, y:rule; MaxL:integer);
var z, steps:integer;
begin
  case random (3) of
    0:if x.m>0 then begin
        z:=lr (0, x.m-1);
        if z>=24 then y.f.d:=y.f.d xor (1 shl (31-z)) else
        if z>=16 then y.f.c:=y.f.c xor (1 shl (23-z)) else
        if z>=8 then y.f.b:=y.f.b xor (1 shl (15-z)) else
        y.f.a:=y.f.a xor (1 shl (7-z))
      end;
    1:begin
        if x.i2='' then y.i1:=randstr (lr (1, MaxL)) else begin
          steps:=0;
          repeat y.i1:=randnum (length (x.i2)); inc (steps);
          until (y.i1<x.i1) or (y.i1>x.i2) or (steps>500000);
        end;
      end;
    2:begin y.p:=randstr (lr (1, MaxL)) end;
  end;
end;

end.