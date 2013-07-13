(*{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}*)
{!PASLIB 1.0 Copyright (c) Антон Суханов, 1996}
{Функции работы со строками}

{Дата последнего изменения: 11/11/96}

{Managed by Kitten Computing from 02/12/01}
{$I trans.inc}

unit symbols;

INTERFACE

{$ifndef VER70}
type integer = smallint;
const maxint = 32767;
{$endif}

function StrError: boolean;

function GetParam (s: string; n: integer): string;
         {Достает параметр N n, при этом учитываются кавычки; "" = " "}
function CutParam (var s: string; n: integer): string;
         {Тоже, но вырезает параметр из строки}

function cmpbin (var a, b; len: integer): integer;
         {Двоичное сравнение, case sensitive}
{$IFDEF VER70}
function cmpasc (var a, b; len: integer): integer;
         {Сравнение строк, case not sensitive}
function cmpstr (s1, s2: string): integer;
         {Сравнение строк, case not sensitive}
{$ENDIF}

function CalcWords (s: string): integer; {сколько слов}
function E_str (x: longint; width: integer; osn: integer; fill: char): string;
function str (x: longint; width: integer): string;
function RealStr (x: real; w, d: integer): string;
function compress (s: string): string;
procedure FastCompress (var s: string);
function Bin2Str (var a; len: integer): string;
function  UpStr (s: string): string;
function UpChar (c: char): char;
function LowChar (c: char): char;
procedure FastUpcaseStr (var s: string);
function LoStr (s: string): string;
function IntegerVal (s: string): integer;
function LongintVal (s: string): longint;
function RealVal (s: string): real;
function split (s: string; c: char; var a, b: string): boolean;
function AliLeft (s: string; width: integer): string;
function RepeatStr (s: string; cnt: integer): string;
function AliCentre (s: string; width: integer): string;
function AliRight (s: string; width: integer): string;
function AliLR (left: string; right: string; width: integer): string;
function DeleteQuoters (s: string): string;

IMPLEMENTATION

var error: boolean;

function StrError: boolean;
begin
   StrError := error
end;

