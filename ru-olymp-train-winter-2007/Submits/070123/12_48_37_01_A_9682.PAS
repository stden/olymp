{$MODE DELPHI}
{$GOTO ON}
{-$DEFINE DEBUG}
{$UNDEF DEBUG}
{$IFNDEF DEBUG}
	{$R-,Q-,S-,I-}
{$ENDIF}
uses SysUtils;
const
	REPP = 1000;
  EPS = 1e-9;
  MAXANP = 1000;
  NEED = 5;
  MAXSTART = 10;
  MAXLEN = 10;
type
	extended = double;
	frac = record
		a0:integer;
		anp,ap:integer;
		np,p:array[1..MAXANP] of integer;
		value:extended;
	end;
procedure out(f:frac);
var i:integer;
begin
with f do begin
  write('[');
  write(a0,';');
  for i:=1 to anp do write(np[i],',');
  write('(');
  for i:=1 to ap-1 do write(p[i],',');
  if (ap>0) then writeln(p[ap],')]') else writeln(')]');
end;
end;
function parse(s:shortstring):frac;
var i,it:integer;
begin
with result do begin
	delete(s,1,1);
	a0 := StrToInt(copy(s,1,pos(';',s)-1));
	delete(s,1,pos(';',s));
	anp := 0;
	ap :=0;
	while ((pos(',',s)<pos('(',s))and (pos(',',s)>0)) do begin
		inc(anp);
		np[anp] := StrToInt(copy(s,1,pos(',',s)-1));
		delete(s,1,pos(',',s));
	end;
{	inc(anp);
	np[anp] := StrToInt(copy(s,1,pos('(',s)-1));}
	delete(s,1,pos('(',s));

	while (pos(',',s)>0) do begin
		inc(ap);
		p[ap] := StrToInt(copy(s,1,pos(',',s)-1));
		delete(s,1,pos(',',s));
	end;
	inc(ap);
	p[ap] := StrToInt(copy(s,1,pos(')',s)-1));
	delete(s,1,pos(')',s));


	value:=1;
	for it:=1 to REPP do begin
		for i:=ap downto 1 do begin
			value := p[i]+1/(value);
		end;
	end;
	for i:=anp downto 1 do begin
		value := np[i]+1/(value);
	end;
	value := a0 + 1/value;
end;
end;
procedure fail;
begin
	writeln('Impossible');
	close(input);
	close(output);
	halt;
end;
function frc(a:extended):frac;
var start,len,i:integer;
ok:boolean;
begin
with result do begin
  anp := 0;
  ap := 0;
  a0 := round(int(a+EPS));
  a := 1/(a-a0);
  while ((a>EPS)and(anp<MAXANP)) do begin
{$IFDEF DEBUG}    writeln(a);{$ENDIF}
    inc(anp);
    np[anp] := round(int(a+EPS));
    a := 1/(a-np[anp]);
  end;
{$IFDEF DEBUG}  out(result);{$ENDIF}
  for start:=1 to MAXSTART do begin
    for len:=1 to MAXLEN do begin
      ok:=true;
      for i:=0 to NEED do begin
        if (np[start+i] <> np[start+len+i]) then begin
          ok:=false;
          break;
        end;
      end;
      if (ok) then begin
        anp := start-1;
        for i:=1 to len do p[i]:=np[start-1+i];
        ap := len;
        exit;
      end;
    end;
  end;
end;
fail;
end;
var
	s1,s2:string;
	f1,f2,f3:frac;
begin
	assign(input,'aplusb.in');
	reset(input);
{$IFNDEF DEBUG}
	assign(output,'aplusb.out');
	rewrite(output);
{$ENDIF}
	readln(s1);
	f1 := parse(s1);
	readln(s2);
	f2 := parse(s2);
  f3 :=frc(f1.value+f2.value);
{$IFDEF DEBUG}  writeln(f1.value);
  writeln(f2.value);
  writeln(f1.value+f2.value);{$ENDIF}
  out(f3);
	close(input);
	close(output);
end.
