{$ifdef VER70}
{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
{$else}
{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O+,P-,Q+,R+,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE CONSOLE}
{$endif}
unit dorand;
{Библиотека генерации случайных тестов by Kitten Computing}
interface

{$ifndef VER70}
type integer = smallint;
const maxint = 32767;
{$endif}

type rands=function:extended;
type real=extended;
type float=extended;
type letters=set of char;
type charprob=array [#0..#255] of longint;
type charcum=record
    c:array [#0..#255] of longint;
    total:longint;
  end;

{равномерное распределение}
function lnd:extended;
{квадратичное распределение}
function sqd:extended;
{кубическое распределение}
function cbd:extended;
{распределение четвертой степени}
function qwd:extended;
{распределение пятой степени}
function fvd:extended;
{Гауссовское распределение}
function gauss:extended;
{Урезанное гауссовское распределение с дисперсией ~1/16,
 возвращаемое число всегда лежит в [0; 1)}
function gaussmod:extended;
{Генерация числа в заданных пределах по данному распределению}
{fromn<=longrandd<=ton}
{В случае использования с gauss, число может выходить за пределы}
function longrandd (fromn, ton:longint; func:rands):longint;
{Генерация числа в заданных пределах по равномерному распределению}
function longrand (fromn, ton:longint):longint;
function lr (f, t:longint):longint;
function lrandom (f, t:longint):longint;
{Пуассоновское распределение с параметром e}
{minval=0 или 1}
{maxval>=minval}
function Poisson (e:extended;minval, maxval:longint):longint;

{Регистрирует строковый параметр теста (для того, чтобы randseed
 зависел от теста фиксированным образом)}
procedure regstr (what:string);
{Регистрирует целый параметр теста}
procedure regint (p:longint);
{Регистрирует вещественный параметр теста}
procedure regfloat (p:float);

function coin:boolean;
function rpq(p, q:longint):boolean;

procedure prob2cum (var src:charprob; var dst:charcum);
procedure set2prob (src:letters; var dst:charprob);
procedure set2cum (src:letters; var dst:charcum);
function randomcharcum (var s:charcum):char;
function randomchar (s:letters):char;
procedure rwpchar (minl, maxl:word; sym:letters; dest:PChar);


procedure quite;
function longrandfixd (fromn, ton:longint; func:rands):longint;
function randr (fromn, ton:longint):longint;

procedure regptr (p:pointer);

function min (a, b:longint):longint;
function max (a, b:longint):longint;

implementation
const gaussn=24;


var stderropened, quitemode:boolean;
    stderr:text;


procedure quite;
begin
  quitemode:=true;
end;

procedure logerror (s:string);
begin
  if quitemode then exit;
  if not stderropened then begin assign (stderr, 'con'); rewrite (stderr) end;
  writeln (stderr, s);
end;


function lnd:extended;
begin
  lnd:=random;
end;


function sqd:extended;
begin
  sqd:=random*random;
end;


function cbd:extended;
begin
  cbd:=random*random*random;
end;


function qwd:extended;
begin
  qwd:=random*random*random*random;
end;


function fvd:extended;
begin
  fvd:=random*random*random*random*random;
end;


function gauss:extended;
var sum:extended;
    i:integer;
begin
  sum:=0;
  for i:=1 to gaussn do sum:=sum+random;
  sum:=sum-gaussn/2;
  sum:=sum*sqrt (12/gaussn);
  gauss:=sum;
end;


function gaussmod:extended;
var tmp:extended;
begin
  repeat
    tmp:=gauss/4+1/2;
  until (tmp>=0) and (tmp<1);
  gaussmod:=tmp;
end;

var lrerrorlogged:boolean;


function longrandd (fromn, ton:longint; func:rands):longint;
var rrange:extended;
begin
  rrange:=ton;
  rrange:=rrange-fromn+1;
  if ((fromn<0) or (ton<0)) and not lrerrorlogged then begin
    logerror (
      'WARNING: function longrand has a bug working with negative numbers'{#13#10
      'it is supported only for compatibility with old versions'#13#10+
      'use randr instead.');}
    );
    lrerrorlogged:=true;
  end;
  longrandd:=trunc (func*rrange+fromn);
end;

function longrandfixd (fromn, ton:longint; func:rands):longint;
var rrange:extended;
    tmp:extended;
begin
  rrange:=ton;
  rrange:=rrange-fromn+1;
  tmp:=func*rrange+fromn;
  if tmp<0 then longrandfixd:=-trunc (1-tmp) else longrandfixd:=trunc (tmp);
end;


function longrand (fromn, ton:longint):longint;
begin
  longrand:=longrandd(fromn, ton, lnd);
end;


function randr (fromn, ton:longint):longint;
begin
  randr:=longrandfixd(fromn, ton, lnd);
end;


function lr (f, t:longint):longint; begin lr:=longrand (f, t) end;
function lrandom (f, t:longint):longint; begin lrandom:=longrand (f, t) end;



function Poisson (e:extended;minval, maxval:longint):longint;
var i, r, Ps:longint;
begin
  if maxval=minval then begin Poisson:=minval; exit end;
  if minval>maxval then
    runerror (239);
  if not (minval in [0, 1]) then runerror (239);
  if e>maxval*1.2+4 then e:=maxval*1.2+4;
  Ps:=round (e*8)+100;
  repeat
    r:=0;
    for i:=1 to Ps do
      if random<e/Ps then inc (r);
  until (r<=maxval) and (r>=minval);
  Poisson:=r;
end;


{$ifndef VER70}
function gets (const s:string; symbol:integer):char;
begin
  if symbol=0 then Result:=chr (length (s)) else Result:=s[symbol];
end;
{$endif}



var rpar:longint;


{$Q-}
procedure regstr (what:string);
var s, s1:string;
    i:integer;
begin
  inc (rpar);
  str (rpar, s1);
  s:='Par'+s1+'='+what+'; ';
  {$ifdef VER70}
  for i:=1 to length (s) do
    inc (randseed, longint (sqr (ord (s[i])))*longint (sqr (ord (s[random (i+1)]))));
  {$else}
  for i:=1 to length (s) do
    inc (randseed, longint (sqr (ord (s[i])))*longint (sqr (ord (gets(s, random (i+1))))));
  {$endif}
end;
{$Q+}


procedure regint (p:longint);
var s:string;
begin
  str (p, s); regstr ('(int)'+s);
end;


procedure regfloat (p:float);
var s:string;
begin
  str (p, s); regstr ('(float)'+s);
end;


function coin:boolean;
begin
  coin:=random<0.5;
end;

function rpq(p, q:longint):boolean;
begin
  if q<=0 then runerror (239);
  rpq:=random<p/q;
end;


procedure prob2cum (var src:charprob; var dst:charcum);
var c:char;
begin
  dst.c[#0]:=0;
  for c:=#1 to #255 do dst.c[c]:=dst.c[pred (c)]+src[pred (c)];
  dst.total:=dst.c[#255]+src[#255];
end;


procedure set2prob (src:letters; var dst:charprob);
var c:char;
begin
  for c:=#0 to #255 do dst[c]:=ord (c in src);
end;


procedure set2cum (src:letters; var dst:charcum);
var tmp:charprob;
begin
  set2prob (src, tmp); prob2cum (tmp, dst);
end;


function randomcharcum (var s:charcum):char;
var r:longint;
    a, b, x:integer;
begin
  if s.total<=0 then runerror (239);
  r:=longrand (0, s.total-1);
  a:=-1; b:=256;
  {s.c[a]<=r<s.c[b]}
  while b-a>1 do begin
    x:=(a+b) shr 1;
    if (x>=256) or (x<0) then runerror (239);
    if r<s.c[chr (x)] then b:=x else a:=x;
  end;
  if (a<0) or (a>=256) then runerror (239);
  randomcharcum:=chr (a);
end;


function randomchar (s:letters):char;
var tmp:charcum;
begin
  set2cum (s, tmp); randomchar:=randomcharcum (tmp);
end;


{#0 could not be generated}
procedure rwpchar (minl, maxl:word; sym:letters; dest:PChar);
var tmp:charprob;
    cum:charcum;
    i:integer;
    len:word;
begin
  if #0 in sym then runerror (239);
  set2prob (sym, tmp); tmp[#0]:=0; prob2cum (tmp, cum);
  len:=lr (minl, maxl);
  for i:=0 to len-1 do dest[i]:=randomcharcum (cum);
  dest[len]:=#0;
end;


procedure regptr (p:pointer);
begin
  regint (longint (p));
end;


function min (a, b:longint):longint;
begin
  if a<b then min:=a else min:=b;
end;


function max (a, b:longint):longint;
begin
  if a>b then max:=a else max:=b;
end;

end.