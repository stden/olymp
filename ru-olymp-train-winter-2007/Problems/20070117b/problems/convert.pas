{$I+,O-,Q+,R+}
{Topcoder Convert 0.1 by Andrew Lopatin}
unit convert;

interface

uses SysUtils, Math;

type tarrstr=array of string;
     pfunc=procedure;

procedure eat (c:char);
function getword (c:char):string;
function getquoted:string;
procedure getlist (var a:tarrstr);
procedure getquotedlist (var a:tarrstr);
procedure process (func, fclose:pfunc; digits:integer; const fname:string);overload;
procedure process (func, fclose:pfunc; digits:integer);overload;
procedure process (func, fclose:pfunc; const fname:string);overload;
procedure process (func, fclose:pfunc);overload;
procedure outspaced (const a:tarrstr); overload; 
procedure outspaced (const a:tarrstr; var f:text); overload;
procedure outenter (const a:tarrstr); overload;
procedure outenter (const a:tarrstr; var f:text); overload;


var answer:text;
    cnt:integer;
    s:string;

implementation



procedure nextfile (digits:integer);overload;
begin
  inc (cnt);
  {$I-}
  {if not allowoverwrite then begin
    reset (output, format ('%.2d', [cnt]));
    assert (ioresult<>0);
  end;}
  rewrite (output, format ('%.*d', [digits, cnt]));
  assert (ioresult=0);
  {if not allowoverwrite then begin
    reset (answer, format ('%.2d.a', [cnt]));
    assert (ioresult<>0);
  end;}
  rewrite (answer, format ('%.*d.a', [digits, cnt]));
  assert (ioresult=0);
  {$I+}
end;

procedure closefile;
begin
  close (output);
  close (answer);
end;


procedure eat (c:char);
begin
//  writeln (erroutput, c, ' ', s);
  assert (s[1]=c); delete (S, 1, 1); s:=trim (s);
end;


function getword (c:char):string;
var x:integer;
begin
  x:=pos (c, s);
//  writeln (erroutput, s); 
  assert (x<>0);
  Result:=copy (s, 1, x-1);
  delete (s, 1, x-1);
  eat (c);
end;


function getquoted:string;
begin
  eat ('"');
  Result:=getword ('"');
end;


procedure getquotedlist (var a:tarrstr);
var x:integer;
begin
  setlength (a, 0);
  eat ('{');
  repeat
    setlength (a, length (a)+1);
    eat ('"');
    x:=pos ('"', s);
    a[high (a)]:=copy (s, 1, x-1);
    delete (s, 1, x-1);
    eat ('"');
    if s[1]<>',' then break;
    eat (',');
  until false;
  eat ('}');
end;



procedure getlist (var a:tarrstr);
var x, y:integer;
begin
  setlength (a, 0);
  eat ('{');
  repeat
    setlength (a, length (a)+1);
    x:=pos (',', s);
    y:=pos ('}', s);
    if (x>0) and (x<y) then y:=x;
    a[high (a)]:=copy (s, 1, y-1);
    delete (s, 1, y-1);
    if s[1]<>',' then break;
    eat (',');
  until false;
  eat ('}');
end;



procedure process (func, fclose:pfunc; digits:integer; const fname:string);overload;
begin
  reset (input, fname);
  cnt:=0; nextfile (digits);
  repeat
    repeat
      if eof then begin closefile; exit end;
      readln (s); s:=trim (s);
    until s<>'';
    s:=s+' '#0;
    func;
    if not seekeof then begin fclose; closefile; nextfile (digits) end;
  until eof;
  fclose;
  closefile;
end;

procedure process (func, fclose:pfunc; digits:integer);overload;
begin
  process (func, fclose, digits, 'test');
end;


procedure process (func, fclose:pfunc; const fname:string);overload;
begin
  process (func, fclose, 2, fname);
end;

procedure process (func, fclose:pfunc);overload;
begin
  process (func, fclose, 2, 'test');
end;

procedure outspaced (const a:tarrstr; var f:text);
var i:integer;
begin
  for i:=low (a) to high (a) do begin
    write (f, a[i]);
    if i<high (a) then write (f, ' ') else writeln (f);
  end;
end;

procedure outspaced (const a:tarrstr);
var i:integer;
begin
  for i:=low (a) to high (a) do begin
    write (a[i]);
    if i<high (a) then write (' ') else writeln;
  end;
end;

procedure outenter (const a:tarrstr; var f:text);
var i:integer;
begin
  for i:=low (a) to high (a) do writeln (f, a[i]);
end;

procedure outenter (const a:tarrstr);
var i:integer;
begin
  for i:=low (a) to high (a) do writeln (a[i]);
end;

end.