function DeleteQuoters (s: string): string; {НЕЭФФЕКТИВНО!!!}
{var p: integer;}
begin
   while pos (s, '''') <> 0 do delete (s, pos (s,''''),1);
   while pos (s, '"') <> 0 do delete (s, pos (s,'"'),1);
   DeleteQuoters := s;
end;

{Для внутреннего использования}
Function LocateParam (s: string; n: integer; var i, j: integer): Boolean;
var len: integer;
begin
   LocateParam := False;
   if n < 1 then Exit;

   j := 0; len := length (s);
   repeat
      i := j+1;
      while (i<=len) and (s [i] = ' ') do inc (i);
      if i > len then exit;
      j := i+1;

      if (s [i] = '''') or (s [i] = '"') then
         while (j<=len) and (s [j] <> s [i]) do inc (j)
      else
         while (j<=len) and (s [j] <> ' ') do inc (j);

      if (j > len) or (s [j] = ' ') then dec (j);
      dec (n);
   until (n = 0);
   LocateParam := True;
end;

function GetParam (s: string; n: integer): string;
         {Достает параметр N n, при этом учитываются кавычки; "" = " "}
var i, j: integer;
{    help: string;}
begin
   if not LocateParam (s, n, i, j) then GetParam := ''
   else begin
      if (s [i] = '''') or ( s [i] = '"') then inc (i);
      if (s [j] = '''') or ( s [j] = '"') then dec (j);
      if i <= j then  GetParam := Copy (s, i, j-i+1)
                else  GetParam := ' ';
   end;
end;

function CutParam (var s: string; n: integer): string;
         {Тоже, но вырезает параметр из строки}
var i, j, i1, j1: integer;
{    help: string;}
begin
   if not LocateParam (s, n, i, j) then CutParam := ''
   else begin
      i1 := i; j1 := j;
      if (s [i] = '''') or ( s [i] = '"') then inc (i);
      if (s [j] = '''') or ( s [j] = '"') then dec (j);
      if i <= j then  CutParam := Copy (s, i, j-i+1)
                else  CutParam := ' ';
      delete (s, i1, j1-i1+1);
   end;
end;



function cmpbin (var a, b; len: integer): integer;
var x: array [1..65520] of char absolute a;
    y: array [1..65520] of char absolute b;
    i: word;
begin
   for i := 1 to len do
      if x [i] <> y [i] then
      begin
         if x [i] < y [i] then cmpbin := -1
                          else cmpbin := +1;
         exit
      end;

   cmpbin := 0;
end;

{$IFDEF VER70}
function cmpasc (var a, b; len: integer): integer;
label c1, c2;
begin
   asm
      push ds; lds di, dword ptr a; les si, dword ptr b;
      mov cx, len;
      @@1: mov ah, [di]; mov bh, es: [si];

           cmp ah, 'A'; jc @@2; cmp ah, 'Z'+1; jnc @@2
           add ah, 'a'-'A'
           jmp @@3
      @@2: cmp ah, 'А'; jc @@3; cmp ah, 'Я'+1; jnc @@3
           add ah, 'а'-'А'
           cmp ah, 'Р'+'а'-'А'; jc @@3
           add ah, 'А'-'а'+'р'-'Р'
      @@3: cmp bh, 'A'; jc @@4; cmp bh, 'Z'+1; jnc @@4
           add bh, 'a'-'A'
           jmp @@5
      @@4: cmp bh, 'А'; jc @@5; cmp bh, 'Я'+1; jnc @@5
           add bh, 'а'-'А'
           cmp bh, 'Р'+'а'-'А'; jc @@5
           add bh, 'А'-'а'+'р'-'Р'

      @@5: cmp ah, bh
           jg  c1; jl c2;
           inc si; inc di
      loop @@1
      pop ds
   end;

   cmpasc := 0; exit;
   c1: asm pop ds end; cmpasc := 1;  exit;
   c2: asm pop ds end; cmpasc := -1; exit;
end;

function cmpstr (s1, s2: string): integer;
begin
   if length (s1) < length (s2) then
      case cmpasc (s1 [1], s2 [1], length (s1)) of
          0: cmpstr := -1;
          1: cmpstr := 1;
         -1: cmpstr := -1
      end
   else if length (s1) > length (s2) then
      case cmpasc (s1 [1], s2 [1], length (s2)) of
          0: cmpstr := 1;
          1: cmpstr := 1;
         -1: cmpstr := -1
      end
   else cmpstr := cmpasc (s1 [1], s2 [1], length (s1));
end;
{$ENDIF}


function UpStr (s: string): string;
var i: integer; c: char;
begin
   for i := 1 to length (s) do
   begin
      c := s [i];
        if (c >= 'a') and (c <= 'z') then s [i] := chr (ord(c)-ord('a')+ord('A'))
      else
        if (c >= 'а') and (c <= 'п') then s [i] := chr (ord(c)-ord('а')+ord('А'))
      else
        if (c >= 'р') and (c <= 'я') then s [i] := chr (ord(c)-ord('р')+ord('Р'));
   end;
   UpStr := s
end;

function UpChar (c: char): char;
begin
      if (c >= 'a') and (c <= 'z') then UpChar := chr (ord(c)-ord('a')+ord('A'))
   else
      if (c >= 'а') and (c <= 'п') then UpChar := chr (ord(c)-ord('а')+ord('А'))
   else
     if (c >= 'р') and (c <= 'я') then UpChar := chr (ord(c)-ord('р')+ord('Р'))
   else
     UpChar := c; {!!!}
end;

function LowChar (c: char): char;
begin
      if (c >= 'A') and (c <= 'Z') then LowChar := chr (ord(c)-ord('A')+ord('a'))
   else
      if (c >= 'А') and (c <= 'П') then LowChar := chr (ord(c)-ord('А')+ord('а'))
   else
     if (c >= 'Р') and (c <= 'Я') then LowChar := chr (ord(c)-ord('Р')+ord('р'))
   else
     LowChar := c; {!!!}
end;


procedure FastUpcaseStr (var s: string);
var i: integer; c: char;
begin
   for i := 1 to length (s) do
   begin
      c := s [i];
        if (c >= 'a') and (c <= 'z') then s [i] := chr (ord(c)-ord('a')+ord('A'))
      else
        if (c >= 'а') and (c <= 'п') then s [i] := chr (ord(c)-ord('а')+ord('А'))
      else
        if (c >= 'р') and (c <= 'я') then s [i] := chr (ord(c)-ord('р')+ord('Р'));
   end;
end;

function LoStr (s: string): string;
var i: integer; c: char;
begin
   for i := 1 to length (s) do
   begin
      c := s [i];
        if (c >= 'A') and (c <= 'Z') then s [i] := chr (ord(c)-ord('A')+ord('a'))
      else
        if (c >= 'А') and (c <= 'П') then s [i] := chr (ord(c)-ord('А')+ord('а'))
      else
        if (c >= 'Р') and (c <= 'Я') then s [i] := chr (ord(c)-ord('Р')+ord('р'));
   end;
   LoStr := s
end;

function LongintVal (s: string): longint;
const digits: set of char = ['1','2','3','4','5','6','7','8','9','0'];
var sgn: integer;
    i: integer;
    x: longint;
begin
   error := false; LongintVal:=0;
   s [length(s)+1] := #0;
   i := 1; while s [i] = ' ' do i := i+1;
   if s [i] = '-' then begin sgn := -1; inc (i) end else sgn := 1;
   if not (s [i] in digits) then begin error := true; exit end;
   x := 0;
   repeat
      x := x * 10 + ord (s [i]) - ord ('0'); inc (i);
   until not (s [i] in Digits);
   x := x * sgn;
   while s [i] = ' ' do inc (i);
   error := s [i] <> #0;
   LongintVal := x;
end;

function IntegerVal (s: string): integer;
const digits: set of char = ['1','2','3','4','5','6','7','8','9','0'];
var sgn: integer;
    i: integer;
    x: longint;
begin
   error := false; IntegerVal := 0;
   s [length(s)+1] := #0;
   i := 1; while s [i] = ' ' do i := i+1;
   if s [i] = '-' then begin sgn := -1; inc (i) end else sgn := 1;
   if not (s [i] in digits) then begin error := true; exit end;
   x := 0;
   repeat
      x := x * 10 + ord (s [i]) - ord ('0'); inc (i);
   until not (s [i] in Digits);
   x := x * sgn;
   while s [i] = ' ' do inc (i);
   error := s [i] <> #0;
   IntegerVal := x;
end;

function RealVal (s: string): real;
var r: real;
{$IFNDEF VER70}
    Code: longint;
{$ELSE}
    Code: integer;
{$ENDIF}
begin
   val (s, r, Code);
   RealVal := r;
   error := Code <> 0;
end;

function RealStr (x: real; w, d: integer): string;
var r: string;
begin
   system.Str (x:w:d, r);
   RealStr := r
end;

function RepeatStr (s: string; cnt: integer): string;
var res: string;
    i: integer;
begin
   res := ''; for i := 1 to cnt do res := res + s;
   repeatstr := res
end;

function AliLeft (s: string; width: integer): string;
begin
   if length (s) > width then AliLeft := copy (s, 1, width)
                         else AliLeft := s + repeatstr (' ', width-length(s));
end;

function AliLR (left: string; right: string; width: integer): string;
var x: integer;
begin
   x := Length (left) + length (right);
   if x > width then
      AliLR := copy (left + right, 1, width)
   else
      AliLR := left + repeatstr (' ', width - x) + right
end;

function AliCentre (s: string; width: integer): string;
begin
   if length (s) > width then AliCentre := copy (s, 1 + (length (s)-width) div 2, width)
                         else AliCentre := repeatstr (' ', (-length (s)+width) div 2) +
                                           s +
                                           repeatstr (' ',width - length (s) - (-length (s)+width) div 2);
end;

function AliRight (s: string; width: integer): string;
begin
   if length (s) > width then AliRight := copy (s, 1, width)
                         else AliRight := repeatstr (' ', width-length(s)) + s;
end;

function Bin2Str (var a; len: integer): string;
var r: string;
    s: array [1..65520] of char absolute a;
begin
   {$IFDEF VER70}
   r [0] := chr (len); 
   {$ELSE}
   setlength (r, len);
   {$ENDIF}
   move (a, r [1], len);
   Bin2Str := r
end;

function CalcWords (s: string): integer; {сколько слов}
var i: integer;
    r: integer;
begin
   if s = '' then calcwords := 0
   else begin
       r := 0;
       for i := 1 to length (s)-1 do
          if (s [i] = ' ') and (s [i+1] <> ' ') then inc (r);
       if s [1] <> ' ' then inc (r);
       calcwords := r
   end;
end;

function E_Str (x: longint; width: integer; osn: integer; fill: char): string;
const Digits: array [0..15] of char = '0123456789ABCDEF';
var r: string;
    sgn: integer;
begin
   if x < 0 then sgn := 1 else sgn := 0;
   x := abs (x);
   r := '';
   repeat
      r := Digits [x mod osn] + r; x := x div osn;
      dec (width);
   until (x = 0) or (width=0);
   if (sgn = 1) then r := '-' + r;
   while width - sgn > 0 do begin r := fill + r; dec (width) end;
   E_Str := r;
end;

function Str (x: longint; width: integer): string;
begin
   Str := E_Str (x, width, 10, ' ');
end;

procedure FastCompress (var s: string);
var i, j: integer;
begin
   i := 1; while (i<=length(s)) and (s [i] = ' ') do inc (i);
   if i > length (s) then s := ''
   else begin
     j := length (s); while s [j] = ' ' do dec (j);
     s := copy (s, i, j-i+1);
  end;
end;

function Compress (s: string): string;
begin
   FastCompress (s);
   Compress := s;
end;

function split (s: string; c: char; var a, b: string): boolean;
var i: integer;
begin
   i := 1;
   while (i<=length(s)) and (s [i] = ' ') do inc (i);
   while (i<=length(s)) and (s [i] <> c) do inc (i);

   if i > length (s) then
   begin
      a := compress (s);
      b := '';
      split := false;
   end
   else begin
      a := compress (copy (s, 1, i-1));
      b := compress (copy (s, i+1, length (s)));
      split := true;
   end;
end;

BEGIN {Инициализация}

END.
