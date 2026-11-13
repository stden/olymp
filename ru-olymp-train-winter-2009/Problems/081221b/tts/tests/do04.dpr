{$I trans.inc}
uses dorand, SysUtils;
type integer=longint;

const V=3;
      MinL=1;
      MaxL=1;
      MaxQ=3;
      Cmd=20;
      P1=1;
      P2=3;
      Pa1=1;
      Pa2=3;

function randomchar:char;
var t:integer;
begin
  t:=random (random (27));
  Result:=chr (t+97);
end;


var vertices:array [1..V+2] of string;
    e, f:array [1..V+2] of boolean;
    i, j, L, Q, v1, v2, sign, utime:integer;
    s:string;
    dir:boolean;
    enabled:integer;

begin
  regint (4);
  for i:=1 to V do begin
    L:=lr (MinL, MaxL);
    setlength (s, L); for j:=1 to Length (S) do s[j]:=randomchar;
    vertices[i]:=s;
  end;
  vertices[V+1]:='initial';
  vertices[V+2]:='final';
  utime:=lr (1000000000, 1100000000);
  for i:=1 to CMD do begin
    write (utime, #9); inc (utime, lr (0, 50));
    if random (P2)<P1 then begin
      write ('RIGHTS'#9);
      for j:=1 to 4 do begin
        write (lr (1, 254));
        if j<4 then write ('.') else write (#9);
      end;
      repeat
        v1:=lr (1, V+2);
        v2:=lr (1, V+2);
      until (v1<>v2) and e[v1] and e[v2];
      writeln (vertices[v1]+#9+vertices[v2]);
    end else begin
      dir:=coin;
      sign:=random (3);
      case sign of
        0:write ('=');
        1:write ('+');
        2:write ('-');
      end;
      if dir then write ('RG'#9) else write ('GR'#9);
      for j:=1 to 4 do begin
        write (lr (1, 254));
        if j<4 then write ('.') else write (#9);
      end;
      v1:=lr (1, V+1);
      if not dir and (v1=V+1) then inc (v1);
      write (vertices [v1], #9);
      e[v1]:=true;
      if random (Pa2)<Pa1 then write ('-'#9) else
      write (format ('0x%x'#9, [
      randr (2*-(1 shl 30), 1 shl 30 + (2*(1 shl 29) - 1))
      ]));
      Q:=lr (1, MaxQ);
      fillchar (f, sizeof (f), 0);
      for j:=1 to Q do begin
        repeat
          v2:=lr (1, V+1);
          if dir and (v2=V+1) then inc (v2);
        until (v2<>v1) and not f[V2];
        f[v2]:=true; e[v2]:=true;
        write (vertices[v2]);
        if j<Q then write (#9) else writeln;
      end;
    end;
  end;
end.